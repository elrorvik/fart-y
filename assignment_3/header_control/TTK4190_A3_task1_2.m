%% TTK4190
% Assignment 3

set(0,'DefaultLineLineWidth',2);
set(0,'defaultfigurecolor','white');
% n = 24;
% set(0,'DefaultAxesColorOrder',brewermap(n,'Set2'))
clear all
close all
clc

%% from run.m
tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver plotime step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)

%% Task 1.2
% Find and choose model

deg2rad = pi/180;
rad2deg = 180/pi;

% Simulink parameters 
nc = 7.3; % rad
dc = 3*deg2rad;
psi_d = 8*deg2rad;

% Nomoto 1st order
T = 197.5;
K1 = 0.00466/dc; %0.089; % K=r/delta

% Nomoto 2nd order
% 1st order er T = T1 + T2 - T3
% (one combo: 250, 325, 490)
T1 = 250;
T2 = 325;
T3 = 490;
diff_T = T-(T1+T2-T3);
K2 = 0.00466/dc; %0.089;

num_s = -0.0003433;
num = -1.921*10^(-6);
denum_s = 0.006835;
denum = 2.158*10^(-5);

sim heading_control_models

%% plot
% figure(1)
% subplot(2,1,1)
%     plot(t, psi*rad2deg)
%     xlabel('time')
%     ylabel('yaw (\psi)')
% subplot(2,1,2)
%     plot(t, -r)
%     xlabel('time')
%     ylabel('-yaw rate (-r)')
% 
% figure(2)
% subplot(2,1,1)
%     plot(t, p(:,1))
%     xlabel('time')
%     ylabel('x')
% subplot(2,1,2)
%     plot(t, p(:,2))
%     xlabel('time')
%     ylabel('y')
    
figure(3)
plot(t(1:2:500), -r(1:2:500)*rad2deg,...
     t(1:500), r_nomoto1(1:500)*rad2deg,...
     t(1:500), r_nomoto2(1:500)*rad2deg)%,...
     %t, r_nomoto2*rad2deg)
xlabel('time')
ylabel('r')
legend('-r', 'r nomoto1', 'r nomoto2', '- r nomoto2 2');

figure(4)
plot(t, -psi*rad2deg,...
     t, psi_nomoto1*rad2deg,...
     t, psi_nomoto2*rad2deg,...
     t, -psi_nomoto2_2*rad2deg)
xlabel('time')
ylabel('psi')
legend('-psi', 'psi nomoto1', 'psi nomoto2', '- psi nomoto2 2');

% %% Curvefitting 
% x = [0 1 2 3 4 5 6 7 8]'; %9 10 11]'; 
% y = 10^(-3)*[0 0.92 1.8317 2.7475 3.665 4.5793 5.495 6.411 7.327]'; %8.1523 8.1523 8.1523]';
% curve = fit(x, y, 'poly1'); 
% plot(curve,x,y)
