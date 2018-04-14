clc;
clear all;
close all;
x=imread('sample2.jpeg');
x=rgb2gray(x);
x=imresize(x,0.5);
figure;
imshow(x);
[h,w]=size(x);
[h2,w2]=size(x);
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
K=medfilt2(mag22,[6 6]);
figure;
imshow(K);
length1=9;
width=9;
[h,w]=size(K);
K1=double(K);
for i=1:h-length1
    s(i)=0;
    for j=i:i+length1
        for k=1:width
            s(i)=s(i)+K1(j,k);
        end
    end
end
BW4=K1;
[kl1,pos1]=sort(s,'descend');
df=kl1.*(pos1.^6);
[kl2,pos2]=sort(df,'descend');
position=pos2(1);
position1=pos1(position);
poss=position1+round((1+length1)/2);
kj5(1)=poss;
for i=2:w-width
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
                ppp3(i9)=0.9;
            end
        end
        ppp6=ppp3.^0.2;
        ppp4=(mmm).*(1./(abs(ppp6)));
        [~,pospos]=max(ppp4);
        pospos1=ppp3(pospos);
        if pospos1==0.9
            pospos1=0;
        end
        pospos2=pospos1+kj5(i-1);
        kj5(i)=pospos2;
end
anewanew=zeros(h,w);
for i=1:w-width
    anewanew(kj5(i),i)=255;
end
for i=1:w-width-1
    if((kj5(i+1)-kj5(i))>1)
        for j=kj5(i):kj5(i+1)-1
            anewanew(j,i)=1;
        end
    end
    if((kj5(i+1)-kj5(i))<-1)
        for j=kj5(i+1):kj5(i)-1
            anewanew(j,i)=1;
        end
    end
end
figure;
imshow(anewanew);
anw=zeros(h2,w2);
for i=2:h2
    for j=2:w2-1
        anw(i,j)=anewanew(i-1,j-1);
    end
end
anew=anw;
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