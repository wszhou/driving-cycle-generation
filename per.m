function [ave_a,percentage]=per(v,a)
value=zeros(1,4);
for i=1:length(a)
    if a(i)>=0.5
        value(1)=value(1)+1;
    elseif a(i)<=-0.5
        value(2)=value(2)+1;
    elseif a(i)>-0.5 && a(i)<0.5 && v(i)>0
        value(3)=value(3)+1;
    elseif a(i)>-0.5 && a(i)<0.5 && v(i)==0
        value(4)=value(4)+1;
    end
end
ave_a = sum(abs(a))/length(a);
percentage=[value(1)/sum(value),value(2)/sum(value),value(3)/sum(value),value(4)/sum(value)];
%disp(percentage);
end
    