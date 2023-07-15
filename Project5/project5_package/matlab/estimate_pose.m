function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]
A = [];
for i = 1 : size(x,2)
    x_p = x(1,i);
    y_p = x(2,i);
    %from lectures
    A = [A;
        X(:,i).',1,0,0,0,0,-x_p*[X(:,i).',1];
        0,0,0,0,X(:,i).',1,-y_p*[X(:,i).',1]];
       
end
[~,~,v]=svd(A);
P = v(:, size(v,2));
P = reshape(P, 4, 3)';
end