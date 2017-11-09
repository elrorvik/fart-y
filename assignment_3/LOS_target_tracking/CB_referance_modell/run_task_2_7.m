clear;
close all;

set(0,'DefaultLineLineWidth',2);
set(0,'DefaultLegendFontSize',16);
set(0,'defaultAxesFontSize',11)
set(0,'defaultTextInterpreter','latex');
set(0,'defaultLegendInterpreter','latex');

addpath(genpath('../../header_control'));
parameters_heading_controller; % pick up parameters
addpath(genpath('../../speed_control'));
parameters_speed_controller; 


omega_n_psi = 0.035;
omega_n_u = 0.005; % 0.0106
zeta_psi = 1;

deg2rad = pi/180;
rad2deg = 180/pi;

tstart=0;           % Sim start time
tstop=8000;        % Sim stop time
tsamp=100;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=[1500 500]';      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
psi0=50*deg2rad;    % Inital yaw angle
r0=0;               % Inital yaw rate
c=1;                % Current on (1)/off (0)

wn = 0.0017;
K = 0.98;
T = 590.2;

Kp_u = 80; %500*wn^2*T/K 
Ki_u = 0.08; %1000*wn^3*T/(10*K) 
Kd_u = 0;
e_u_limit = 0.7;
delta_max = 25*deg2rad;

L = 304.8;  %m
Delta = 10*L;
Kp_los = 1/Delta;
R_vel = 200;        %m
R_change_wp = 500;  %m
wp = load('WP.mat');
wp = wp.WP;
U_target = 3;     %m/s
U_max = 7;        %m/s - Wanted it to not be too agressive 
Delta_s = 1;      %m/s

%nc = 7.3; 
psi_d = 0*deg2rad;
r_d = 0*deg2rad;
tstep = 500;
ustep0 = 4;
ustepend = 7;
u_d_vec = 4*ones(1, tstop);
u_d_vec(tstep:end) = 7*ones(1,tstop-tstep+1);

% referance model
zeta = 1;
omega_psi = 1;

%u_d = timeseries(u_d_vec);
wn_u = 0.1;
zeta_u = 1;

sim MSFartoystyring_2_7 % The measurements from the simulink model are automatically written to the workspace.

u = v(:,1);
v = v(:,2);
psi = psi;
r = r;
x = p(:,1);
y = p(:,2);
tstop = t(end);

pathplotter(x, y,  psi, tsamp, 2, tstart, tstop, 1, wp)

figure(4);
subplot(221); plot(t,u), title('u','FontSize',12); xlabel('time[s]');ylabel('velocity [m/s]'); hold on;
subplot(221); plot(t,u_d); legend('u','$u_d$');
subplot(223); plot(t,n_c*rad2deg);  title('$n_c$','FontSize',12);  xlabel('time [s]');ylabel('shaft speed [deg/s]'); hold on;
subplot(222); plot(t,psi*rad2deg); title('$\psi$','FontSize',12);xlabel('time [s]');ylabel('angle [deg]'); hold on;
subplot(222); plot(t, psi_d*rad2deg); hold on;
subplot(222); plot(t,psi_tilde*rad2deg);legend('$\psi$', '$\psi_d$','$\tilde{\psi}_d$'); hold on;
subplot(224); plot(t,delta_c*rad2deg); title('$\delta_c$','FontSize',12); xlabel('time [s]'); ylabel('angle [deg]'); hold on;
%subplot(224); plot(t,dc*rad2deg); title('dc'); hold on; legend('kp*e','ki*e','kd*e');

figure(5);hold on;
subplot(211); plot(t,beta*rad2deg); title('$\beta$','FontSize',12);hold on; xlabel('time [s]'); ylabel('angle [deg]');
subplot(212);plot(t,psi*rad2deg); title('$\chi$ and $\psi$','FontSize',12);hold on;
subplot(212);plot(t,chi*rad2deg); xlabel('time [s]'); ylabel('angle [deg]');  hold on;
subplot(212); plot(t,chi_d*rad2deg); legend('$\psi$','$\chi$', '$\chi_d$'); hold on;



