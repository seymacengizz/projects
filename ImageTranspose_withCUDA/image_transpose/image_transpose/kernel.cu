
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <assert.h>
#pragma once
#ifdef __INTELLISENSE__
void __syncthreads();
#endif
using namespace cv;
using namespace std;
using namespace gpu;
// Convenience function for checking CUDA runtime API results
// can be wrapped around any runtime API call. No-op in release builds.
inline
cudaError_t checkCuda(cudaError_t result)
{
#if defined(DEBUG) || defined(_DEBUG)
	if (result != cudaSuccess) {
		fprintf(stderr, "CUDA Runtime Error: %s\n", cudaGetErrorString(result));
		assert(result == cudaSuccess);
	}
#endif
	return result;
}

const int TILE_DIM = 32;
const int BLOCK_ROWS = 8;
const int NUM_REPS = 100;

// Check errors and print GB/s
void postprocess(const uchar *ref, const uchar *res, int n, uchar ms)
{
	bool passed = true;
	for (int i = 0; i < n; i++)
		if (res[i] != ref[i]) {
			printf("%d %f %f\n", i, res[i], ref[i]);
			printf("%25s\n", "*** FAILED ***");
			passed = false;
			break;
		}
	if (passed)
		printf("%20.2f\n", 2 * n * sizeof(uchar) * 1e-6 * NUM_REPS / ms);
}

// simple copy kernel
// Used as reference case representing best effective bandwidth.
__global__ void copy(uchar *odata, const uchar *idata)
{
	int x = blockIdx.x * TILE_DIM + threadIdx.x;
	int y = blockIdx.y * TILE_DIM + threadIdx.y;
	int width = gridDim.x * TILE_DIM;

	for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
		odata[(y + j)*width + x] = idata[(y + j)*width + x];
}

// copy kernel using shared memory
// Also used as reference case, demonstrating effect of using shared memory.
__global__ void copySharedMem(uchar *odata, const uchar *idata)
{
	__shared__ uchar tile[TILE_DIM * TILE_DIM];

	int x = blockIdx.x * TILE_DIM + threadIdx.x;
	int y = blockIdx.y * TILE_DIM + threadIdx.y;
	int width = gridDim.x * TILE_DIM;

	for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
		tile[(threadIdx.y + j)*TILE_DIM + threadIdx.x] = idata[(y + j)*width + x];

	__syncthreads();

	for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
		odata[(y + j)*width + x] = tile[(threadIdx.y + j)*TILE_DIM + threadIdx.x];
}

// naive transpose
// Simplest transpose; doesn't use shared memory.
// Global memory reads are coalesced but writes are not.
__global__ void transposeNaive(uchar *odata, const uchar *idata)
{
	int x = blockIdx.x * TILE_DIM + threadIdx.x;
	int y = blockIdx.y * TILE_DIM + threadIdx.y;
	int width = gridDim.x * TILE_DIM;

	for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
		odata[x*width + (y + j)] = idata[(y + j)*width + x];

	//printf("\ndone...\n");
}

// coalesced transpose
// Uses shared memory to achieve coalesing in both reads and writes
// Tile width == #banks causes shared memory bank conflicts.
__global__ void transposeCoalesced(uchar *odata, const uchar *idata)
{
	__shared__ uchar tile[TILE_DIM][TILE_DIM];

	int x = blockIdx.x * TILE_DIM + threadIdx.x;
	int y = blockIdx.y * TILE_DIM + threadIdx.y;
	int width = gridDim.x * TILE_DIM;

	for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
		tile[threadIdx.y + j][threadIdx.x] = idata[(y + j)*width + x];

	__syncthreads();

	x = blockIdx.y * TILE_DIM + threadIdx.x;  // transpose block offset
	y = blockIdx.x * TILE_DIM + threadIdx.y;

	for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
		odata[(y + j)*width + x] = tile[threadIdx.x][threadIdx.y + j];
}


// No bank-conflict transpose
// Same as transposeCoalesced except the first tile dimension is padded 
// to avoid shared memory bank conflicts.
__global__ void transposeNoBankConflicts(uchar *odata, const uchar *idata)
{
	__shared__ uchar tile[TILE_DIM][TILE_DIM + 1];

	int x = blockIdx.x * TILE_DIM + threadIdx.x;
	int y = blockIdx.y * TILE_DIM + threadIdx.y;
	int width = gridDim.x * TILE_DIM;

	for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
		tile[threadIdx.y + j][threadIdx.x] = idata[(y + j)*width + x];

	__syncthreads();

	x = blockIdx.y * TILE_DIM + threadIdx.x;  // transpose block offset
	y = blockIdx.x * TILE_DIM + threadIdx.y;

	for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
		odata[(y + j)*width + x] = tile[threadIdx.x][threadIdx.y + j];

}

