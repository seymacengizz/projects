% %% Initialization
% clear ; close all; clc

%# Read annd Prepare Data
mainFolder = 'C:\Users\user\Desktop\ML Project\ML_Project_HeartAttack\Heart_Datasets';
datasetName = 'dataset1.txt';
fileName = fullfile(mainFolder, datasetName);
inputNames = {'age','sex','chestPainType','restingBloodPressure','serumCholestoral','bloodSugar','electrocardiographicResults','maximumHeartRate','exerciseInducedAngina','oldpeak','slope','majorVessels','thal'};
outputNames ={'HeartDisease'};
heartDiseaseAttributes = [inputNames,outputNames];
formatSpec = '%8f%7f%8f%8f%8f%8f%7f%8f%4f%7f%7f%7f%7f%f%[^\n\r]';
fileID = fopen(fileName,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '',  'ReturnOnError', false);
fclose(fileID);
heartDisease = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3','VarName4','VarName5','VarName6','VarName7','VarName8','VarName9','VarName10','VarName11','VarName12','VarName13','VarName14'});
heartDisease.Properties.VariableNames = heartDiseaseAttributes;
x_heartData = heartDisease{:,inputNames};
y_target = heartDisease{:,outputNames};
rng(5);

%# SVM classification in Matlab
[~,~,labels]            = unique(y_target);            % Labels: 1/2
data                    = zscore(x_heartData);         % Scale features
numInst                 = size(data,1);
numLabels               = max(labels);
[V D] = eig(cov(data));
diag(D);
[evectors, score, evalues] = princomp(data);
plot(score(:,1),score(:,2),'+');
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
percent_explained = 100*evalues/sum(evalues);
pareto(percent_explained);
xlabel('Principal Component')
ylabel('Variance Explained (%)')
%display the eigenvalues
normalised_evalues = evalues / sum(evalues);
figure, plot(cumsum(normalised_evalues));
xlabel('No. of eigenvectors'), 
ylabel('Variance accounted for');
xlim([1 30]), ylim([0 1]), grid on;,
%I decided to chosee the number of eigendata as 7 which is the best explaining the variance
num_eigendata = 7;
evectors = evectors(:, 1:num_eigendata);
features = data*evectors;

%# Split training/testing
idx                     = randperm(numInst);
numTrain                = 216;
numTest                 = numInst - numTrain;

trainData               = features(idx(1:numTrain),:);  
testData                = features(idx(numTrain+1:end),:);
trainLabel              = labels(idx(1:numTrain)); 
testLabel               = labels(idx(numTrain+1:end));
trainIndex              = zeros(numInst,1); 
trainIndex(1:numTest)   = 1;
testIndex               = zeros(numInst,1); 
testIndex(numTest+1:numInst)= 1;

%# Train one-over-one models
model   = cell(numLabels,1);
model   = svmtrain(trainLabel, trainData, '-c 1 -g 0.2 -b 1');

%# Use the SVM model to classify the data
[predict_label, accuracy, prob_values] = svmpredict(testLabel, testData, model, '-b 1'); % run the SVM model on the test data
  
%# Confusion matrix
 C     = confusionmat(testLabel, predict_label);   
 
% ================================
% ===== Showing the results ======
% ================================
% Assign color for each class
% colorList = generateColorList(2); % This is my own way to assign the color...don't worry about it
colorList = prism(100);

%#true (ground truth) class
trueClassIndex = zeros(numInst,1);
trueClassIndex(labels==1) = 1;
trueClassIndex(labels==2) = 2;
colorTrueClass = colorList(trueClassIndex,:);

%#Result Class
resultClassIndex = zeros(length(predict_label),1);
resultClassIndex(predict_label==1) = 1;
resultClassIndex(predict_label==2) = 2;
colorResultClass = colorList(resultClassIndex,:);

%#Reduce the dimension from 13D to 2D
distanceMatrix = pdist(data,'euclidean');
% newCoor = mdscale(distanceMatrix,2);
newCoor = mdscale(distanceMatrix,2);
%#Plot the whole data set
x = newCoor(:,1);
y = newCoor(:,2);
patchSize = 30;%max(prob_values,[],2)
colorTrueClassPlot = colorTrueClass;
figure; scatter(x,y,patchSize,colorTrueClassPlot,'filled');
title('whole data set');,

%#Plot the test data
x = newCoor(testIndex==1,1);
y = newCoor(testIndex==1,2);
patchSize = 80*max(prob_values,[],2);
colorTrueClassPlot = colorTrueClass(testIndex==1,:);
figure; hold on;
scatter(x,y,2*patchSize,colorTrueClassPlot,'o','red','filled');
scatter(x,y,patchSize,colorResultClass,'o','blue','filled');

%#Plot the training set
x = newCoor(trainIndex==1,1);
y = newCoor(trainIndex==1,2);
patchSize = 30;
colorTrueClassPlot = colorTrueClass(trainIndex==1,:);
scatter(x,y,patchSize,colorTrueClassPlot,'o','green');
title('classification results');
% The unfilled markers represent data instance from the train set. 
% The filled markers represent data instance from the test set, and 
% filled color represents the class label assigned by SVM whereas 
% the edge color represents the true (ground-truth) label. 
% The marker size of the test set represents the probability 
% that the sample instance is assigned with its corresponding class label;
% the bigger, the more confidence.