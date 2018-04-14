clc;
clear all;
close all;
x=imread('sample1.jpg');
x=rgb2gray(x);
x=imresize(x,0.5);
[mag,dir]=imgradient(x);
%imshowpair(mag,dir,'montage');
k1=max(mag);
k=max(k1);
for i=1:length(mag)
    mag1(:,i)=(mag(:,i)*255)/k;
end
mag2=uint8(mag1);
x5=mag2;
figure;
imshow(x);
%im_histeq=histeq(x);
x5=imadjust(x);
mfi = medfilt2(x5, [5 5]);
[Gx,Gy]=imgradientxy(mfi);
mag=Gx;
%imshowpair(mag,dir,'montage');
k1=max(Gx);
k=max(k1);
for i=1:length(mag)
    mag1(:,i)=(mag(:,i)*255)/k;
end
mag28=uint8(mag1);
%figure;
%imshow(mag28);
level=graythresh(mag28);
BW2=im2bw(mag28,level);
%figure;
%imshow(BW2);
mag=Gy;
%imshowpair(mag,dir,'montage');
k1=max(Gy);
k=max(k1);
for i=1:length(mag)
    mag1(:,i)=(mag(:,i)*255)/k;
end
mag22=uint8(mag1);
figure;
imshow(mag22);
level=graythresh(mag22);
BW2=im2bw(mag22,level);
figure;
imshow(BW2);
BWc1 = BW2;
%figure;
%imshow(BWc1);
[h,w]=size(BW2);
BW2=bwareaopen(BW2,2);
start_h=round((h/20));
end_h=round(h*(9/10));
length1=6;
width1=6;
lsd=BW2(1:h,1:3);
CC=bwconncomp(lsd);
S1=regionprops(CC,'Centroid');
S2=regionprops(CC,'Area');
for i=1:length(S1)
    k11(i)=round(S1(i).Centroid(2));
    k21(i)=S2(i).Area;
end
[~,ji1]=sort(k21,'descend');
k11=k11(ji1);
k21=k21(ji1);
if(k11(1)~=min(k11))
    if((k11(1)*k21(1))>(k11(2)*k21(2)))
    poss=k11(1);
    else
        poss=k11(2);
    end
else
    poss=k11(2);
end
if(BW2(poss,1)~=1)
    for i=1:length1
        for j1=1:2
        if(BW2(poss+(((-1)^j1)*i),1)==1)
            poss=poss+(((-1)^j1)*i);
            break;
        end
        end
    end
end
contour1=[];
CC1=bwconncomp(BW2);
s1=regionprops(CC1,'Centroid');
s2=regionprops(CC1,'Perimeter');
contour=[];
pt2(2)=poss;
pt2(1)=1;
posnow=pt2(1);
i8=0;
hj1=[];
s3=regionprops(CC1,'Pixellist');
for i=1:length(s3)
    sf=length(s3(i).PixelList);
    for j=1:sf
        if((pt2(1)== s3(i).PixelList(j,1))&&(pt2(2)==s3(i).PixelList(j,2)))
            hj1(1)=i;
            break;
        end
    end
end
while(posnow<w && i8<4)
    i8=i8+1;
    d1=[];
    d=[];
    pt3(i8,:)=round(pt2);
B=bwtraceboundary(BW2,[round(pt2(2)),round(pt2(1))],'E');
contour=[contour;B];
[posnow,ji2]=max(contour(:,2));
poss2now=contour(ji2,1);
for i=1:length(s1)
    k111(i,1)=s1(i).Centroid(1);
    k111(i,2)=s1(i).Centroid(2);
end
pt=[posnow,poss2now];
for i=1:length(s1)
    if(ismember(i,hj1(:)) || (k111(i,1) < pt(1)))
        d(i)=Inf;
    else
    d(i)=(2*(pt(1)-k111(i,1))^2)+((pt(2)-k111(i,2))^2);
    end
end
[~,dmin]=min(d);
pt1=[k111(dmin,1),k111(dmin,2)];
B=s3(dmin).PixelList;
for i=1:length(B(:,1))
    d1(i)=abs(pt(2)-B(i,1))+abs(pt(1)-B(i,2));
end
[~,dmin1]=min(d1);
pt2=[B(dmin1,2),B(dmin1,1)];
hj1(i8+1)=dmin;
slope=(pt2(2)-pt(2))/(pt2(1)-pt(1));
slope=round(slope);
end
anew=zeros(h,w);
for i=1:i8+1
    dmin=hj1(i);
    Pix=s3(dmin).PixelList;
    for j=1:length(Pix)
        anew(Pix(j,2),Pix(j,1))=1;
    end
end
anew=uint8(anew.*255);
figure;
imshow(anew);
