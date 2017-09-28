%# load data
mainFolder = 'C:\Users\user\Desktop\ML Project\ML_Project_HeartAttack\Project_Codes\HeartAttack_IremCode';
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

%# Split training/testing
idx                     = randperm(numInst);
numTrain                = 216;
numTest                 = numInst - numTrain;
trainIndex              = zeros(numInst,1);
trainIndex(1:numTrain)  = 1;
testIndex               = zeros(numInst,1);
testIndex(numTrain+1:numInst)  = 1;
trainData               = data(idx(1:numTrain),:);  
testData                = data(idx(numTrain+1:end),:);
trainLabel              = labels(idx(1:numTrain)); 
testLabel               = labels(idx(numTrain+1:end));

%# train classification decision tree
% t1 = fitctree(trainData, trainLabel, 'PredictorNames',inputNames, ...
%     'CategoricalPredictors',{'sex','chestPainType','bloodSugar','electrocardiographicResults','exerciseInducedAngina','slope','majorVessels','thal' }, 'Prune','off');
t1 = fitctree(trainData, trainLabel);
view(t1, 'mode','graph')

%# test
b_hat = predict(t1, testData);
cm = confusionmat(testLabel,b_hat) 


%# testing error
N1 = sum(cm(:));
err1 = ( N1-sum(diag(cm)) ) / N1;

%# prune tree to avoid overfitting
% tt1 = prune(t1, 'Level',3);
% view(tt1);

%# predict a new unseen instance
% predict(tt1, [111 25.7 191 113.1 100 0 3 1]) %# pred = 1 correct answer=1
% predict(t1, [67 1 4 120 229 0 2 129 1 2,6 2 2 7]) %# pred = 0 correct answer =1
predict(t1, [67.0 1.0 4.0 120.0 229.0 0.0 2.0 129.0 1.0 2.6 2.0 2.0 7.0])