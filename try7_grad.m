function axk = try7_grad(x)
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
p=5;
q=1.5;
ax2=zeros(h,w);
for i=2:h
    for j=2:w-1
        ax(i,j)=max(g1(i,j),g2(i,j));
        ax2(i,j) = double(ax(i,j))*double(x(i,j));
        ax1(i,j) =(1^q)*(double(x(i,j))^p);
    end
end
axx=ax1(2:h,2:w-1);
mag21 = axx;
k1=max(mag21);
k=max(k1);
for i=1:length(mag21)
    for j=1:length(mag21(:,i))
        mag1(j,i)=(mag21(j,i)*255)/k;
    end
end
mag22=uint8(mag1);
max1 = max(max(ax2));
for i=2:h
    for j=2:w-1
        ax2(i,j) = (ax2(i,j)*255)/max1;
    end
end
axk = ax2;
axk = uint8(axk);
end