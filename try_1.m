clc;
clear all;
close all;
x=imread('sample3.jpeg');
x=rgb2gray(x);
x=imresize(x,0.5);
x1=x;
I=x;
se = strel('disk',3);
J = imsubtract(imadd(I,imtophat(I,se)), imbothat(I,se));
figure;
imshow(J);
[mag,dir]=imgradient(J);
k1=max(mag);
k=max(k1);
for i=1:length(mag)
    mag1(:,i)=(mag(:,i)*255)/k;
end
mag22=uint8(mag1);
figure;
imshow(mag22);
BWc1 = imclearborder(mag22,4);
figure;
imshow(BWc1);
level=graythresh(BWc1);
BW=im2bw(BWc1,level);
figure;
imshow(BW)
[h,w]=size(BW);
start_h=round((2*h/10));
end_h=round(h*(7/10));
length=8;
width=2;
for j=1:w-width
    s=zeros(end_h-start_h-length+1,1);
for i=start_h:end_h-length
    rect_w=j;
    rect_h=i;
    for r=rect_w:rect_w+width-1
        for g=rect_h:rect_h+length-1
            s(i-start_h+1)=s(i-start_h+1)+BW(g,r);
        end
    end
end
[~,pos]=max(s);
pos1(j)=pos+start_h+1;
end
anew=zeros(h,w);
[~,wnew]=size(pos1);
for i=1:wnew
    xd=pos1(i);
    anew(xd,i+(width/2))=1;
end
anew=uint8(anew.*255);
anew1=cat(3,anew);
anew1=cat(3,anew1,anew);
anew1=cat(3,anew1,anew);
anew1(:,:,3)=0;
x1=cat(3,x);
x1=cat(3,x1,x);
x1=cat(3,x1,x);
C = imfuse(x1,anew1,'blend','Scaling','joint');
figure;
imshow(C);