clc;
clear all;
close all;
x = imread('sample3.jpeg');
x = rgb2gray(x);
figure;
imshow(x);
l=5;
w=5;
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
xd = histeq(x1);
fg = min(xd);
fg1 = min(fg);
xd = xd-fg1;
%figure;
%imshow(x1);
v = try6_grad(x1);
%figure;
%imshow(v);
len =6;
[h1,w1] = size(v);
for i=1:3
v = medfilt2(v,[2 2]);
end
%figure;
%imshow(v)
sd = nonzeros(v);
lk = graythresh(sd);
cv = max(v);
cv1 = max(cv);
cv2 = lk*cv1;
v1 = zeros(h1,w1);
for i=1:h1
    for j=1:w1
        if(v(i,j)>cv2)
            v1(i,j) = v(i,j);
        end
    end
end
v1 = (v1.*255)/cv1;
v1 = uint8(v1);
figure;
imshow(v1);
l1 = graythresh(v1);
v2 = im2bw(v1,l1*0.15);
figure;
imshow(v2);
BW = zeros(h1,w1);
CC = bwconncomp(v2);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = sort(numPixels,'descend');
BW(CC.PixelIdxList{idx(1)}) = 1;
s3 = regionprops(CC,'Pixellist');
as = s3(idx(1)).PixelList;
ami = min(as(:,1));
ama = max(as(:,1));
k=2;
while((ama-ami)<0.9*w1)
    wk = ama-ami;
    as1 = s3(idx(k)).PixelList;
    as2 =[as;as1];
    ami = min(as2(:,1));
    ama = max(as2(:,1));
    if((ama-ami)> 1.1*wk)
     BW(CC.PixelIdxList{idx(k)}) = 1;
     as = as2;
    end
    ami = min(as(:,1));
    ama = max(as(:,1));
    k = k+1;
end
figure;
imshow(BW);
%{
BW1 = uint8(zeros(h1,w1));
for i=1:h1
    for j=1:w1
        if(BW(i,j)==1)
            BW1(i,j) = x1(i,j);
            if(BW1(i,j)<70)
                BW1(i,j)=80;
            end
        end
    end
end
lr = zeros(1,w1);
lh = zeros(h1+1,1);
BW1 = vertcat(lr,BW1);
BW1 = horzcat(lh,BW1);
BW1 = horzcat(BW1,lh);
BW1 = uint8(BW1);
figure;
imshow(BW1);
%}