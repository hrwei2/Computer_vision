function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
[~, ~, numberOfColorChannels]  = size(I1);
if numberOfColorChannels > 1
  % It's not really gray scale like we expected - it's color.
  % Convert it to gray scale by taking only the green channel.
  I1 = rgb2gray(I1);
end

[~, ~, numberOfColorChannels]  = size(I2);
if numberOfColorChannels > 1
  % It's not really gray scale like we expected - it's color.
  % Convert it to gray scale by taking only the green channel.
  I2 = rgb2gray(I2);
end

%% Detect features in both images
points1 = detectFASTFeatures (I1);
points2 = detectFASTFeatures (I2);

%% Obtain descriptors for the computed feature locations
 [f1, v1] = computeBrief(I1, points1.Location);
 [f2, v2] = computeBrief(I2, points2.Location);
%% Match features using the descriptors
indexPairs = matchFeatures(f1, f2,'MatchThreshold', 10., 'MaxRatio', 0.68);
locs1 = v1(indexPairs(:,1),:);
locs2 = v2(indexPairs(:,2),:);
end

