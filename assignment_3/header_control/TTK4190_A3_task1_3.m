%% TTK4190
% Assignment 3

clear all
close all
clc

% for convenience:
deg2rad = pi/180;
rad2deg = 180/pi;

%% from run.m
tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver plotime step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
psi0=0*deg2rad;     % Inital yaw angle
r0=0;               % Inital yaw rate
c=1;                % Current on (1)/off (0)

%% Task 1.3
% Design controller

%% Simulink input parameters 

delta_max = 25*deg2rad;
delta_min = -25*deg2rad;    
nc = 7.3; 

% Constant psi
psi_d = 8*deg2rad;
r_d = 0*deg2rad;

% Time-varying psi
%psi_d = -0.3*sin(0.008*t);
%r_d = -0.0024*cos(0.008*t);
psi_amp = -0.3;
psi_freq = 0.008;

%% Controller parameters

% psi PID controller
Kp_psi = 60;
Ki_psi = 0.07;
Kd_psi = 650;

% -- safe values, nomoto1
% Kp_psi = 0.9;
% Ki_psi = 0.025/10*Kp_psi;
% Kd_psi = 25;
% --

%-- safe values, nomoto2
% Kp_psi = 6;
% Ki_psi = 7*10^(-4);
% Kd_psi = 250;
% --

% -- safe values, ship
% Kp_psi = 0.8;
% Ki_psi = 0.025/10*Kp_psi/5;
% Kd_psi = 150;
% --

% -- safer values, ship standing still
% Kp_psi = 60;
% Ki_psi = 0.07;
% Kd_psi = 650;
% --
%% Model parameters

% nomoto1 model param
T = 197.5; 
K1 = 0.089; % K=r/delta

% nomoto2 model param
num_s = -0.0003793;
num = -1.294*10^(-6);
denum_s = 0.009606;
denum = 3.237*10^(-5);
% num_s = -0.0003433;
% num = -1.921*10^(-6);
% denum_s = 0.006835;
% denum = 2.158*10^(-5);
T1 = 204;
T2 = 224;
T3 = 423;
K2 = -0.04;

%% Simulation

sim heading_controller
%sim heading_nomoto1_controller
%sim heading_nomoto2_controller

%% plot

% -- delta --
% figure(1)
% plot(t, delta_c)

% -- psi/r vs. psi/r_tilde --
% figure(2)
% plot(t, psi_tilde*rad2deg, t, r_tilde*rad2deg, t, psi*rad2deg, t, psi_d*rad2deg)
% legend('psi tilde', 'r tilde', 'psi', 'psi d')

% -- psi og r --
% figure(10)
% subplot(2,1,1)
%     plot(t, psi*rad2deg, t, psi_d*rad2deg)
%     xlabel('time')
%     ylabel('yaw (\psi)')
%     legend('psi sim', 'psi d')
% subplot(2,1,2)
%     plot(t, -r*rad2deg, t, -r_d*rad2deg)
%     xlabel('time')
%     ylabel('-yaw rate (-r)')
%     legend('-r sim', '-r d')
    
% -- psi og r (fra simulink) --
figure(10)
subplot(2,1,1)
    plot(t, psi_simu*rad2deg, t, psi_d_simu*rad2deg, t, psi_tilde*rad2deg)
    xlabel('time')
    ylabel('yaw (\psi)')
    legend('psi sim', 'psi d', 'psi tilde')
subplot(2,1,2)
    plot(t, r_simu*rad2deg, t, r_d_simu*rad2deg, t, r_tilde*rad2deg)
    xlabel('time')
    ylabel('yaw rate (r)')
    legend('r sim', 'r d', 'r tilde')

%-- psi --
% figure(11)
% plot(t, psi_simu*rad2deg)
% xlabel('time')
% ylabel('yaw (\psi)')

% -- position (x og y) --
% figure(2)
% subplot(2,1,1)
%     plot(t, p(:,1))
%     xlabel('time')
%     ylabel('x')
% subplot(2,1,2)
%     plot(t, p(:,2))
%     xlabel('time')
%     ylabel('y')