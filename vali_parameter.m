function beta = vali_parameter(num_profile,driving_condition)

%beta: 6*4 matrix
    ave_velocity = zeros(num_profile,1);
    ave_acceleration = zeros(num_profile,1);
    per_acceleration = zeros(num_profile,1);
    per_deceleration = zeros(num_profile,1);
    per_cruise = zeros(num_profile,1);
    per_idling = zeros(num_profile,1);
    %NameFile = strcat({'velocitytime'},num2str((1:num_profile)','%-d'));
    %disp(NameFile);
    v_t = [];
    for i = 1:num_profile
        eval(['load velocitytime',num2str(i)]);
    end
    for i = 1:num_profile
        eval(['v_t_origin = velocitytime',num2str(i),';']);
        [m,n] = size(v_t_origin);
        j = 1;
        while (j*16) < m
            v_t(j,1) = j;
            v_t(j,2) = v_t_origin(16*j,2);
            j = j + 1;
        end
        %disp(v_t);
        %v_t = eval(['NameFile{i}']);
        %[m,n] = size(v_t);  
        ave_velocity(i)      = ave(v_t);
        acceleration         = acc(v_t);
        [ave_acc,percentage] = per(v_t(:,2),acceleration);
        ave_acceleration(i)  = ave_acc;
        per_acceleration(i)  = percentage(1);
        per_deceleration(i)  = percentage(2);
        per_cruise(i)        = percentage(3);
        per_idling(i)        = percentage(4);
        v_t = [];
    end
    %beta(1): average velocity
    %beta(2): average acceleration
    %beta(3): percent time of acceleration
    %beta(4): percent time of deceleration
    %beta(5): percent time of cruise
    %beta(6): percent time of idling
    beta(1,:) = para_calculation(driving_condition,ave_velocity);
    beta(2,:) = para_calculation(driving_condition,ave_acceleration);
    beta(3,:) = para_calculation(driving_condition,per_acceleration);
    beta(4,:) = para_calculation(driving_condition,per_deceleration);
    beta(5,:) = para_calculation(driving_condition,per_cruise);
    beta(6,:) = para_calculation(driving_condition,per_idling);
end