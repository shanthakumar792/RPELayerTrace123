clc;
clear all;
close all;
x=imread('sample2.jpeg');
x=rgb2gray(x);
x=imresize(x,0.5);
figure;
imshow(x);
[h,w]=size(x);
for i=2:h
    for j=2:w-1
        gx1(i,j)=x(i,j)-x(i-1,j);
        gy1(i,j)=x(i,j)-x(i,j-1);
        g1(i,j)=(gx1(i,j)^2)+(gy1(i,j)^2);
        gx2(i,j)=x(i,j)-x(i-1,j+1);
        gy2(i,j)=x(i,j)-x(i-1,j-1);
        g2(i,j)=(gx2(i,j)^2)+(gy2(i,j)^2);
    end
end
ax=zeros(h,w);
for i=2:h
    for j=2:w-1
        ax(i,j)=max(g1(i,j),g2(i,j));
    end
end
axx=ax(2:h,2:w-1);
mag21=axx;
k1=max(mag21);
k=max(k1);
for i=1:length(mag21)
    mag1(:,i)=(mag21(:,i)*255)/k;
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
leee=graythresh(mag22);
BW5=im2bw(mag22,leee);
figure;
imshow(BW5);
BW3(1:h,1)=0;
BW3(1:h,w)=0;
BW3=bwareaopen(BW3,15);
figure;
imshow(BW3);
CC=bwconncomp(BW3);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
BW4=zeros(h,w);
BW4(CC.PixelIdxList{idx})=1;
figure;
imshow(BW4);
length1=5;
width=5;
for i=1:h-length1
    s(i)=0;
    for j=i:i+length1
        for k=2:width+1
            s(i)=s(i)+BW4(j,k);
        end
    end
end
[kl1,pos1]=sort(s,'descend');
df=kl1.*(pos1.^(0.75/10));
[kl2,pos2]=sort(df,'descend');
position=pos2(1);
position1=pos1(position);
poss=position1+round((1+length1)/2);
if BW4(poss,2)~=1
    pos=poss;
    for i=1:20
        pos=poss-i;
        if BW4(pos,2)==1
            break;
        end
        pos=poss+i;
        if BW4(pos,2)==1
            break;
        end
    end
    poss=pos;
end
kj5(2)=poss;
width=5;
length1=7;
for i=3:w-width
    kj5(i)=0;
    for j=1:h-length1
        s17(j)=0;
        for h1=j:j+length1
            for w1=i:i+width
                s17(j)=s17(j)+BW4(h1,w1);
            end
        end
    end
        [mmm,pppp]=sort(s17,'descend');
        pppp=pppp+round((1+length1)/2);
        ppp3=(pppp-kj5(i-1));
        for i9=1:length(pppp)
            if ppp3(i9)==0
                ppp3(i9)=0.95;
            end
        end
        ppp6=ppp3.^abs(ppp3);
        ppp4=(mmm).*(1./(abs(ppp6)));
        [~,pospos]=max(ppp4);
        pospos1=ppp3(pospos);
        if pospos1==0.95
            pospos1=0;
        end
        pospos2=pospos1+kj5(i-1);
        kj5(i)=pospos2;
end
anewanew=zeros(h,w);
for i=2:w-width
    anewanew(kj5(i),i)=255;
end
figure;
imshow(anewanew);