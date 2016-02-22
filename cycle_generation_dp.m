function sequence = cycle_generation_dp(num_microtrip,criteria)
    microtrip = zeros(num_microtrip,7);
    for i = 1:num_microtrip
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
        %disp(microtrip(i,:));
        v_t = [];
    end
    
    sequence = [];
    j = 0;
    error = 0;
    ave_v = 0;
    ave_a = 0;
    ave_p1 = 0;
    ave_p2 = 0;
    ave_p3 = 0;
    ave_p4 = 0;
    sum_t = 0;
    
    error_arr = zeros(1,num_microtrip);
    ave_v_arr = zeros(1,num_microtrip);
    ave_a_arr = zeros(1,num_microtrip);
    ave_p1_arr = zeros(1,num_microtrip);
    ave_p2_arr = zeros(1,num_microtrip);
    ave_p3_arr = zeros(1,num_microtrip);
    ave_p4_arr = zeros(1,num_microtrip);
    
    loop = 1;
    while loop <= 10
        j = j + 1;
        for i = 1:num_microtrip
            ave_v_arr(i)  = (ave_v * sum_t + microtrip(i,1) * microtrip(i,7))/(sum_t + microtrip(i,7));
            ave_a_arr(i)  = (ave_a * sum_t + microtrip(i,2) * microtrip(i,7))/(sum_t + microtrip(i,7));
            ave_p1_arr(i) = (ave_p1 * sum_t + microtrip(i,3) * microtrip(i,7))/(sum_t + microtrip(i,7));
            ave_p2_arr(i) = (ave_p2 * sum_t + microtrip(i,4) * microtrip(i,7))/(sum_t + microtrip(i,7));
            ave_p3_arr(i) = (ave_p3 * sum_t + microtrip(i,5) * microtrip(i,7))/(sum_t + microtrip(i,7));
            ave_p4_arr(i) = (ave_p4 * sum_t + microtrip(i,6) * microtrip(i,7))/(sum_t + microtrip(i,7));
            error_arr(i)  = ((ave_v_arr(i)-criteria(1))/criteria(1))^2 + ((ave_a_arr(i)-criteria(2))/criteria(2))^2 ...
                           +((ave_p1_arr(i)-criteria(3))/criteria(3))^2 + ((ave_p2_arr(i)-criteria(4))/criteria(4))^2 ...
                           +((ave_p3_arr(i)-criteria(5))/criteria(5))^2 + ((ave_p4_arr(i)-criteria(6))/criteria(6))^2;
        end
        error = min(error_arr);
        disp(error);
        sequence(j) = find(error_arr == error,1);
        disp(sequence(j));
            
        ave_v = (ave_v * sum_t + microtrip(sequence(j),1) * microtrip(sequence(j),7))/(sum_t + microtrip(sequence(j),7));
        ave_a = (ave_a * sum_t + microtrip(sequence(j),2) * microtrip(sequence(j),7))/(sum_t + microtrip(sequence(j),7));
        ave_p1 = (ave_p1 * sum_t + microtrip(sequence(j),3) * microtrip(sequence(j),7))/(sum_t + microtrip(sequence(j),7));
        ave_p2 = (ave_p2 * sum_t + microtrip(sequence(j),4) * microtrip(sequence(j),7))/(sum_t + microtrip(sequence(j),7));
        ave_p3 = (ave_p3 * sum_t + microtrip(sequence(j),5) * microtrip(sequence(j),7))/(sum_t + microtrip(sequence(j),7));
        ave_p4 = (ave_p4 * sum_t + microtrip(sequence(j),6) * microtrip(sequence(j),7))/(sum_t + microtrip(sequence(j),7));
        sum_t = sum_t + microtrip(sequence(j),7);
            
        if error <= 1
            disp('Found');
            disp(ave_v);
            disp(ave_a);
            disp(ave_p1);
            disp(ave_p2);
            disp(ave_p3);
            disp(ave_p4);
            break;
        end
        loop = loop + 1;
    end
    
    full_cycle = [];
    full_cycle_time = [];
    sum_time = 0;
    for i = 1:j
        s_v_t = eval(['microtrip',num2str(sequence(i))]);
        full_cycle = [full_cycle; s_v_t(:,2)];
        full_cycle_time = [full_cycle_time; s_v_t(:,1)+sum_time];
        sum_time = sum_time + microtrip(sequence(i),7);
    end
    %disp(full_cycle);
    %disp(full_cycle_time);
    plot(full_cycle_time, full_cycle);
end
