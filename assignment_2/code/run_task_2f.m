close all;
clear all;
clc;

parameters_longitudal_autopilot; % get parameters
d = 2*deg2rad;
regulation_time = 100;
t_end = 3*regulation_time;



time = 0:1:t_end-1;

chi_c_part_1 = 5*deg2rad.*ones(1, regulation_time)';
chi_c_part_2 = 15*deg2rad.*ones(1, regulation_time)';
chi_c_part_3 = 0*deg2rad.*ones(1, regulation_time)';
chi_c = timeseries([chi_c_part_1; chi_c_part_2; chi_c_part_3]');

model = 'lateral_autopilot_full.slx';
load_system(model);
simOut = sim(model);

figure(1)
subplot(211)
plot(chi.time,chi.signals.values.*rad2deg); hold on; 
plot(chi_c.time, [chi_c_part_1; chi_c_part_2; chi_c_part_3].*rad2deg); hold on;
legend('\chi', '\chi_c');
title('Simulation of \chi')

subplot(212)
plot(delta_a_c.time,delta_a_c.signals.values.*rad2deg); hold on; axis([0 t_end -35 35]);
title('Simulation of \delta')