%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

prediction_value= zeros(1,size(xtest,2));
%% Testing the network
% Modify the code to get the confusion matrix

 for i=1:100:size(xtest, 2)
     [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
     [max_value, out_put] = max(P, [], 1);%max value is the max number in the P in which we need to find the index for it's corsponding number
     prediction_value(:, i:i+99) = out_put;% set the prediction_value at i
 end
confution_result = confusionmat(ytest, prediction_value);
confusionchart(confution_result, [0:9])