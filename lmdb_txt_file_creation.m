% change addr1, addr2, addr3 alone. all else remain same.
% addr3 is the parent directory where both these are images and groundtruth
% directory are present and where the txt file will be generated.
clc;
clear all;
close all;
addr1 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_segment_train_images\';
addr2 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_segment_train_groundtruth\';
addr3 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\';
folder = dir(addr1);
for i = 3:length(folder)
    img_path = folder(i).name;
    partial_2 = strcat(addr2,img_path,'.txt');
    fid = fopen(partial_2,'r');
    a = fscanf(fid,'%d');
    partial_3 = strcat(addr3,'pcia_segment_train_lmdb.txt');
    fid1 = fopen(partial_3,'w');
    partial_1 = strcat(addr1,img_path);
    folder2 = dir(partial_1);
    p = 0;
    for j = 3:length(folder2)
        p = p+1;
        q = a(p);
        address = folder2(j).name;
        address1 = address(1:end-3);
        address1 = strcat(address1,'jpeg');
        full_address = strcat(addr1,img_path,'\',address1);
        fprintf(fid1,'%s %d\r\n',full_address,q);
    end
    fclose(fid);
end
fclose(fid1);