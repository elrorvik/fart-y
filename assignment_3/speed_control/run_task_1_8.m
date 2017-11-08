clear;
close all;

set(0,'DefaultLineLineWidth',2);
set(0,'DefaultLegendFontSize',16);
set(0,'defaultAxesFontSize',11)
set(0,'defaultTextInterpreter','latex');
set(0,'defaultLegendInterpreter','latex');

addpath(genpath('../header_control'));
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


%nc = 7.3; 
psi_d = 0*deg2rad
r_d = 0*deg2rad;
tstep = 500;
ustep0 = 4;
ustepend = 7;
u_d_vec = 4*ones(1, tstop);
u_d_vec(tstep:end) = 7*ones(1,tstop-tstep+1);

%u_d = timeseries(u_d_vec);

sim MSFartoystyring_1_8 % The measurements from the simulink model are automatically written to the workspace.

u = v(:,1);
v = v(:,2);
psi = psi;
r = r;
x = p(:,1);
y = p(:,2);

figure(1);
subplot(221); plot(t,u), title('u','FontSize',12); xlabel('time[s]');ylabel('velocity [m/s]'); hold on;
subplot(221); plot(t,u_d); legend('u','$u_d$');
subplot(223); plot(t,n_c*rad2deg); hold on;
subplot(223); plot(t,nc*rad2deg); hold on; legend('$n_c$', 'kp*e','ki*e');
title('$n_c$','FontSize',12);  xlabel('time [s]');ylabel('shaft speed [deg/s]'); hold on;
subplot(222); plot(t,psi*rad2deg); title('$\psi$','FontSize',12);xlabel('time [s]');ylabel('angle [deg]'); hold on;
subplot(222); plot(t, psi_d*rad2deg); hold on;
subplot(222); plot(t,psi_tilde*rad2deg);legend('$\psi$', '$\psi_d$','$\tilde{\psi}_d$'); hold on;
subplot(224); plot(t,u_error); title('$\tilde{u}$','FontSize',12); xlabel('time [s]'); ylabel('velocity [m/s]'); hold on;
%subplot(224); plot(t,dc*rad2deg); title('dc'); hold on; legend('kp*e','ki*e','kd*e');

