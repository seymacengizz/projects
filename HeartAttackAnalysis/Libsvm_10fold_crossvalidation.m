
%# Read annd Prepare Data
mainFolder = 'C:\Users\user\Desktop\ML Project\ProjeDosyasý\ProjeDosyasý';
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
%numInst                 = size(data,1);
numLabels               = max(labels);

n = size(data,1);
ns = floor(n/10);

for fold=1:10,
    if fold==1,
        testindices= ((fold-1)*ns+1):fold*ns;
        trainindices = fold*ns+1:n;
    else
        if fold==10,
            testindices= ((fold-1)*ns+1):n;
            trainindices = 1:(fold-1)*ns;
        else
            testindices= ((fold-1)*ns+1):fold*ns;
            trainindices = [1:(fold-1)*ns,fold*ns+1:n];
         end
    end
    % use testindices only for testing and train indices only for testing
    trainLabel = labels(trainindices);
    trainData = data(trainindices,:);
    testLabel = labels(testindices);
    testData = data(testindices,:)
    
    %# Train one-over-one models
    model   = cell(numLabels,1);
    % do_binary_cross_validation(trainLabel, trainData, '-c 8 -g 4', 5);
    % model = svmtrain(trainLabel, trainData);
    % [predict_label eval_ret dec] = do_binary_predict(testLabel, testData, model);
    model   = svmtrain(trainLabel, trainData, '-c 1 -g 0.2 -b 1');

    %# Use the SVM model to classify the data
    [predict_label, accuracy, prob_values] = svmpredict(testLabel, testData, model, '-b 1'); % run the SVM model on the test data

    %# Confusion matrix
    C     = confusionmat(testLabel, predict_label)   

    
    
    
%     %# train one-against-all models
%     model = cell(numLabels,1);
%     for k=1:numLabels
%         model{k} = svmtrain(double(trainLabel==k), trainData, '-c 1 -g 0.2 -b 1');
%     end
% 
%     %# get probability estimates of test instances using each model
%     prob = zeros(size(testData,1),numLabels);
%     for k=1:numLabels
%         [~,~,p] = svmpredict(double(testLabel==k), testData, model{k}, '-b 1');
%         prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
%     end
% 
%     %# predict the class with the highest probability
%     [~,pred] = max(prob,[],2);
%     acc = sum(pred == testLabel) ./ numel(testLabel)    %# accuracy
%     C = confusionmat(testLabel, pred)                   %# confusion matrix
end