clc;
clear all;
close all;
addr1 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_method1_images\';
addr2 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_segment_train_images\';
addr4 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_segment_train_groundtruth\';
addr5 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\traced_final\';
folder = dir(addr1);
p = 16;
q = 16;
sp = 16;
sq = 16;
for i=3:length(folder)
    img_path = folder(i).name;
    full_img_path1 = strcat(addr1,img_path);
    full_gndtrth_path = strcat(addr5,img_path);
    txt_file_name = strcat(img_path(1:end-4),'.txt');
    file_path_name = fullfile(addr4,txt_file_name);
    fid = fopen(file_path_name,'w');
    img1 = imread(full_img_path1);
    img1 = img1 - min(min(img1));
    img2 = imread(full_gndtrth_path);
    [h1,w1] = size(img1);
    x1 = 0;
    val = 0;
    mkdir(addr2,img_path(1:end-4));
    addr3 = strcat(addr2,img_path(1:end-4));
    for i1 = p+1 :sp: h1-p
        for j1 = q+1 :sq: w1-q
            d = uint8(zeros((2*p)+1,(2*q)+1));
            x1 = x1+1;
            for i2 = -p:p
                for j2 = -q:q
                    d(i2+p+1,j2+q+1) = img1(i1+i2,j1+j2);
                end
            end
            val = img2(i1,j1);
            val1 = val/255;
            x2 = num2str(x1);
            fprintf(fid,'%3d\n',val1);
            op = strcat(x2,'.tif');
            full_img_path2 = strcat(addr3,'\',op);
            imwrite(d,full_img_path2);
        end
    end
    fclose(fid);
end