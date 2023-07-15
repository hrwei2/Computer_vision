layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);

img = reshape(img, 28, 28);


figure();
title("original image")
imshow(img)
%% 

%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
data = reshape(output{2}.data,output{2}.height, output{2}.width,output{2}.channel);
figure();
title('Output of Conv Layer');
counter = 1;
for i = 1: 4
    for j = 1: 5
        subplot(4,5, counter);
        h(i*4+j) = imshow(data(:,:,counter));
        counter = counter +1;
    end
end
%% 

data = reshape(output{3}.data,output{3}.height, output{3}.width,output{3}.channel);

figure();
counter = 1;
title('Output of Relu layer');

for i = 1: 4
    for j = 1: 5
        subplot(4,5, counter);
        h(i*4+j) = imshow(data(:,:,counter)); % index by column 127 math
        counter = counter +1;
    end
end
% sa