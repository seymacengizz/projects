package genericStringTextAnalyzer;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class FeatureExtracter {
	public List<String> extractFeatures(String sentence) {
		sentence = sentence.toLowerCase();
		
		sentence = sentence.replaceAll("<br/>", "");
		sentence = sentence.replaceAll("<br />", "");
		sentence = sentence.replaceAll("\\.", "");
		sentence = sentence.replaceAll("\\,", "");
		sentence = sentence.replaceAll("\\?", "");
		
		
		StringTokenizer tokenizer = new StringTokenizer(sentence, " ");
		
		List<String> features = new ArrayList<String>();
		
		while(tokenizer.hasMoreTokens())
		{
			String feature = tokenizer.nextToken();
			if(!feature.equals(""))
			{
				features.add(feature);
			}
		}

		return features;
	}
}
