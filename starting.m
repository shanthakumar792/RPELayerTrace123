clc;
clear all;
close all;
x=imread('sample1.jpg');
x=rgb2gray(x);
x=imresize(x,0.5);
[Gx,Gy]=imgradientxy(x);
%imshowpair(mag,dir,'montage');
mag=Gy;
k1=max(mag);
k=max(k1);
for i=1:length(mag)
    mag1(:,i)=(mag(:,i)*255)/k;
end
mag2=uint8(mag1);
x1=mag2;
%figure;
%imshow(x);
%im_histeq=histeq(x);
x1=x;
mfi = medfilt2(x1, [5 5]);
[Gx,Gy]=imgradientxy(mfi);
mag=Gy;
%imshowpair(mag,dir,'montage');
k1=max(mag);
k=max(k1);
for i=1:length(mag)
    mag1(:,i)=(mag(:,i)*255)/k;
end
mag22=uint8(mag1);
figure;
imshow(mag22);
level=graythresh(mag22);
BW1=im2bw(mag22,level);
se = strel('disk',1);
BW=imerode(BW1,se);
figure;
imshow(BW);
BWc1 = imclearborder(BW,4);
imshow(BWc1);
BWc1 = imclearborder(BW,8);
imshow(BWc1);
imshow(BWc1);
BW2=bwareaopen(BWc1,10);
figure;
imshow(BW2)
[h,w]=size(BW);
start_h=round((h/20));
end_h=round(h*(7/10));
length=6;
width=6;
for j=1:w-width
    s=zeros(end_h-start_h-length+1,1);
for i=start_h:end_h-length
    rect_w=j;
    rect_h=i;
    for r=rect_w:rect_w+width-1
        for g=rect_h:rect_h+length-1
            s(i-start_h+1)=s(i-start_h+1)+mag22(g,r);
        end
    end
end
[~,pos]=max(s);
if(pos==1)
    if(j>1)
    pos=pos1(j-1)-(start_h+1);
    end
end
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