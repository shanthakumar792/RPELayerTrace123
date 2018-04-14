clc;
clear all;
close all;
x = imread('sample21.jpeg');
x = rgb2gray(x);
x = imresize(x,[150 225]);
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
v = try6_grad(x1);
len =6;
[h1,w1] = size(v);
for i=1:3
v = medfilt2(v,[2 2]);
end
figure;
imshow(v)