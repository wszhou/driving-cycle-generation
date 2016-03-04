function a=acc1(v)
%v=[i(1,:);i(2,:)];
[m,n]=size(v);
a(:,1) = 0;
a(:,m) = 0;
for j=(2:m-1)                                               % delte first and last dataset
    a(:,j)=abs((v(j+1,2)-v(j-1,2))/(v(j+1,1)-v(j-1,1))); % a start from second point, speed change / time passed
end
end