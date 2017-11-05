close all; clear all; clc; OPT = optimset('Display','off');

tstart = 0;       %Sim start time
tstop  = 5000;    %Sim stop time
tsamp  = 100;     %Sampling time (NOT ODE solver time step)

%System
p0  = zeros(2,1);           %Initial position (NED)
v0  = [6.63 0]';            %Initial velocity (body)[m/s]
psi0= 0;                    %Inital yaw angle [rad]
r0  = 0;                    %Inital yaw rate [rad]
c   = 0;                    %Current on (1)/off (0)

%parameters_heading_controller

% nomoto2 model param
num_s = -0.0003433;
num = -1.921*10^(-6);
denum_s = 0.006835;
denum = 2.158*10^(-5);

nc = 7.3;
dc_list = [3 8 17 25]*pi/180;
data_matrix = zeros(length(dc_list),7);
pid_matrix = zeros(length(dc_list),7);
for i = 1:length(dc_list)
    dc = dc_list(i);
    sim BoatyMcBoatface
    %u = v(:,1);
    dc_vec = dc*ones(length(r),1);
    data = iddata(r,dc_vec,tsamp);
    sys = tfest(data,2,1);
    sys_report = sys.Report;
    fit = sys_report.Fit.FitPercent;
    data_matrix(i,:) = [dc,sys.Numerator, sys.Denominator, fit];
    [C,info] = pidtune(sys,'PID');
    pid_matrix(i,:) = [dc*180/pi, C.Kp, C.Kd, C.Ki,info.Stable, info.CrossoverFrequency, info.PhaseMargin];
end
pid_matrix
data_matrix(2,:)



