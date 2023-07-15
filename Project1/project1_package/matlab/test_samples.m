load lenet.mat
layers = get_lenet();

all_images = zeros(784,5);
for i = 1: 5
   img_src = sprintf('../images/samples/%d.png', i);
   im = im2double(imread(img_src));
   im = transpose(im);
   sample_pic = reshape(im, [], 1);
   all_images(:,i) = sample_pic;
end
layers{1,1}.batch_size = size(all_images,2);
[output, P] = convnet_forward(params, layers, all_images);
[p, out_label] = max(P, [], 1);
disp("number of correct predictions:")
disp(sum(out_label-1 == [1:5]))


