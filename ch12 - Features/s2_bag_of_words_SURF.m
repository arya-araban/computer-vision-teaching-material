%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Classification using Bag of Visual Words                      %
%                                                                         %
% Copyright (C) 03-2017 Hesham M. Eraqi. All rights reserved.             %
%                    hesham.eraqi@gmail.com                               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear Variables, Close Current Figures, and Create Results Directory 
clc; clear all; close all;
mkdir('BoW/Results//'); %Directory for Storing Results

%% Configurations
classes = {'headphone', 'soccer_ball' , 'watch'}; % Should be sorted alphapetically to match test data automatic labeling by folder
trainingDataSizePercent = 30; % How much percentage of the data is for training, the rest is for validation
numberOfClusters = 500; % The number of clusters representing the number of features in the bag of features. Default can be 500.
ratioOfStrongFeatures = 0.8; % Default can be 0.8
SVM_Kernel = 'rbf'; % Can be either 'polynomial' or 'rbf' for example.
SVM_C = 0.1; % Smaller is less overfitting. Default can be 0.1.
SVM_RBF_Gamma = 0.6; % The RBF SVM Kernel gamma. The higher the more complex model, and more prune to overfitting. Default can be 0.6.
visualize_train_val_data = 0; % Boolean (0 or 1) to visualize training and validation data
visualize_sample_FV = 0;
visualize_test_data = 0;

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

%% Visulizing Training and Validation Data (Press any key to procceed to next figure)
if (visualize_train_val_data)
    data = {trainingSets, validationSets};
    for d = length(data)
        for i=1:data{d}(1).Count
            for c=1:length(classes)
                subplot(1,length(classes),c);
                imshow(read(data{d}(c),i));
            end
            title(['Sample ' int2str(i) ' out of ' int2str(data{d}(1).Count)]);
            saveas(gcf,['BoW/Results//TrainValData-Img' int2str(d) '-' int2str(i) '.png']);
%             pause;
        end
    end
end

%% Forming Bag of Features
% Extracts SURF features from all training images &
% reducing the number of features through quantization of feature space using K-means clustering
bag = bagOfFeatures(trainingSets, 'StrongestFeatures', ratioOfStrongFeatures, 'VocabularySize', numberOfClusters);

%% Visulize a feature vector
if (visualize_sample_FV)
    figure;
    img = read(imgSets(1), 1); % First image of first class as an example
    featureVector = encode(bag, img);

    % Plot the histogram of visual word occurrences
    figure;
    bar(featureVector);
    title('Visual word occurrences');
    xlabel('Visual word index');
    ylabel('Frequency of occurrence');
    saveas(gcf,['BoW/Results//TrainData-SampleFeatureVector.png']);
end

%% Train SVM Classifier
% opts = templateSVM('KernelFunction', 'rbf', 'BoxConstraint', SVM_C, 'kernelScale', SVM_RBF_Gamma);
opts = templateSVM('KernelFunction', SVM_Kernel, 'BoxConstraint', SVM_C);
% opts = templateSVM('KernelFunction', 'rbf');
classifier = trainImageCategoryClassifier(trainingSets, bag, 'LearnerOptions', opts);
    
%% Evaluate the classifier on training then validation data
confMatrix_train = evaluate(classifier, trainingSets);
confMatrix_val = evaluate(classifier, validationSets);
tran_val_avg_accuracy = (mean(diag(confMatrix_val)) + mean(diag(confMatrix_train))) / 2; % This information should be used to tweak the system parameters for better accuracy

display(['The training and validation average accuracy is ' num2str(tran_val_avg_accuracy) '.']);

%% Deployment (test the system on newly unseen images)
testSet = imageSet('BoW/Test_Data', 'recursive');
randomSet = testSet(2);
testSet(2) = [];
confMatrix_test = evaluate(classifier, testSet);
test_accuracy = mean(diag(confMatrix_test));
display(['The test accuracy is ' num2str(test_accuracy) '.']);

if (visualize_test_data)
    figure;
    for i=1:testSet(1).Count
        for c=1:length(classes)
            subplot(1,length(classes),c);
            imshow(read(testSet(c),i));
        end
        suptitle(['Sample ' int2str(i) ' out of ' int2str(testSet(1).Count)]);
%         pause;
        saveas(gcf,['BoW/Results//TestData-Img' int2str(i) '.png']);
    end
end

%% Test random data (images that do not contain any of the trained classes)
if (visualize_test_data)
    figure;
end
for i = 1:randomSet.Count
    img = read(randomSet,i);
    [labelIdx, scores] = predict(classifier, img);
    class_label = classifier.Labels(labelIdx); % Display the string label
    
    if (visualize_test_data)
        subplot(2,3,i);
        imshow(img);
        title(['Classified as ' strrep(class_label{1}, '_', '\_')]);
%         pause;
    end
end
if (visualize_test_data)
    saveas(gcf,['BoW/Results//TestRandomData.png']);
end