clc;
clear all;
close all;
x = imread('C:\Users\shanthakumar\Documents\MATLAB\pcia\test_images\test_4.jpeg');
figure;
imshow(x);
y = imread('C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_traced\sample16.tif');
%figure;
%imshow(y);
x = double(rgb2gray(x));
%figure;
%imshow(c);
x = uint8(x);
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
x5 = adapthisteq(x1);
figure;
imshow(x5);
x2 = histeq(x1);
%figure;
%imshow(x2);
x3 = imadjust(x1);
figure;
imshow(x3);