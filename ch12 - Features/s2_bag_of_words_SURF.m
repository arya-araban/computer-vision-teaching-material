%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Classification using Bag of Visual Words                      %
%                                                                         %                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear Variables, Close Current Figures, and Create Results Directory 
clc; clear all; close all;

%% Configurations
classes = {'headphone', 'soccer_ball' , 'watch'}; % Should be sorted alphapetically to match test data automatic labeling by folder
trainingDataSizePercent = 30; % How much percentage of the data is for training, the rest is for validation
numberOfClusters = 500; % The number of clusters representing the number of features in the bag of features. Default can be 500.
ratioOfStrongFeatures = 0.8; % Default can be 0.8
SVM_Kernel = 'rbf'; % Can be either 'polynomial' or 'rbf' for example.
SVM_C = 0.1; % Smaller is less overfitting. Default can be 0.1.


%% Load Image Datastore and make them of equal size (size of class with lowest number of images)
imgSets = [];
for i = 1:length(classes)
    imgSets = [ imgSets, imageSet(fullfile('BoW/101_ObjectCategories', classes{i})) ];
end

% Balance the data count between of all classes
minClassCount = min([imgSets.Count]);
imgSets = partition(imgSets, minClassCount, 'sequential'); % Or 'randomize'

%% Prepare Training and Validation Image Sets
[trainingSets, validationSets] = partition(imgSets, trainingDataSizePercent/100, 'sequential'); % Or 'randomize'

%% Forming Bag of Features
% Extracts SURF features from all training images &
% reducing the number of features through quantization of feature space using K-means clustering
bag = bagOfFeatures(trainingSets, 'StrongestFeatures', ratioOfStrongFeatures, 'VocabularySize', numberOfClusters);



%% Train SVM Classifier

%opts = templateSVM('KernelFunction', SVM_Kernel, 'BoxConstraint', SVM_C);
opts = templateSVM('KernelFunction', 'rbf');
classifier = trainImageCategoryClassifier(trainingSets, bag, 'LearnerOptions', opts);
    
%% Evaluate the classifier on training then validation data
disp('---EVALUATING CLASSIFIER ON TRAINING SET---');
confMatrix_train = evaluate(classifier, trainingSets);
disp('---EVALUATING CLASSIFIER ON VALIDATION SET---');
confMatrix_val = evaluate(classifier, validationSets);

tran_val_avg_accuracy = (mean(diag(confMatrix_val)) + mean(diag(confMatrix_train))) / 2; % This information should be used to tweak the system parameters for better accuracy
display(['The training and validation average accuracy is ' num2str(tran_val_avg_accuracy) '.']);

%% Deployment (test the system on newly unseen images)
testSet = imageSet('BoW/Test_Data', 'recursive');
disp('---EVALUATING CLASSIFIER ON TEST SET---');
confMatrix_test = evaluate(classifier, testSet);
test_accuracy = mean(diag(confMatrix_test));
display(['The test accuracy is ' num2str(test_accuracy) '.']);
