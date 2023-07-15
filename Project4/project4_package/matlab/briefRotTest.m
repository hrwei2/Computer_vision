% Your solution to Q2.1.5 goes here!
close all;
clear all;
%% Read the image and convert to grayscale, if necessary
I1 = imread('../data/cv_cover.jpg');
if size(I1,3)==3
    I1 = rgb2gray(I1);
end
%% Compute the features and descriptors
count = [];
f1 = detectFASTFeatures(I1);
[f1,v1] = computeBrief(I1,f1.Location);
for i = 0:36
    %% Rotate image
    I1_rotate = imrotate(I1,(i)*10); %%rotate by 10 degrees
    %% Compute features and descriptors
    f2 = detectFASTFeatures(I1_rotate);
    [f2,v2] = computeBrief(I1_rotate,f2.Location);
    %% Match features
    indexPairs = matchFeatures(f1,f2,'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    mp2 = v2(indexPairs(:,2),:);
    if i == 10 || i == 20 || i == 30 %show the 3 orantations
        matchedPoints1 = v1(indexPairs(:,1),:);
        figure()
        showMatchedFeatures(I1,I1_rotate,matchedPoints1,mp2,'montage');
    end
    %% Update histogram
    count = [count, size(indexPairs(:,1), 1)];
end

%% Display histogram
figure();
bar(count);

%% Compute the features and descriptors for surf
count = [];
f1 = detectFASTFeatures(I1);
[f1,v1] = extractFeatures(I1,f1.Location, 'Method', 'SURF');
for i = 0:36
    %% Rotate image
    I1_rotate = imrotate(I1,(i)*10); %%rotate by 10 degrees
    %% Compute features and descriptors
    f2 = detectSURFFeatures(I1_rotate);

    [f2,v2] = extractFeatures( I1_rotate,f2.Location, 'Method', 'SURF');
    %% Match features
    indexPairs = matchFeatures(f1,f2,'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    mp2 = v2(indexPairs(:,2),:);
    if i == 10 || i == 20 || i == 30 %show the 3 orantations
        matchedPoints1 = v1(indexPairs(:,1),:);
        figure()
        showMatchedFeatures(I1,I1_rotate,matchedPoints1,mp2,'montage');
    end
    %% Update histogram
    count = [count, size(indexPairs(:,1), 1)];
end

%% Display histogram
figure();
bar(count);