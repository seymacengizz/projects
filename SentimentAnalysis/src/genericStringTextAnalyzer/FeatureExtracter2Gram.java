package genericStringTextAnalyzer;

import java.util.ArrayList;
import java.util.List;

public class FeatureExtracter2Gram extends FeatureExtracter {
	public List<String> extractFeatures(String sentence) {
		
		
		List<String> features = super.extractFeatures(sentence);
		
		List<String> newFeatures = new ArrayList<String>();
		
		for(int i = 1; i < features.size(); i++)
		{
			newFeatures.add(features.get(i-1) + " " + features.get(i));
		}
		newFeatures.add(features.get(features.size() - 1) + " ~END~");
		
		return newFeatures;
	}
}
