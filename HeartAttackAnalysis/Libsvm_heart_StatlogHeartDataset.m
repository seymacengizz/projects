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

% SVM classification in Matlab

[~,~,labels]            = unique(y_target);            % Labels: 1/2
data                    = zscore(x_heartData);         % Scale features
numInst                 = size(data,1);
numLabels               = max(labels);

%# Split training/testing
idx                     = randperm(numInst);
numTrain                = 216;
numTest                 = numInst - numTrain;
trainData               = data(idx(1:numTrain),:);  
testData                = data(idx(numTrain+1:end),:);
trainLabel              = labels(idx(1:numTrain)); 
testLabel               = labels(idx(numTrain+1:end));

%# Train one-against-all models
model                   = cell(numLabels,1);
for k=1:numLabels
    model{k}            = svmtrain(double(trainLabel==k), trainData, '-c 1 -g 0.2 -b 1');
end

 %# Get probability estimates of test instances using each model
prob                    = zeros(numTest,numLabels);
for k=1:numLabels
    [~,~,p]             = svmpredict(double(testLabel==k), testData, model{k}, '-b 1');
    prob(:,k)           = p(:,model{k}.Label==1);    % Probability of class==k
end

% Predict the class with the highest probability
[~,pred]                = max(prob,[],2);
acc                     = sum(pred == testLabel) ./ numel(testLabel);    % Accuracy
C                       = confusionmat(testLabel, pred);                 % Confusion matrix