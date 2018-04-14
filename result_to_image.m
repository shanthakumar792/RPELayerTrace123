clc;
clear all;
close all;
addr = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\';
folder = 'method1_results\';
folder1 = 'method1_result_images\';
type = '*.mat';
path = strcat(addr,folder,type);
list_img = dir(path);
for i = 1 : length(list_img)
    img_name = list_img(i).name;
    save_name = img_name(1:end-4);
    img_full_path = strcat(addr,folder,img_name);
    x = load(img_full_path);
    img = x.im_h_y;
    img = uint8(img);
    save_full_path = strcat(addr,folder1,save_name,'.tif');
    imwrite(img,save_full_path);
end