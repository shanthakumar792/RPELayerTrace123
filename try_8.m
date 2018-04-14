clc;
clear all;
close all;
x = imread('sample1.jpg');
x = rgb2gray(x);
figure;
imshow(x);
l1 = graythresh(x);
l1 = l1*255;
[h,w] = size(x);
x1 = zeros(h,w);
for i=1:h
    for j=1:w
        if(x(i,j)>l1)
            x1(i,j) = x(i,j);
        end
    end
end
x1 = uint8(x1);
figure;
imshow(x1);
x2 = adapthisteq(x1);
figure;imshow(x2);
v1 = try7_grad(x2);
v3 = v1;
figure;imshow(v1);
x3 = imadjust(x1);
figure;imshow(x3);
v2 = try7_grad(x3);
v4 = v2;
figure;imshow(v2);
for i=1:3
v1 = medfilt2(v1,[2 2]);
v2 = medfilt2(v2,[2 2]);
end
figure;imshow(v1);
figure;imshow(v2);
y1 = im2bw(v1);
y2 = im2bw(v2);
figure;imshow(y1);
figure;imshow(y2);