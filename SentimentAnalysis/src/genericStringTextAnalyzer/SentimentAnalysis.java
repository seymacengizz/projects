package genericStringTextAnalyzer;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;

public class SentimentAnalysis {

	private List<HashMap<String, Integer>> features;
	private long[] featureCounts;
	private long[] instanceCounts;
	private String[] categories;

	private FeatureExtracter extracter;

	public SentimentAnalysis(List<HashMap<String, Integer>> features,
			long[] featureCounts, long[] instanceCounts, String[] categories,
			FeatureExtracter extracter) {

		this.features = features;
		this.featureCounts = featureCounts;
		this.instanceCounts = instanceCounts;
		this.categories = categories;
		this.extracter = extracter;
	}

	public String decide(String sentence) {

		long totalInstanceCounts = 0;
		for (int i = 0; i < categories.length; i++) {
			totalInstanceCounts += instanceCounts[i];
		}

		double scores[] = new double[categories.length];
		for (int i = 0; i < categories.length; i++) {

			List<String> featuresFromSentence = extracter
					.extractFeatures(sentence);

			for (String feature : featuresFromSentence) {
				
				int count;
				
				if (features.get(i).get(feature) != null) {
					count = features.get(i).get(feature);
				} else {
					count = 1;
				}

				scores[i] += Math.log(1.0 * count / featureCounts[i]);
			}

			scores[i] += Math
					.log(1.0 * instanceCounts[i] / totalInstanceCounts);
		}

		int index = findMaxIndex(scores);

		return categories[index];
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

	public double test(String[] paths) throws Exception {
		double correctNum = 0;
		double totalNum = 0;

		for (int i = 0; i < paths.length; i++) {
			File folder = new File(paths[i]);
			File[] listOfFiles = folder.listFiles();

			for (int j = 0; j < listOfFiles.length; j++) {

				if (listOfFiles[j].isFile()) {

					String content = readFile(listOfFiles[j]);

					String result = decide(content);
					System.out.println(content + " " + categories[i] + " "
							+ result);
					if (result.equals(categories[i])) {
						correctNum++;
					}

					totalNum++;

				}
			}
		}

		return correctNum / totalNum;

	}

	private int findMaxIndex(double[] scores) {

		double max = scores[0];
		int maxIndex = 0;
		for (int i = 0; i < scores.length; i++) {
			if (scores[i] > max) {
				maxIndex = i;
				max = scores[i];
			}
		}

		return maxIndex;
	}

	public List<HashMap<String, Integer>> getFeatures() {
		return features;
	}

	public void setFeatures(List<HashMap<String, Integer>> features) {
		this.features = features;
	}

	public long[] getFeatureCounts() {
		return featureCounts;
	}

	public void setFeatureCounts(long[] featureCounts) {
		this.featureCounts = featureCounts;
	}

	public long[] getInstanceCounts() {
		return instanceCounts;
	}

	public void setInstanceCounts(long[] instanceCounts) {
		this.instanceCounts = instanceCounts;
	}

	public String[] getCategories() {
		return categories;
	}

	public void setCategories(String[] categories) {
		this.categories = categories;
	}

	public static void main(String args[]) throws Exception {

		FeatureExtracter extracter = new FeatureExtracter2Gram();

		Learner learner = new Learner(new String[] { "POS", "NEG" },
				new String[] { "./pos", "./neg" }, extracter);

		learner.train();

		SentimentAnalysis analysis = new SentimentAnalysis(
				learner.getFeatureCountMapsForEachLabel(),
				learner.getTotalFeatures(), learner.getTotalInstances(),
				learner.getCategories(), extracter);
		//
		 System.out
		 .println(analysis.test(new String[] { "./pos_t", "./neg_t" }));

		while (true) {
			BufferedReader br = new BufferedReader(new InputStreamReader(
					System.in));
			System.out.print("Enter String\n");
			String s = br.readLine();
			System.out.println(analysis.decide(s));
		}

	}
}
