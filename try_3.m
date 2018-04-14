clc;
clear all;
close all;
x=imread('sample1.jpg');
x=rgb2gray(x);
x=imresize(x,0.5);
[h,w]=size(x);
x=x(10:h,1:w);
[h,w]=size(x);
[mag,dir]=imgradient(x);
%imshowpair(mag,dir,'montage');
k1=max(mag);
k=max(k1);
for i=1:length(mag)
    mag1(:,i)=(mag(:,i)*255)/k;
end
mag2=uint8(mag1);
x5=mag2;
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
[h,w]=size(mag22);
for i=1:w
    lsd1=mag22(1:h,i);
    level1=graythresh(lsd1);
    BW3(:,i)=im2bw(lsd1,level1);
end
figure;
imshow(BW3);
BW3=bwareaopen(BW3,5);
length1=5;
width=5;
for i=1:h-length1
    s(i)=0;
    for j=i:i+length1
        for k=1:width
            s(i)=s(i)+BW3(j,k);
        end
    end
end
[kl1,pos1]=sort(s,'descend');
df=kl1.*(pos1.^(3/10));
[kl2,pos2]=sort(df,'descend');
position=pos2(1);
position1=pos1(position);
poss=position1+round((1+length1)/2);
if BW3(poss,1)~=1
    pos=poss;
    for i=1:20
        pos=poss-i;
        if BW3(pos,1)==1
            break;
        end
        pos=poss+i;
        if BW3(pos,1)==1
            break;
        end
    end
    poss=pos;
end
contour1=[];
CC1=bwconncomp(BW3);
s1=regionprops(CC1,'Centroid');
s2=regionprops(CC1,'Perimeter');
contour=[];
pt2(2)=poss;
pt2(1)=1;
posnow=pt2(1);
i8=0;
hj1=[];
s3=regionprops(CC1,'Pixellist');
for i=1:length(s1)
    k111(i,1)=s1(i).Centroid(1);
    k111(i,2)=s1(i).Centroid(2);
end
for i=1:length(s3)
    sf=length(s3(i).PixelList);
    for j=1:sf
        if((pt2(1)== s3(i).PixelList(j,1))&&(pt2(2)==s3(i).PixelList(j,2)))
            hj1(1)=i;
            break;
        end
    end
end
anew=zeros(h,w);
while (posnow<w)
    i8=i8+1;
    pt3(i8,:)=round(pt2);
    contour=s3(hj1(i8)).PixelList;
    [posnow,ji2]=max(contour(:,1));
    poss2now=contour(ji2,2);
    pt=[posnow,poss2now];
    for i=1:length(s3)
        if(~(ismember(i,hj1(:))))
            pixels=s3(i).PixelList;
            sf=length(pixels);
            dd=[];
            for j=1:sf
                dd(j)=abs(pixels(j,2)-pt(2))+abs(pixels(j,1)-pt(1));
            end
            [dmind(i),posk(i)]=min(dd);
        else
            dmind(i)=Inf;
            posk(i)=Inf;
        end
    end
   [~,posdmin]=min(dmind);
   positionofpoint=posk(posdmin);
   hj1(i8+1)=posdmin;
   ptnextw=(s3(posdmin).PixelList(positionofpoint,1));
   ptnexth=s3(posdmin).PixelList(positionofpoint,2);
   pt2=[ ptnextw,ptnexth ];
   slope1=(ptnexth-pt(2))/(ptnextw-pt(1));
   slope2=fix(slope1);
   if ptnextw > pt(1)
              display('case 1');
   for i=pt(1):ptnextw
       pth=pt(2)+(slope2*(i-pt(1)));
       anew(pth,i)=1;
   end
   elseif (abs(slope2)==Inf)
       if ptnexth>pt(2)
       for i=pt(2):ptnexth
           anew(i,ptnextw)=1;
       end
       else
           for i=ptnexth:pt(2)
               anew(i,ptnextw)=1;
           end
       end
   elseif (slope2==0)
       if ptnextw>pt(1)
           for i=pt(1):ptnextw
               anew(ptnexth,i)=1;
           end
       else
           for i=ptnextw:pt(1)
               anew(ptnexth,i)=1;
           end
       end
   else
       if ptnexth>pt(2)
           display('case 3');
       for i=pt(2):ptnexth
           anew(i,ptnextw)=1;
       end
       else
           display('case 4');
          for i=ptnexth:pt(2)
               anew(i,ptnextw)=1;
          end
       end
   end
   posnow=max(s3(posdmin).PixelList(:,1));
end
for i=1:i8+1
    dmin=hj1(i);
    Pix=s3(dmin).PixelList;
    for j=1:length(Pix)
        anew(Pix(j,2),Pix(j,1))=1;
    end
end
se=strel('disk',4);
anewfg=imdilate(anew,se);
anewfinale=imfill(anewfg);
figure;
imshow(anewfinale);
anew5=imerode(anewfinale,se);
anew6=zeros(h,w);
for i=1:w
    hj=max(find(anewfinale(:,i)==1));
    anew6(hj,i)=1;
end
for i=1:w-1
    pos1=find(anew6(:,i)==1);
    pos2=find(anew6(:,i+1)==1);
    if ((pos2-pos1)>1)
        for j=pos1:pos2
            anew6(j,i+1)=1;
        end
    elseif ((pos1-pos2)>1)
        for j=pos2:pos1
            anew6(j,i+1)=1;
        end
    end
end
figure;
imshow(anew6);
anew5=uint8(anew6.*255);
anew1=cat(3,anew5);
anew1=cat(3,anew1,anew5);
anew1=cat(3,anew1,anew5);
anew1(:,:,3)=0;
x1=cat(3,x);
x1=cat(3,x1,x);
x1=cat(3,x1,x);
C = imfuse(x1,anew1,'blend','Scaling','joint');
figure;
imshow(C);