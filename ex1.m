clc;
clear all;
close all;
x = imread('C:\Users\shanthakumar\Documents\MATLAB\pcia\sample16.jpeg');
figure;
imshow(x);
y = imread('C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_traced\sample16.tif');
figure;
imshow(y);
x = double(rgb2gray(x));
y = double(y);
c = abs(y-x);
figure;
imshow(c);
img_path = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\test_images\*.jpeg';
list_img = dir(img_path);
p2 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\test_images\';
p4 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\test_traced_1\';
p5 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\traced_test_final_1\';
for i=1:length(list_img)
    p1 = list_img(i).name;
    p3 = p1(1:end-5);
    na = strcat(p2,p1);
    x1 = imread(na);
    x1 = double(rgb2gray(x1));
    na1 = strcat(p4,p3,'.tif');
    y1 = imread(na1);
    y1 = double(y1);
    c1 = abs(y1-x1);
    [h,w] = size(c1);
    for i1 =1:h
        for j1 =1:w
            if(c1(i1,j1)~=0)
                c1(i1,j1)=1;
            end
        end
    end
    na2 = strcat(p5,p3,'.tif');
    imwrite(c1,na2);
end