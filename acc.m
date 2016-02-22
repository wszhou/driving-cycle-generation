function a=acc(v)
%v=[i(1,:);i(2,:)];
[m,n]=size(v);
a(:,1) = 0;
a(:,m) = 0;
for j=(2:m-1)                                               % delte first and last dataset
    a(:,j)=(v(j+1,2)-v(j-1,2))/(v(j+1,1)-v(j-1,1)); % a start from second point, speed change / time passed
end
end


%function percentage=per(a)
%value=zeros(1,3);
%for i=1:length(a)
%    if a(i)<0
%        value(2)=value(2)+1;
%    elseif a(i)>0
 %       value(1)=value(1)+1;
 %   elseif a(i)==0
 %       value(3)=value(3)+1;
 %   end
%end
%percentage=[value(1)/sum(value),value(2)/sum(value),value(3)/sum(value)];
%end
    