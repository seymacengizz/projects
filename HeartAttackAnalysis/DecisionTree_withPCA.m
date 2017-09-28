folder = 'C:\Users\user\Desktop\ML Project\ML_Project_HeartAttack\Project_Codes\HeartAttack_IremCode';
baseFileName = 'dataset1.txt';
filename = fullfile(folder, baseFileName);
inputNames = {'age','sex','chestPainType','restingBloodPressure','serumCholestoral','bloodSugar','electrocardiographicResults','maximumHeartRate','exerciseInducedAngina','oldpeak','slope','majorVessels','thal'};
outputNames ={'HeartDisease'};
heartDiseaseAttributes = [inputNames,outputNames];
formatSpec = '%8f%7f%8f%8f%8f%8f%7f%8f%4f%7f%7f%7f%7f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '',  'ReturnOnError', false);
fclose(fileID);
heartDisease = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','VarName2','VarName3','VarName4','VarName5','VarName6','VarName7','VarName8','VarName9','VarName10','VarName11','VarName12','VarName13','VarName14'});
heartDisease.Properties.VariableNames = heartDiseaseAttributes;
X = heartDisease{:,inputNames};
y = heartDisease{:,outputNames};
rng(5); % For reproducibility

% Set aside 90% of the data for training
% cv = cvpartition(height(heartDisease),'holdout',0.1);
% 
% t = RegressionTree.template('MinLeaf',5);
% mdl = fitensemble(X(cv.training,:),y(cv.training,:),'LSBoost',500,t,'PredictorNames',inputNames,'ResponseName',outputNames{1},'LearnRate',0.01);
% 
% L = loss(mdl,X(cv.test,:),y(cv.test),'mode','ensemble');
% fprintf('Mean-square testing error = %f\n',L);
% figure(1);
% % plot([y(cv.training), predict(mdl,X(cv.training,:))],'LineWidth',2);
% plot(y(cv.training),'b','LineWidth',2), hold on

%# SVM classification in Matlab
[~,~,labels]            = unique(y);            % Labels: 1/2
data                    = zscore(X);         % Scale features
numInst                 = size(data,1);
numLabels               = max(labels);

%reducing size with PCA
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
trainIndex              = zeros(numInst,1);
trainIndex(1:numTrain)  = 1;
testIndex               = zeros(numInst,1);
testIndex(numTrain+1:numInst)  = 1;
trainData               = features(idx(1:numTrain),:);  
testData                = features(idx(numTrain+1:end),:);
trainLabel              = labels(idx(1:numTrain)); 
testLabel               = labels(idx(numTrain+1:end));

% a=predict(mdl,mdl.X);
% cm = confusionmat(mdl.Y,a);
% plot(predict(mdl,X(cv.training,:)),'r.-','LineWidth',1,'MarkerSize',15)

% t = RegressionTree.template('MinLeaf',5);
% mdl = fitensemble(data,labels,'LSBoost',500,t,'PredictorNames',inputNames,'ResponseName',outputNames{1},'LearnRate',0.01);
t1 = fitctree(trainData, trainLabel);
a=predict(t1,testData);
cm = confusionmat(testLabel,a)

%  plot(predict(mdl,data)),'r.-','LineWidth',1,'MarkerSize',15)


% Observe first hundred points, pan to view more
% xlim([0 100])
% legend({'Actual','Predicted'})
% xlabel('Training Data point');
% ylabel('Median  heart disease');
% [predictorImportance,sortedIndex] = sort(mdl.predictorImportance);
% figure(2);
% barh(predictorImportance)
% set(gca,'ytickLabel',inputNames(sortedIndex))
% xlabel('Predictor Importance')
% figure(3);
% trainingLoss = resubLoss(mdl,'mode','cumulative');
% 
% testLoss = loss(mdl,X(cv.test,:),y(cv.test),'mode','cumulative');
% plot(trainingLoss), hold on
% plot(testLoss,'r')
% legend({'Training Set Loss','Test Set Loss'})
% xlabel('Number of trees');
% ylabel('Mean Squared Error');
% set(gcf,'Position',[249 634 1009 420])