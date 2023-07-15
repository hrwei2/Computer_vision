function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

%pre process data
pts = randperm(size(pts1,1),10);
p1 = pts1(1:8,:);
p2 = pts2(1:8,:);
[p1, p2, T1, T2] = my_normalize(p1, p2); % my version of normalization according to lecture

x1 = p1(:,1);
y1 = p1(:,2);
x2 = p2(:,1);
y2 = p2(:,2);


%from slides
m = [x2 .* x1, x2 .* y1, x2, y2 .* x1, y2 .* y1, y2, x1, y1, ones(size(x1, 1),1)]; 
[~,~,V] = svd(m);
A = reshape(V(:,end),3,3);
[U,S,V] = svd(A);
S(3,3) = 0;

F = U*S*V.'; % resulting estimate of the essential matrix provided by the algorithm
F = T2.' * F * T1; %Denormalized_F algorithm as discussed in discussions 
F = refineF(F,pts1,pts2); % helper funciton to refine the solution by using local minimization as suggested in the docs
end