int main(int argc, char **argv)
{
	char FullFileName[100];
	char FirstFileName[100] = "C:\\Users\\user\\Desktop\\GPU Computing\\Lena.png";

	int FileNum = 96; //262; 
	printf("%s\n", FirstFileName);
	//read image file  
	Mat img, img_gray, img_gray1;
	Mat newImage;
	img = imread(FirstFileName);
	cvtColor(img, img_gray, CV_RGB2GRAY);
	uchar *data = img_gray.data;


	//GpuMat d_img(img_gray);
	//GpuMat d_outimg;

	const int nx = img_gray.rows;//1024
	const int ny = img_gray.cols;//1024
	const int mem_size = nx*ny*sizeof(uchar);


	dim3 dimGrid(nx / TILE_DIM, ny / TILE_DIM, 1);
	dim3 dimBlock(TILE_DIM, BLOCK_ROWS, 1);

	int devId = 0;
	if (argc > 1) devId = atoi(argv[1]);

	cudaDeviceProp prop;
	checkCuda(cudaGetDeviceProperties(&prop, devId));
	printf("\nDevice : %s\n", prop.name);
	printf("Matrix size: %d %d, Block size: %d %d, Tile size: %d %d\n",
		nx, ny, TILE_DIM, BLOCK_ROWS, TILE_DIM, TILE_DIM);
	printf("dimGrid: %d %d %d. dimBlock: %d %d %d\n",
		dimGrid.x, dimGrid.y, dimGrid.z, dimBlock.x, dimBlock.y, dimBlock.z);

	checkCuda(cudaSetDevice(devId));

	//uchar *h_idata = (uchar*)malloc(mem_size);
	uchar *h_cdata = (uchar*)malloc(mem_size);
	uchar *h_tdata = (uchar*)malloc(mem_size);
	uchar *gold = (uchar*)malloc(mem_size);
	Mat outImg, rgb_outImg;
	uchar *d_idata, *d_cdata, *d_tdata;

	checkCuda(cudaMalloc(&d_idata, mem_size));
	checkCuda(cudaMalloc(&d_cdata, mem_size));
	checkCuda(cudaMalloc(&d_tdata, mem_size));

	// check parameters and calculate execution configuration
	if (nx % TILE_DIM || ny % TILE_DIM) {
		printf("nx and ny must be a multiple of TILE_DIM\n");
		goto error_exit;
	}

	if (TILE_DIM % BLOCK_ROWS) {
		printf("TILE_DIM must be a multiple of BLOCK_ROWS\n");
		goto error_exit;
	}

	// host
	/*for (int j = 0; j < ny; j++)
	for (int i = 0; i < nx; i++)
	h_idata[j*nx + i] = j*nx + i;*/

	// correct result for error checking
	for (int j = 0; j < ny; j++)
		for (int i = 0; i < nx; i++)
			gold[j*nx + i] = img_gray.data[i*nx + j];

	//// device
	checkCuda(cudaMemcpy(d_idata, img_gray.data, mem_size, cudaMemcpyHostToDevice));

	// events for timing
	cudaEvent_t startEvent, stopEvent;
	checkCuda(cudaEventCreate(&startEvent));
	checkCuda(cudaEventCreate(&stopEvent));
	float ms;

	// ------------
	// time kernels
	// ------------
	printf("\n%25s%25s\n", "Routine", "Bandwidth (GB/s)");

	// ----
	// copy 
	// ----
	printf("%25s", "copy");
	checkCuda(cudaMemset(d_cdata, 0, mem_size));
	// warm up
	//copy << <dimGrid, dimBlock >> >(d_cdata, d_idata);
	checkCuda(cudaEventRecord(startEvent, 0));
	for (int i = 0; i < NUM_REPS; i++)
		copy << <dimGrid, dimBlock >> >(d_cdata, d_idata);
	checkCuda(cudaEventRecord(stopEvent, 0));
	checkCuda(cudaEventSynchronize(stopEvent));
	checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
	checkCuda(cudaMemcpy(h_cdata, d_cdata, mem_size, cudaMemcpyDeviceToHost));
	postprocess(img_gray.data, h_cdata, nx*ny, ms);

	/* -------------
	copySharedMem
	-------------*/
	printf("%25s", "shared memory copy");
	checkCuda(cudaMemset(d_cdata, 0, mem_size));
	// warm up
	copySharedMem << <dimGrid, dimBlock >> >(d_cdata, d_idata);
	checkCuda(cudaEventRecord(startEvent, 0));
	for (int i = 0; i < NUM_REPS; i++)
		copySharedMem << <dimGrid, dimBlock >> >(d_cdata, d_idata);
	checkCuda(cudaEventRecord(stopEvent, 0));
	checkCuda(cudaEventSynchronize(stopEvent));
	checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
	checkCuda(cudaMemcpy(h_cdata, d_cdata, mem_size, cudaMemcpyDeviceToHost));
	postprocess(img_gray.data, h_cdata, nx * ny, ms);

	// --------------
	// transposeNaive 
	// --------------
	printf("%25s", "naive transpose");
	checkCuda(cudaMemset(d_tdata, 0, mem_size));
	////warmup
	transposeNaive << <dimGrid, dimBlock >> >(d_tdata, d_idata);
	checkCuda(cudaEventRecord(startEvent, 0));
	for (int i = 0; i < NUM_REPS; i++)
		transposeNaive << <dimGrid, dimBlock >> >(d_tdata, d_idata);
	checkCuda(cudaEventRecord(stopEvent, 0));
	checkCuda(cudaEventSynchronize(stopEvent));
	checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
	checkCuda(cudaMemcpy(h_tdata, d_tdata, mem_size, cudaMemcpyDeviceToHost));
	//outImg = Mat(nx, ny, CV_8UC1, h_tdata);
	////outImg.data = h_tdata;
	////show image  
	//imshow("origin", outImg);
	//waitKey(0);
	//imwrite("C:\\Users\\user\\Desktop\\tImg1.png", outImg);
	postprocess(gold, h_tdata, nx * ny, ms);

	// ------------------
	// transposeCoalesced 
	// ------------------
	printf("%25s", "coalesced transpose");
	checkCuda(cudaMemset(d_tdata, 0, mem_size));
	// warmup
	transposeCoalesced << <dimGrid, dimBlock >> >(d_tdata, d_idata);
	checkCuda(cudaEventRecord(startEvent, 0));
	for (int i = 0; i < NUM_REPS; i++)
		transposeCoalesced << <dimGrid, dimBlock >> >(d_tdata, d_idata);
	checkCuda(cudaEventRecord(stopEvent, 0));
	checkCuda(cudaEventSynchronize(stopEvent));
	checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
	checkCuda(cudaMemcpy(h_tdata, d_tdata, mem_size, cudaMemcpyDeviceToHost));
	outImg = Mat(nx, ny, CV_8UC1, h_tdata);


	postprocess(gold, h_tdata, nx * ny, ms);

	// ------------------------
	// transposeNoBankConflicts
	// ------------------------
	printf("%25s", "conflict-free transpose");
	checkCuda(cudaMemset(d_tdata, 0, mem_size));
	// warmup
	transposeNoBankConflicts << <dimGrid, dimBlock >> >(d_tdata, d_idata);
	checkCuda(cudaEventRecord(startEvent, 0));
	for (int i = 0; i < NUM_REPS; i++)
		transposeNoBankConflicts << <dimGrid, dimBlock >> >(d_tdata, d_idata);
	checkCuda(cudaEventRecord(stopEvent, 0));
	checkCuda(cudaEventSynchronize(stopEvent));
	checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
	checkCuda(cudaMemcpy(h_tdata, d_tdata, mem_size, cudaMemcpyDeviceToHost));
	postprocess(gold, h_tdata, nx * ny, ms);

	//resizing 
	resize(img_gray, img_gray, Size(512, 512));
	resize(outImg, outImg, Size(512, 512));
	hconcat(img_gray, outImg, newImage);
	imshow("Display side by side", newImage);
	waitKey(0);
	//imwrite("C:\\Users\\user\\Desktop\\newImage.png", newImage);
error_exit:
	// cleanup
	checkCuda(cudaEventDestroy(startEvent));
	checkCuda(cudaEventDestroy(stopEvent));
	checkCuda(cudaFree(d_tdata));
	checkCuda(cudaFree(d_cdata));
	checkCuda(cudaFree(d_idata));
	//free(h_idata);
	free(h_tdata);
	free(h_cdata);
	free(gold);

}