close all
clear
load("../data/someCorresp.mat");
F = eightpoint(pts1,pts2,M);
disp(F);
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
displayEpipolarF(im1,im2,F);
