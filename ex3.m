clc;
clear all;
close all;
x = imread('C:\Users\shanthakumar\Documents\MATLAB\pcia\sample16.jpeg');
y = imread('C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_traced\sample16.tif');
img_path = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\test_images\*.jpeg';
list_img = dir(img_path);
p2 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\test_images\';
p4 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\test_traced\';
p5 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\traced_test_final\';
p6 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\test_method1_images\';
for i=1:length(list_img)
    p1 = list_img(i).name;
    p3 = p1(1:end-5);
    na = strcat(p2,p1);
    x1 = imread(na);
    x1 = double(rgb2gray(x1));
    l1 = graythresh(x1);
    l1 = l1*255*0.45;
    [h,w] = size(x1);
    x2 = zeros(h,w);
    for i1 = 1:h
        for j1 = 1:w
            if(x1(i1,j1)>l1)
                x2(i1,j1) = x1(i1,j1);
            end
        end
    end
    x2 = uint8(x2);
    x5 = adapthisteq(x2);
    imshow(x2);
    figure;
    imshow(x5);
    na3 = strcat(p6,p3,'.tif');
    imwrite(x5,na3);
end