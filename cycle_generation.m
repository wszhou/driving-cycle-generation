function sequence = cycle_generation(num_microtrip,criteria)
    microtrip = zeros(num_microtrip,7);
    %NameFile = strcat({'microtrip'},num2str((1:num_microtrip)','%-d'));
    for i = 1:num_microtrip
        %eval(['load ' NameFile{i} '.mat']);
        eval(['load microtrip',num2str(i)]);
        v_t = eval(['microtrip',num2str(i)]);
        %disp(v_t);
        [m,n] = size(v_t);
        microtrip(i,1)       = ave(v_t);           %average_velocity
        acceleration         = acc(v_t);
        [ave_acc,percentage] = per(v_t(:,2),acceleration);           
        microtrip(i,2)       = ave_acc;            %average_acceleration
        microtrip(i,3)       = percentage(1);      %percent time of acceleration
        microtrip(i,4)       = percentage(2);      %percent time of deceleration
        microtrip(i,5)       = percentage(3);      %percent time of cruise
        microtrip(i,6)       = percentage(4);      %percent time of idling
        microtrip(i,7)       = m;                  %time length
        v_t = [];
    end
    %disp(v_t);
    %%%%%
    %%%%%
    %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %sequence = zeros(10);
    %for i = 1:num_group
    %    j = 1;
    %    while group(i,j) > 0
    %        sequence(
    %    end
    %end
    sequence = zeros(1,10);
    loop = 0;
    flag = 0;
    while(loop <= 1000000)
    sequence = randi(num_microtrip,1,10);
    sum_v = 0;
    sum_a = 0;
    sum_p1 = 0;
    sum_p2 = 0;
    sum_p3 = 0;
    sum_p4 = 0;
    sum_t = 0;
    for i = 1:10
        sum_v = sum_v + microtrip(sequence(i),1) * microtrip(sequence(i),7);
        sum_a = sum_a + microtrip(sequence(i),2) * microtrip(sequence(i),7);
        sum_p1 = sum_p1 + microtrip(sequence(i),3) * microtrip(sequence(i),7);
        sum_p2 = sum_p2 + microtrip(sequence(i),4) * microtrip(sequence(i),7);
        sum_p3 = sum_p3 + microtrip(sequence(i),5) * microtrip(sequence(i),7);
        sum_p4 = sum_p4 + microtrip(sequence(i),6) * microtrip(sequence(i),7);
        sum_t = sum_t + microtrip(sequence(i),7);
    end
    ave_v = sum_v/sum_t;
    ave_a = sum_a/sum_t;
    ave_p1 = sum_p1/sum_t;
    ave_p2 = sum_p2/sum_t;
    ave_p3 = sum_p3/sum_t;
    ave_p4 = sum_p4/sum_t;
    if abs((ave_v - criteria(1))/criteria(1))<=2 && abs((ave_a - criteria(2))/criteria(2))<=2 && ...
       abs((ave_p1 - criteria(3))/criteria(3))<=2 && abs((ave_p2 - criteria(4))/criteria(4))<=2 && ...
       abs((ave_p3 - criteria(5))/criteria(5))<=2 && abs((ave_p4 - criteria(6))/criteria(6))<=2
        disp('Found');
        flag = 1;
        break;
    end
    loop = loop + 1;
    end
    
    if flag == 1
    full_cycle = [];
    full_cycle_time = [];
    sum_time = 0;
    for i = 1:10
        s_v_t = eval(['microtrip',num2str(sequence(i))]);
        full_cycle = [full_cycle; s_v_t(:,2)];
        full_cycle_time = [full_cycle_time; s_v_t(:,1)+sum_time];
        sum_time = sum_time + microtrip(sequence(i),7);
    end
    %disp(full_cycle);
    %disp(full_cycle_time);
    plot(full_cycle_time, full_cycle);
    else
        disp('Not Found');
    end
end

