clc;
clear all;
close all;
x=imread('sample3.jpeg');
x = rgb2gray(x);
x = imresize(x,[176 264]);
figure;
imshow(x);
mag22=try6_grad(x);
figure;
imshow(mag22);
K= mag22;
for i=1:12
K=medfilt2(K,[4 4]);
end
figure;
imshow(K);
[h,w] = size(K);
for i=1:h
    v = K(i,:);
    l = graythresh(v);
    as = im2bw(v,l);
    P(i,:) = as;
end
l = graythresh(K);
P1 = im2bw(K,l);
figure;
imshow(P);