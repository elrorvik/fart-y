close all;
clear all;
clc;

parameters_longitudal_autopilot; % get parameters

d = 10*deg2rad;
regulation_time = 100;
t_end = 3*regulation_time + regulation_time;

figure(1)

time = 0:1:t_end-1;

chi_c_part_1 = 5*deg2rad.*ones(1, regulation_time)';
chi_c_part_2 = 15*deg2rad.*ones(1, regulation_time)';
chi_c_part_3 = 0*deg2rad.*ones(1, regulation_time)';
chi_c = timeseries([chi_c_part_1; chi_c_part_2; chi_c_part_3]');


model = 'lateral_autopilot_full_2g.slx';
Legend = {};

i  = 1;
for integrator_error_limit = [0*deg2rad, 2*deg2rad, 10*deg2rad]
    Legend(i) = {strcat('IEL = ', num2str(integrator_error_limit*rad2deg))};
    i = i+1;
    load_system(model);
    simOut = sim(model);

    subplot(311)
    plot(chi.time,chi.signals.values.*rad2deg); hold on;

    subplot(312)
    plot(delta_a_c.time,delta_a_c.signals.values.*rad2deg); hold on; 

    subplot(313)
    plot(integrator.time, integrator.signals.values.*rad2deg);  hold on;
end

subplot(312)
legend(Legend); axis([0 t_end -35 35]);
title('Simulation of \delta'); xlabel('time (s)'),ylabel('deg'),grid

subplot(313)
legend(Legend); xlabel('time (s)'),ylabel('deg'),grid
title('The integral action of \chi ')

subplot(311)
plot(chi_c.time, [chi_c_part_1; chi_c_part_2; chi_c_part_3].*rad2deg); hold on;
Legend_2 = cat(2,Legend,{'\chi_c'});
legend(Legend_2); title('Simulation of \phi'); xlabel('time (s)'),ylabel('deg'),grid
title('Simulation of \chi')