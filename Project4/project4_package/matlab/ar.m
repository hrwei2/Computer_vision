% Q3.3.1
close all
clear all
vid1 = loadVid('../data/book.mov');
vid2 = loadVid('../data/ar_source.mov');
cv_cover = imread('../data/cv_cover.jpg');
vid = VideoWriter('../results/ar.avi', 'Motion JPEG AVI');
open(vid);
for i = 1: size(vid2, 2)
    frame1 = vid1(i).cdata;
    frame2 = vid2(i).cdata;
    [locs1, locs2] = matchPics(cv_cover, frame1);
    if size(locs1,1) > 4 %potentially only have less than 4 points but requirement is more than 4 for computeH_ransac to work
        [bestH2to1, ~] = computeH_ransac(locs1, locs2);
        frame2= imcrop(frame2, [0 45 size(frame2, 2) size(frame2, 1)-90]);
        scaled_hp_img = imresize(frame2, [size(cv_cover,1) size(cv_cover,2)]);
        imshow(compositeH(bestH2to1.', scaled_hp_img, frame1));
        writeVideo(vid, compositeH(bestH2to1.', scaled_hp_img, frame1));
    else
        writeVideo(vid, frame1);
    end
end
close(vid);

