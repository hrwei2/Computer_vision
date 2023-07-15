function [x1, x2, T1, T2] = my_normalize(x1, x2)
%normalize two points of an image such that the center points are shifted
%to the centroid.

%normalization according to lecture
x = x1(:,1);
y = x1(:,2);
X = x2(:,1);
Y = x2(:,2);


centroid1 = [mean(x), mean(y)];
centroid2 = [mean(X), mean(Y)];

T1 = [1, 0, -centroid1(1);0,1,-centroid1(2);0,0,1];
T2 = [1, 0, -centroid2(1);0,1,-centroid2(2);0,0,1];
p1 = [x, y, ones(size(x1,1),1)];
p2 = [X, Y, ones(size(x1,1),1)];


S1 = [sqrt(2)/centroid1(1), 0,0;0,sqrt(2)/centroid1(2), 0;0,0,1];
S2 = [sqrt(2)/centroid2(1), 0,0;0,sqrt(2)/centroid2(2), 0;0,0,1];

T1 = S1 * T1;

T2 = S2 * T2; 

x1 = (T1 * p1.').';
x2 = (T2 * p2.').';

end