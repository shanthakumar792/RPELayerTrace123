clear all;
close all;
addr1 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\Result_test\';
addr2 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\traced_test_final_1\';
folder1 = dir(addr1);
a = [];
b = [];
c = [];
d = [];
e = [];
for i = 3:length(folder1)
    img_path = folder1(i).name;
    full_img_path1 = strcat(addr1,img_path);
    full_img_path2 = strcat(addr2,img_path);
    img1 = imread(full_img_path1);
    img2 = imread(full_img_path2);
    grndTruth = img2;
    [h,w] = size(grndTruth);
    segIm = imresize(img1,[h,w]);
    dice = 2*nnz(segIm&grndTruth)/(nnz(segIm) + nnz(grndTruth));
    a(i-2) = dice;
    [h1,w1] = size(img1);
    segIm = img1;
    grndTruth = imresize(img2,[h1,w1]);
    dice1 = 2*nnz(segIm&grndTruth)/(nnz(segIm) + nnz(grndTruth));
    b(i-2) = dice1;
    d(i-2) = nnz(segIm);
    e(i-2) = nnz(grndTruth);
    grndTruth = img2(1+6:h-6,1+6:w-6);
    dice2 = 2*nnz(segIm&grndTruth)/(nnz(segIm) + nnz(grndTruth));
    c(i-2) = dice2;
end
d-e
b
%dice = 2*nnz(segIm&grndTruth)/(nnz(segIm) + nnz(grndTruth));