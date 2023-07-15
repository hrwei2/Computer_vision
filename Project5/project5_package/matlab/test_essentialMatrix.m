close all
clear
load("../data/intrinsics.mat");
load("../data/someCorresp.mat");
F = eightpoint(pts1,pts2,M);
E = essentialMatrix(F, K1, K2);
disp(E);

