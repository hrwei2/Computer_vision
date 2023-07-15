function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

max_count = 0;
best_H = []; %array 
least_dist = Inf; 

for i = 1: 15 %try 200 random samples for harry potter, 15 for video to speed up process
   
    
   randpoints = randperm(size(locs1,1),4);

   x1 = locs1([randpoints],:); % random subset of 4 points 
   x2 = locs2([randpoints],:);

   h = computeH_norm(x2,x1);

   t = projective2d(h.');
   
   out = transformPointsForward(t, locs2);
   dis = abs(locs1-out); % distance between the points
   

   count = 0;
   tmp = [];
   for j = 1: size(locs1, 1)% count the number of points  that fit into range
       if norm(dis(j,:),2) <= 2.5 % good error number
           count = count+1;
           tmp = [tmp, j];
       end
   end 
   
   %update the counts 
   if count == max_count
       if sum(dis,'all') < least_dist %tie breaker 
            least_dist = sum(dis,'all');
            max_count = count;
            x1 = locs1(tmp,:);
            x2 = locs2(tmp,:);
            best_H = computeH_norm(x1,x2);
            inliers = locs1(tmp,:);
       end
   elseif count > max_count
       least_dist = sum(dis,'all');
        max_count = count;
        x1 = locs1(tmp,:);
        x2 = locs2(tmp,:);
        best_H = computeH_norm(x1,x2);
        inliers = locs1(tmp,:);
   end
end

if size(best_H,1) == 0
    bestH2to1 = computeH_norm(x1,x2);
else
    bestH2to1= best_H.';
end

%Q2.2.3
end

