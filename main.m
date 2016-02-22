clc
clear all
close all

num_profile = 8;    %%%%
num_microtrip = 65;   %%%%
specific_driving_condition = [1 0.1 0.1 0.1]; %%%

%driving_conditions = load('driving_conditions.mat');
load('driving_conditions.mat');

beta = vali_parameter(num_profile,driving_conditions);

%group = group_microtrips(num_microtrip);

criteria = criteria_generation(specific_driving_condition,beta);

%sequence = cycle_generation(num_microtrip,criteria);

sequence = cycle_generation_dp(num_microtrip,criteria);
