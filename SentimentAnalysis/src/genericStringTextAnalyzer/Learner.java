package genericStringTextAnalyzer;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Learner {

	private List<HashMap<String, Integer>> featureCountMapsForEachLabel = new ArrayList<HashMap<String, Integer>>();

	private long[] totalFeatures;
	private long[] totalInstances;

	private String[] categories;
	private String[] datasets;
	
	private FeatureExtracter extracter;

	public Learner(String[] categories, String[] datasets, FeatureExtracter extracter) {
		this.setCategories(categories);
		this.setDatasets(datasets);
		setTotalFeatures(new long[datasets.length]);
		setTotalInstances(new long[datasets.length]);
		this.extracter = extracter;
		
		for(int i = 0; i < this.getCategories().length; i++)
		{
			getFeatureCountMapsForEachLabel().add(new HashMap<String, Integer>());
		}
		
	}

	public void train() throws IOException {
		for(int i = 0; i < getCategories().length; i++)
		{
			computeVariables(getDatasets()[i], getFeatureCountMapsForEachLabel().get(i), i);
		}
	}

	private void computeVariables(String dataset, HashMap<String, Integer> map, int featureCountIndex) throws IOException {

		File folder = new File(dataset);
		File[] listOfFiles = folder.listFiles();

		for (int i = 0; i < listOfFiles.length; i++) {
			if (listOfFiles[i].isFile()) {

				String content = readFile(listOfFiles[i]);
				
				List<String> features = extracter.extractFeatures(content);
				
				for(String feature : features)
				{
					Integer count = map.get(feature);
					
					if(count == null)
					{
						count = 0;
					}
					
					count++;
					
					map.put(feature, count);
					
					getTotalFeatures()[featureCountIndex]++;
				}
				
				getTotalInstances()[featureCountIndex]++;
				
			}
		}

	}

	private String readFile(File file) throws IOException {
		
		BufferedReader reader = new BufferedReader(new FileReader(file));
		
		String line = null;
		
		StringBuilder stringBuilder = new StringBuilder();
		
		String ls = System.getProperty("line.separator");

		while ((line = reader.readLine()) != null) {
			stringBuilder.append(line);
			stringBuilder.append(ls);
		}
		reader.close();

		return stringBuilder.toString();
	}
	

	public List<HashMap<String, Integer>> getFeatureCountMapsForEachLabel() {
		return featureCountMapsForEachLabel;
	}

	public void setFeatureCountMapsForEachLabel(
			List<HashMap<String, Integer>> featureCountMapsForEachLabel) {
		this.featureCountMapsForEachLabel = featureCountMapsForEachLabel;
	}

	public long[] getTotalFeatures() {
		return totalFeatures;
	}

	public void setTotalFeatures(long[] totalFeatures) {
		this.totalFeatures = totalFeatures;
	}

	public String[] getCategories() {
		return categories;
	}

	public void setCategories(String[] categories) {
		this.categories = categories;
	}

	public String[] getDatasets() {
		return datasets;
	}

	public void setDatasets(String[] datasets) {
		this.datasets = datasets;
	}

	public long[] getTotalInstances() {
		return totalInstances;
	}

	public void setTotalInstances(long[] totalInstances) {
		this.totalInstances = totalInstances;
	}
}
