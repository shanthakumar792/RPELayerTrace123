function BW2 = rtol(BW1)
[h1,w1] = size(BW1);
s=0;
for i=w1:-1:1
cv = find(BW1(:,i));
if(isempty(cv)==0)
s=i;
break;
end
end
BW2 = zeros(h1,w1);
for i =1:h1
    if(BW1(i,s)~=0)
        BW2(i,s)=1;
    end
end
for i=s-1:-1:2
    for j=3:h1-2
        if(((BW2(j,i+1)~=0) | (BW2(j-1,i+1)~=0) | (BW2(j+1,i+1)~=0) | (BW2(j-2,i+1)~=0) | (BW2(j+2,i+1)~=0))&&(BW1(j,i)~=0))
            BW2(j,i)=1;
        end
    end
end
end