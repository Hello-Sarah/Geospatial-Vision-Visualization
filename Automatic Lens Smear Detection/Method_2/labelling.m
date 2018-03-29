function labelling(imgDataPath)
% imgDataPath = 'C:\MATLABR2016a\bin\myworkspace\CS513\sample_drive\cam_3\';

invI = 1 - image;

se = strel('line',10,10);
Im = imerode(double(invI), se);
Im = imdilate(double(Im), se);
% imshow(Im);

Limg = bwlabel(Im, 4);
Lmax = max(Limg(:));
for i = 1:Lmax
    Lsize = sum(Limg(:) == i);
    if(Lsize <= 500)
        Limg(Limg == i) = 0;
        display(sprintf('delete No.%d object with size = %d', i, Lsize));
    end
end
Limg2 = bwmorph(Limg, 'remove');
% Limg2 = bwmorph(Limg2, 'bridge');
Limg3 = imdilate(Limg2, se);
Limg3 = bwmorph(Limg3, 'fill');
figure,
imshow(1-Limg);
title('shape of the smear mask in cam 3')

mask = cat(3, Limg3*255, zeros(size(Limg3)), zeros(size(Limg3)));

imgDataDir  = dir(imgDataPath);
I0 = imread([imgDataPath imgDataDir(100).name]);
I1 = imadd(I0, uint8(mask));
figure,
imshow(I1);
end