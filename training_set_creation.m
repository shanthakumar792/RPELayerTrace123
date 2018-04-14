clc;
clear all;
close all;
img_path = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_method1_images\*.tif';
list_img = dir(img_path);
addr = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\traced_final\';
addr1 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\traced_final_new\';
bnd_x = 6;
bnd_y = 6;
h = 3;
w = 3;
low = [];
high = [];
img_path1 = 'C:\Users\shanthakumar\Documents\MATLAB\pcia\pcia_method1_images\';
for i = 1:length(list_img)
    img_name = list_img(i).name;
    full_init_gnd = strcat(addr,img_name);
    full_init_img = strcat(img_path1,img_name);
    x = imread(full_init_gnd);
    y = imread(full_init_img);
    [h1,w1]= size(x);
    for j= 1:w1
        a = 0;
        b = 0;
        for k = 1+bnd_x+h:h1-bnd_x-h
            if x(k,j)~=0
                a = k;
                break;
            end
        end
        for k = h1-bnd_x-h:-1:1+bnd_x+h
            if x(k,j)~=0
                b = k;
                break;
            end
        end
        low(j) = a;
        high(j) = b;
    end
    p = zeros(h1,w1);
    for j = 1:w1
        if j < 1+w
        elseif j>w1-w
        else
            if(low(j)~=0 && high(j)~=0)
            for k = low(j)-bnd_x:high(j)+bnd_x
                if x(k,j) == 255
                    p(k,j) = 1;
                else
                s22 = 0 ;
                for l = k-h:k+h
                    for v = j-w:j+w
                        s22 = s22 + double((y(l,v)/255));
                    end
                end
                s22 = s22/(4*h*w);
                p(k,j) = s22;
                end
            end
            end
        end
    end
    pit = strcat(addr1,img_name);
    imwrite(p,pit);
end