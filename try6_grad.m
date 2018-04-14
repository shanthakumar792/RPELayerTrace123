function mag21 = try6_grad(x)
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
ax1=zeros(h,w);
for i=2:h
    for j=2:w-1
        ax(i,j)=max(g1(i,j),g2(i,j));
        p=5;
        q=1.5;
        ax1(i,j) =(1^q)*(double(x(i,j))^p);
    end
end
axx=ax1(2:h,2:w-1);
mag21 = axx;
k1=max(mag21);
k=max(k1);
for i=1:length(mag21)
    mag1(:,i)=(mag21(:,i)*255)/k;
end
mag22=uint8(mag1);
end