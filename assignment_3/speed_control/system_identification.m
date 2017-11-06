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
delta_max = 25*pi/180;
delta_min = -delta_max;
psi_amp = 0;
psi_freq = 0.01;

number_of_poles = 1;

nc_list = [40 65 85]*2*pi/60;
%data_matrix = zeros(length(nc_list),11);% number of poles = 2, size 9
data_matrix = zeros(length(nc_list),7);% number of poles = 1, size 9
pid_matrix = zeros(length(nc_list),7);
for i = 1:length(nc_list)
    nc = nc_list(i);
    sim '../header_control/heading_controller';
    u = v(:,1);
    nc_vec = nc*ones(length(u),1);
    data = iddata(u,nc_vec,tsamp);
    sys = tfest(data,number_of_poles);
    [Wn,zeta] = damp(sys);
    sys_report = sys.Report;
    fit = sys_report.Fit.FitPercent;
    data_matrix(i,:) = [nc,sys.Numerator, sys.Denominator, fit, Wn, zeta];% size 7
    %data_matrix(i,:) = [nc,sys.Numerator, sys.Denominator, fit, Wn(1), Wn(2), zeta(1), zeta(2)];
    [C,info] = pidtune(sys,'PID');
    pid_matrix(i,:) = [nc, C.Kp, C.Kd, C.Ki,info.Stable, info.CrossoverFrequency, info.PhaseMargin];
end

%% comparinson with fartøy pid

v0  = [4 0]';            %Initial velocity (body)[m/s]
clf;
figure(1); hold on; xlabel('time [s]'); ylabel('speed [m/s]'); 
%title('Comparing modell and ship','FontSize',12);
title('Comparing modell and ship')
Legend = {};
ustepend = 7;
nc_list = [40 65 85]*2*pi/60;
e_u_limit = 100000;
tstep = 0;
tstop = 4000;
tstart = 0;
ustep0 = v0(1);
Kp_u = 80; %500*wn^2*T/K 
Ki_u = 0.08; %1000*wn^3*T/(10*K) 
Kd_u = 0;

wn_u_list = [2,0.05, 0.5]; % not needed on 1
zeta_u_list = [0.8,2,1];
nc_gain_list = [1.5, 0.05, 1];
Ki_u_gain_list = [1,0.3, 1]; % 1 means not done
for i = 1:1:length(nc_list)
    c = pid_matrix(i,:);
    if i ==1
        Ki_u_est = c(4)*0.7;
    end
    Ki_u_est = c(4)*0.7;
    Kd_u_est = c(3);
    Kp_u_est = c(2);
    
    Ki_u = c(4)*Ki_u_gain_list(i)
    Kp_u_ = c(2)
    nc_gain = nc_gain_list(i);
    
    wn_u = wn_u_list(i);
    zeta_u = zeta_u_list(i);
    
    den =data_matrix(i,2);
    num= data_matrix(i,3:4);

    sim 'comparing_modell_MSfartoy';
    u = v(:,1);
    %h_u = tf(data_matrix(i+2,2), data_matrix(i+2,3:4));
    %h_r = pid(Kp,Ki, Kd);
    %sys = 1/(h_u*h_r +1);
    %opt = stepDataOptions('InputOffset',4,'StepAmplitude',5);
    %[u_est,t_est] = step(sys); 
    figure(1);
    plot(t,u,'--'); hold on;
    plot(t,u_est); hold on;
    Legend(2*i-1) = {strcat('Ship, n_c = ', int2str(nc_list(i)), ' rpm')};
    Legend(2*i)   = {strcat('Modell, n_c = ', int2str(nc_list(i)), ' rpm')}; 
end
legend(Legend);



