clear;
close all;

set(0,'DefaultLineLineWidth',2);
set(0,'DefaultLegendFontSize',16);
set(0,'defaultAxesFontSize',11)
set(0,'defaultTextInterpreter','latex');
set(0,'defaultLegendInterpreter','latex');

addpath(genpath('../controll_parameters'));
parameters_heading_controller; % pick up parameters
parameters_speed_controller;

deg2rad = pi/180;
rad2deg = 180/pi;

tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[4 0]';       % Initial velocity (body)
psi0=0*deg2rad;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=1;                % Current on (1)/off (0)

psi_d = 0*deg2rad;
r_d = 0*deg2rad;
tstep = 500;
ustep0 = 4;
ustepend = 7;

sim MSFartoystyring_1_8 

u = v(:,1);
v = v(:,2);
r = r;
x = p(:,1);
y = p(:,2);

figure(1);
subplot(311); plot(t,u), title('u','FontSize',12); xlabel('time[s]');ylabel('velocity [m/s]'); hold on;
subplot(311); plot(t,u_d); legend('u','$u_d$');
subplot(313); plot(t,nc*rad2deg); hold on;
subplot(313); plot(t,n_c*rad2deg); legend('kp*e','ki*e','$n_c$');
title('$n_c$','FontSize',12);  xlabel('time [s]');ylabel('shaft speed [deg/s]'); hold on;
subplot(312); plot(t,u_error); title('$\tilde{u}$','FontSize',12); xlabel('time [s]'); ylabel('velocity [m/s]'); hold on;
figure(2)
psi_d = zeros(length(psi),1);
subplot(311); plot(t, psi_d*rad2deg); hold on;
subplot(311); plot(t,psi*rad2deg); title('$\psi$','FontSize',12);xlabel('time [s]');ylabel('angle [deg]'); hold on;
legend('$\psi_d$', '$\psi$'); 
subplot(313); plot(t,delta_c*rad2deg); hold on; 
title('$\delta_c$','FontSize',12);  xlabel('time [s]');ylabel('angle [deg]'); hold on;
subplot(312); plot(t,psi_tilde*rad2deg);title('$\tilde{\psi}$','FontSize',12);xlabel('time [s]');ylabel('angle [deg]'); hold on;




