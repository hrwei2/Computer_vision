close all
addpath("../matlab/")
load lenet.mat
layers = get_lenet();
%% 

check = {[1; 2; 3; 4; 5; 6; 7; 8; 9; 0;] [1; 2; 3; 4; 5; 6; 7; 8; 9; 0;]};
for i = 1: 2
    %inital image processing
    img_src = sprintf('../images/image%d.jpg', i);

    I = rgb2gray(imread(img_src));
    level = graythresh(I);
    BW = imbinarize(I,level);
    BW = ~BW;
    mask = bwareaopen(BW,10);
    thin = bwmorph(mask, 'thicken', 1);
    se = strel('disk',1);
    joined = imclose(thin, se);
    
    props = regionprops(joined, 'BoundingBox');
    figure;
    title(img_src);
    imshow(joined);
    hold on
    for m = 1: length(props)
        corner = props(m).BoundingBox;
        rectangle('Position', [corner(1),corner(2),corner(3),corner(4)],'EdgeColor','r','LineWidth',2) ;
    end
    hold off
    figure;
    
    %formatting cells into 25 by 25 images
    all_images = zeros(28*28, length(props));
    
    for m = 1 : length(props)
        b = props(m).BoundingBox;
        img = joined(floor(b(2)):ceil(b(2)+b(4)-1), floor(b(1)):ceil(b(1)+b(3)-1));
        diff_f = max(size(img)) / min(size(img));
        diff_val = max(size(img)) - min(size(img));
        if  diff_f >= 2.
            img = padarray(img, [5,floor(diff_val/2)+1], 0, 'both');
            img = imresize(img, [28,28], 'box');
        else
            img = padarray(img, [20,20], 0, 'both');
          img = imresize(img, [28,28], 'box');  
        end
        img = transpose(img);
        
        all_images(:, m) = reshape(img, [],1);
        
    end
    layers{1,1}.batch_size = size(all_images,2);
    [output, P] = convnet_forward(params, layers, all_images);
    [p, out_label] = max(P, [], 1);
    
    fprintf('running image%d.jpg\n', i)
    disp("number of correct predictions:")
    disp(sum(out_label-1 == transpose(check{1,i})))
end
%% 

img_src = sprintf('../images/image3.PNG');

I = rgb2gray(imread(img_src));
level = graythresh(I);
BW = imbinarize(I,level);
BW = ~BW;
mask = bwareaopen(BW,10);
thin = bwmorph(mask, 'thin', inf);
thin = bwmorph(thin, 'thicken', 2);
se = strel('disk',1);
joined = imclose(thin, se);

props = regionprops(joined, 'BoundingBox');
figure;
title(img_src);
imshow(joined);
hold on
for m = 1: length(props)
    BB = props(m).BoundingBox;
    rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
end
hold off
figure;

%formatting cells into 25 by 25 images
all_images = zeros(28*28, length(props));

for m = 1 : length(props)
    b = props(m).BoundingBox;
    img = joined(floor(b(2)):ceil(b(2)+b(4)-1), floor(b(1)):ceil(b(1)+b(3)-1));
    diff_f = max(size(img)) / min(size(img));
    diff_val = max(size(img)) - min(size(img));
    if  diff_f >= 2.
        img = padarray(img, [5,floor(diff_val/2)+1], 0, 'both');
        img = imresize(img, [28,28], 'box');
    else
        img = padarray(img, [20,20], 0, 'both');
      img = imresize(img, [28,28], 'box');  
    end

    img = transpose(img);
    all_images(:, m) = reshape(img, [],1);
    
end
layers{1,1}.batch_size = size(all_images,2);
check = [6; 0; 6; 2; 6;];
[output, P] = convnet_forward(params, layers, all_images);
[p, out_label] = max(P, [], 1);
disp("running image3.PNG")
disp("number of correct predictions:")
disp(sum(out_label-1 == transpose(check)))
%% 

img_src = sprintf('../images/image4.jpg');
%black and white image
I = rgb2gray(imread(img_src));
level = graythresh(I);
BW = imbinarize(I,level);
BW = ~BW;

%masking
mask = bwareaopen(BW,10);
thin = bwmorph(mask, 'thicken', 1);
se = strel('disk',1);
joined = imclose(thin, se);% join isolated by a diameter of 2x2

props = regionprops(joined, 'BoundingBox');
figure;
title(img_src);
imshow(joined);
hold on
for m = 1: length(props)
    BB = props(m).BoundingBox;
    rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
end
hold off
figure;

%formatting cells into 25 by 25 images
all_images = zeros(28*28, length(props));

for m = 1 : length(props)
    b = props(m).BoundingBox;
    img = joined(floor(b(2)):ceil(b(2)+b(4)-1), floor(b(1)):ceil(b(1)+b(3)-1)); % w, h of the 4 cordinates of the box
    diff_f = max(size(img)) / min(size(img)); % for converting image ratios 
    diff_val = max(size(img)) - min(size(img)); % for how much to pad in the image ratios
    if  diff_f >= 2.
        img = padarray(img, [5,floor(diff_val/2)+1], 0, 'both'); % complicated math formula just do not question it
        img = imresize(img, [28,28], 'box');
    else
        img = padarray(img, [20,20], 0, 'both');
        img = imresize(img, [28,28], 'box');  %resize image to 28 by 28
    end
    
    img = transpose(img);
    all_images(:, m) = reshape(img, [],1);
    
end
layers{1,1}.batch_size = size(all_images,2);
check = [7; 0; 9; 3; 1; 6; 7; 2; 6; 1; 3; 9; 6; 4; 1; 4; 2; 0; 0; 5; 4; 4; 7; 3; 1; 0; 2; 5; 5; 1; 7; 9;4; 9; 1; 7; 4; 2; 9; 1; 5; 3; 4; 0; 2; 9; 4; 4; 1; 1;];
[output, P] = convnet_forward(params, layers, all_images);
[p, out_label] = max(P, [], 1);
disp("running image4.jpg")
disp("number of correct predictions:")
disp(sum(out_label-1 == transpose(check)))


