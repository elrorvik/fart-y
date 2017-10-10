%close all;
clear all;
%clc;

parameters_P3;
system_information_struct = struct('A_d',A_d,'B_d',B_d,'C_d',C_d,'E_d', E_d,'Q',Q,'I',I,'R',R);

d = 2*deg2rad;
t_end = 100;

regulation_time = 100;
t_end = 3*regulation_time + regulation_time;
time = 0:1:t_end-1;

chi_c_part_1 = 5*deg2rad.*ones(1, regulation_time)';
chi_c_part_2 = 15*deg2rad.*ones(1, regulation_time)';
chi_c_part_3 = 0*deg2rad.*ones(1, regulation_time)';
chi_c = timeseries([chi_c_part_1; chi_c_part_2; chi_c_part_3]');

noise_r = timeseries(random('norm', 0, sqrt(var_r),t_end,1)'); 
noise_p = timeseries(random('norm', 0, sqrt(var_p),t_end,1)');
noise_phi = timeseries(random('norm', 0, sqrt(var_phi),t_end,1)');

model = 'lateral_autopilot_3f.slx';
load_system(model);
simOut = sim(model);

figNum = 4;
figNum = figNum +1;
figure(figNum);
subplot(211);
plot(chi.time,chi.signals.values.*rad2deg); hold on; 
plot(chi_c.time, [chi_c_part_1; chi_c_part_2; chi_c_part_3].*rad2deg); hold on;
legend('\chi', '\chi_c');
title('Simulation of \chi')

subplot(212)
plot(delta_a_c.time,delta_a_c.signals.values.*rad2deg); hold on; axis([0 t_end -35 35]);
title('Simulation of \delta'); xlabel('time (s)'),ylabel('deg'),grid

Legend = {'noise contaminated value','estimated value','true value'};
figNum = figNum +1;
figure(figNum);
plot(phi_noise.time,phi_noise.signals.values.*rad2deg); hold on;
plot(phi_est.time,phi_est.signals.values.*rad2deg); hold on;
plot(phi.time,phi.signals.values.*rad2deg); hold on;
title('Simulation of \phi'); xlabel('time (s)'),ylabel('deg'),grid
legend(Legend);

figNum = figNum +1;
figure(figNum);
plot(r_noise.time,r_noise.signals.values.*rad2deg); hold on;
plot(r_est.time,r_est.signals.values.*rad2deg); hold on;
plot(r.time,r.signals.values.*rad2deg); hold on;
title('Simulation of r'); xlabel('time (s)'),ylabel('deg'),grid
legend(Legend);

figNum = figNum +1;
figure(figNum);
plot(p_noise.time,p_noise.signals.values.*rad2deg); hold on;
plot(p_est.time,p_est.signals.values.*rad2deg); hold on;
plot(p.time,p.signals.values.*rad2deg); hold on;
title('Simulation of p'); xlabel('time (s)'),ylabel('deg'),grid
legend(Legend);

