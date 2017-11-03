close all; clear all; clc; OPT = optimset('Display','off');

tstart = 0;       %Sim start time
tstop  = 5000;    %Sim stop time
tsamp  = 100;      %Sampling time (NOT ODE solver time step)

%System
p0  = zeros(2,1);           %Initial position (NED)
v0  = [6.63 0]';            %Initial velocity (body)[m/s]
psi0= 0;                    %Inital yaw angle [rad]
r0  = 0;                    %Inital yaw rate [rad]
c   = 0;                    %Current on (1)/off (0)

addpath(genpath('../header_control'));
parameters_heading_controller

nc_list = [0 20 40 65 85]*2*pi/60;
data_matrix = zeros(length(nc_list),7);
pid_matrix = zeros(length(nc_list),7);
for i = 1:length(nc_list)
    nc = nc_list(i);
    sim '../header_control/heading_controller';
    u = v(:,1);
    nc_vec = nc*ones(length(u),1);
    data = iddata(u,nc_vec,tsamp);
    sys = tfest(data,2);
    sys_report = sys.Report;
    fit = sys_report.Fit.FitPercent;
    data_matrix(i,:) = [nc,sys.Numerator, sys.Denominator, fit];
    [C,info] = pidtune(sys,'PID');
    pid_matrix(i,:) = [nc, C.Kp, C.Kd, C.Ki,info.Stable, info.CrossoverFrequency, info.PhaseMargin];
end





