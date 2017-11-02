clear;
close all;

addpath(genpath('../header_control'));
parameters_heading_controller; % pick up parameters

deg2rad = pi/180;
rad2deg = 180/pi;

tstart=0;           % Sim start time
tstop=20000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=[1500 500]';      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
psi0=50*deg2rad;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=1;                % Current on (1)/off (0)

wn = 0.0017;
K = 0.98;
T = 590.2;

Kp_u = 80; %500*wn^2*T/K 
Ki_u = 0.08; %1000*wn^3*T/(10*K) 
Kd_u = 0;
e_u_limit = 3;

L = 304.8;  %m
Delta = 2.5*L;
Kp_los = 1/Delta;
R_vel = 300;        %m
R_change_wp = 500;  %m
wp = load('WP.mat');
wp = [p0 wp.WP];

%nc = 7.3; 
psi_d = 0*deg2rad;
r_d = 0*deg2rad;
tstep = 500;
ustep0 = 4;
ustepend = 7;
u_d_vec = 4*ones(1, tstop);
u_d_vec(tstep:end) = 7*ones(1,tstop-tstep+1);

%u_d = timeseries(u_d_vec);

sim MSFartoystyring_2_4 % The measurements from the simulink model are automatically written to the workspace.

u = v(:,1);
v = v(:,2);
psi = psi;
r = r;
x = p(:,1);
y = p(:,2);
tstop = t(end);

pathplotter(x, y,  psi, tsamp, 2, tstart, tstop, 0, wp)

figure(5);
subplot(221); plot(t,u), title('u');
subplot(223); plot(t,nc); title('nc'); hold on; legend('kp*e','ki*e');
subplot(222); plot(t,psi*rad2deg); title('\psi'); hold on;
plot(t, psi_d*rad2deg), legend('\psi', '\psi_d');
subplot(224); plot(t,delta_c*rad2deg); title('\delta_c'); hold on;
%subplot(224); plot(t,dc*rad2deg); title('dc'); hold on; legend('kp*e','ki*e','kd*e');

figure(6);
plot(t,beta); hold on;
plot(t,chi);
plot(t,chi_d);
plot(t,psi); legend('\beta', '\chi', '\chi_d', '\psi');


