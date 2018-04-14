clc;
clear all;
close all;
addr = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\method1_result_images\';
addr1 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\Result_method1\';
addr2 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\Result_test\';
list_img = dir(addr);
for i = 3:length(list_img)
    img_path = list_img(i).name;
    full_img_path = strcat(addr,img_path);
    img = imread(full_img_path);
    %img = histeq(img);
    %imshow(img);
    l1 = graythresh(img);
    l1 = l1;
    x = im2bw(img,l1);
    %figure;
    %imshow(x);
    [h1,w1] = size(x);
    cc = bwconncomp(x);
    numPixels = cellfun(@numel,cc.PixelIdxList);
    [biggest,idx] = sort(numPixels,'descend');
    bw = zeros(h1,w1);
    bw(cc.PixelIdxList{idx(1)}) = 1;
    %figure;
    %imshow(bw);
    se = strel('disk',1);
    bw1 = imerode(bw,se);
    anew = zeros(h1,w1);
    for i1 = 1:h1
        for j1 = 1:w1
            if(bw(i1,j1)~=0)
                anew(i1,j1) = img(i1,j1);
            end
        end
    end
    final_img_path1 = strcat(addr2,img_path);
    imwrite(anew,final_img_path1);
    anew1=cat(3,anew);
    anew1=cat(3,anew1,anew);
    anew1=cat(3,anew1,anew);
    anew1(:,:,2)=0;
    anew1(:,:,3)=0;
    x = img;
    x2=cat(3,x);
    x2=cat(3,x2,x);
    x2=cat(3,x2,x);
    C = imfuse(x2,anew1,'blend','Scaling','joint');
    figure;
    imshow(C);
    final_img_path = strcat(addr1,img_path);
    imwrite(C,final_img_path);
    
end