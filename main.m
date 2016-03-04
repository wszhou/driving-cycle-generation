clc
clear all
close all

num_profile = 16;    %%%%
num_microtrip = 89;   %%%%
specific_driving_condition = [1 0.6 0.9 0.8]; %%%

%driving_conditions = load('driving_conditions.mat');
%load('driving_conditions.mat');

driving_conditions = zeros(num_profile,4);
driving_conditions(:,1) = 1;
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
    ave_velocity         = ave(v_t);
    acceleration         = acc(v_t);
    [ave_acc,percentage] = per(v_t(:,2),acceleration);
    driving_conditions(i,2) = 0.05/percentage(4);
    acceleration         = acc1(v_t);
    [ave_acc,percentage] = per(v_t(:,2),acceleration);
    driving_conditions(i,3) = ave_acc;
    driving_conditions(i,4) = 10/ave_velocity;
end


beta = vali_parameter(num_profile,driving_conditions);

%[model_table,mdl_v,mdl_a,mdl_pa,mdl_pd,mdl_pc,mdl_pi] = analyse_mdl(num_profile,driving_conditions);

%group = group_microtrips(num_microtrip);

criteria = criteria_generation(specific_driving_condition,beta);

%sequence = cycle_generation(num_microtrip,criteria);

sequence = cycle_generation_dp(num_microtrip,criteria);
