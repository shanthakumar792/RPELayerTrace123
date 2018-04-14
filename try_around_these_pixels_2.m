clc;
clear all;
close all;
addr1 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_method1_images\';
addr2 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_segment_train_images\';
addr3 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\traced_final\';
addr4 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_segment_train_groundtruth\';
folder = dir(addr1);
folder1 = dir(addr3);
p = 4;
q = 4;
sp = 2;
sq = 2;
level = 20;
for i=3:length(folder)
    img_path = folder(i).name;
    nz = 0;
    no = 0;
    full_img_path1 = strcat(addr1,img_path);
    full_img_path2 = strcat(addr3,img_path);
    txt_file_name = strcat(img_path(1:end-4),'.txt');
    file_path_name = fullfile(addr4,txt_file_name);
    fid = fopen(file_path_name,'w');
    img1 = imread(full_img_path1);
    img2 = imread(full_img_path2);
    mkdir(addr2,img_path(1:end-4));
    addr5 = strcat(addr2,img_path(1:end-4));
    [h,w] = size(img2);
    low = [];
    high = [];
    kl = 0;
    kl1 = -1;
    num = 0;
    for j = 1:w
        for k = 1:h
            if (img2(k,j) ~= 0)
                low(j) = k;
                kl = j;
                if (kl1 == -1)
                    kl1 = j;
                end
                break;
            end
        end
        for k = h:-1:1
            if (img2(k,j) ~= 0)
                high(j) = k;
                break;
            end
        end
    end
    for j = q+1:sq:w - q
        if j<kl && j>kl1
        diff = high(j) - low(j);
        var = double(uint8((diff)/2));
        if ( (high(j) + var < h - p) && (low(j) - var > p+1))
            for k = low(j) - var :sp: high(j) + var
                d = uint8(zeros((2*p)+1,(2*q)+1));               
                for x1 = k - p : k + p
                    for y1 = j - q : j + q
                        d(x1 + p - k +1 ,y1+q-j+1) = img1(x1,y1);
                    end
                end
                val = img2(k,j);
                val1 = val/255;
                if val1 == 0
                    nz = nz + 1;
                else
                    
                    no = no + 1;
                end
                if (val1 == 0 && ((no/nz) <0.7))
                    nz = nz - 1;
                else
                    num = num + 1;
                    num1 = num2str(num);
                    fprintf(fid,'%3d\n',val1);
                    op = strcat(num1,'.jpeg');
                    full_img_path4 = strcat(addr5,'\',op);
                    imwrite(d,full_img_path4);
                end
            end
        elseif ( high(j) + (2*var) < h - p)
            for k = low(j) :sp: high(j) + (2*var)
                d = uint8(zeros((2*p)+1,(2*q)+1));                
                for x1 = k : k + 2*p
                    for y1 = j - q : j + q
                        d(x1 + p - k +1 ,y1+q-j+1) = img1(x1,y1);
                    end
                end                
                val = img2(k,j);
                val1 = val/255;
                if val1 == 0
                    nz = nz + 1;
                else
                    no = no + 1;
                end
                if (val1 == 0 && ((no/nz) <0.7))
                    nz = nz - 1;
                else
                    num = num + 1;
                    num1 = num2str(num);
                    fprintf(fid,'%3d\n',val1);
                    op = strcat(num1,'.jpeg');
                    full_img_path4 = strcat(addr5,'\',op);
                    imwrite(d,full_img_path4);
                end
            end
        elseif ( low(j) - (2*var) > p+1)
            for k = low(j) - (2*var) :sp: high(j)
                d = uint8(zeros((2*p)+1,(2*q)+1));                
                for x1 = k - (2*p) : k
                    for y1 = j - q : j + q
                        d(x1 + p - k +1 ,y1+q-j+1) = img1(x1,y1);
                    end
                end                
                val = img2(k,j);
                val1 = val/255;
                if val1 == 0
                    nz = nz + 1;
                else
                    no = no + 1;
                end
                if (val1 == 0 && ((no/nz) <0.7))
                    nz = nz - 1;
                else
                    num = num + 1;
                    num1 = num2str(num);
                    fprintf(fid,'%3d\n',val1);
                    op = strcat(num1,'.jpeg');
                    full_img_path4 = strcat(addr5,'\',op);
                    imwrite(d,full_img_path4);
                end
            end
        end
        
        end
    end
    fclose(fid);
end