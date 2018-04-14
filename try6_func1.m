function anew1 = try6_func1(BW)
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
            s(i-start_h+1)=s(i-start_h+1)+BW(g,r);
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
figure;
imshow(anew1);
end