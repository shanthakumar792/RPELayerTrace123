clc;
clear all;
close all;
img_path = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\*.jpeg';
list_img = dir(img_path);
p = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\';
p2 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_images\';
for i=1:length(list_img)
    p1 = list_img(i).name;
    p3 = p1(1:end-5);
    na = strcat(p,p1);
    img = imread(na);
    yimg = cat(3,img,img,img);
    na1 = strcat(p2,p3,'.tif');
    imwrite(yimg,na1);
end
%x = imread('C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_traced\sample5.tif');
%figure;
%imshow(x);
%y = cat(3,x,x,x);
%figure;
%imshow(y);
