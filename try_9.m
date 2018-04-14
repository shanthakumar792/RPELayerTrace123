clc;
clear all;
close all;
x = imread('sample4.jpeg');
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
n = gradientweight(x2);
y1 = (1./n);
y3 = uint8(y1);
[h,w] = size(x2);
figure;imshow(y3);
x3 = imadjust(x1);
n1 = gradientweight(x3);
y2 = (1./n1);
y4 = uint8(y2);
%figure;imshow(y4);
for i=1:h
    for j=1:w
        z1(i,j) = y1(i,j)*x2(i,j);
        z2(i,j) = y2(i,j)*x3(i,j);
    end
end
z1 = uint8(z1);
z2 = uint8(z2);
%figure;imshow(z1);
%figure;imshow(z2);