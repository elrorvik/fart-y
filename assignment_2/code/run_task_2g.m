close all;
clear all;
clc;

parameters_longitudal_autopilot; % get parameters
%change !!!!!
chi_c  = 10*deg2rad;
d = 30*deg2rad;
regulation_time = 100;
t_end = 3*regulation_time + regulation_time;

figure(1)

time = 0:1:t_end-1;

chi_c_part_1 = 5*deg2rad.*ones(1, regulation_time)';
chi_c_part_2 = 15*deg2rad.*ones(1, regulation_time)';
chi_c_part_3 = 0*deg2rad.*ones(1, regulation_time)';
chi_c = timeseries([chi_c_part_1; chi_c_part_2; chi_c_part_3]');

model = 'lateral_autopilot_full_2g.slx';
load_system(model);
simOut = sim(model);

subplot(311)
plot(chi.time,chi.signals.values.*rad2deg); hold on; 
plot(chi_c.time, [chi_c_part_1; chi_c_part_2; chi_c_part_3].*rad2deg); hold on;
legend('\chi', '\chi_c');

subplot(312)
plot(delta_a_c.time,delta_a_c.signals.values.*rad2deg); hold on; axis([0 t_end -35 35]);

subplot(313)
plot(integrator.time, integrator.signals.values.*rad2deg);  hold on;

subplot(311)
title('Simulation of \chi')
subplot(312)
title('Simulation of \delta')
subplot(313)
title('The saturated integrator values')