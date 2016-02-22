function criteria = criteria_generation(driving_condition,beta)
    %drivin_conditon: 1*4    beta(N): 4*1
    %driving_condition(1): 1
    %driving_condition(2): weather
    %driving_condition(3): traffic
    %driving_condition(4): aggressiveness
    criteria(1) = driving_condition * beta(1,:)';    %ave_velocity
    criteria(2) = driving_condition * beta(2,:)';    %ave_acceleration
    criteria(3) = driving_condition * beta(3,:)';    %per_acceleration
    criteria(4) = driving_condition * beta(4,:)';    %per_deceleration
    criteria(5) = driving_condition * beta(5,:)';    %per_cruise
    criteria(6) = driving_condition * beta(6,:)';    %per_idling
    disp(criteria);
end