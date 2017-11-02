%% Heading model estimation using LSQ
set(0,'DefaultLineLineWidth',1.5);
set(0,'defaultfigurecolor','white');
%set(0,'defaulttextInterpreter','latex') %latex axis labels
close all;
clear all;  % remove for faster compilation
clc;
close all; clear all; clc; OPT = optimset('Display','off');
%%
tstart = 0;       %Sim start time
tstop  = 4000;    %Sim stop time
tsamp  = 40;     %Sampling time (NOT ODE solver time step)

%System
p0  = zeros(2,1);           %Initial position (NED)
v0  = [6.63 0]';            %Initial velocity (body)[m/s]
psi0= 0;                    %Inital yaw angle [rad]
r0  = 0;                    %Inital yaw rate [rad]
c   = 0;                    %Current on (1)/off (0)
deg2rad = pi/180;
rad2deg = 180/pi;

% Simulink parameters 
nc = 7.3; % rad
dc = 3*deg2rad;
psi_d = 8*deg2rad;

% sim BoatyMcBoatface

%% first order system
figure(1); hold on; grid on;xlabel('time [s]'); ylabel('yaw rate [deg/s]'); 
title('Estimation based on first order system','FontSize',12);
dc_list = [3 5 8 10 20]*deg2rad;
Legend = {};
for i = 1:1:length(dc_list)
    dc = dc_list(i);
    x0 = [100, 0.1];
    sim BoatyMcBoatface
%     r_func = @(x,t,dc) r0*exp(-t/x(1)) + x(2)* dc *(1 - exp(-t/x(1)));    
    %F = @(x,t) (1 - exp(-t/x(1)))*dc*x(2);
    r_func = @(x,t,dc) r0*exp(-t/x(1)) + x(2)* dc *(1 - exp(-t/x(1)));
    F4 = @(x,t) r_func(x,t,dc);
    x = lsqcurvefit(F4, x0, t, r,[],[],OPT);
    T = x(1);
    K  = x(2);
    figure(1);
    plot(t,-r*rad2deg,'o'); 
    plot(t,-F4(x,t)*rad2deg); 
    Legend(2*i-1) = {strcat('Ship, d_c = ', num2str(dc*rad2deg), ' deg')};
    Legend(2*i)   = {strcat('Model, d_c = ', num2str(dc*rad2deg),' deg, T=', num2str(x(1),4), ', K=', num2str(x(2),2))}; 
end
legend(Legend);
% figure(3);
% plot(t,psi);title('psi modell 1');
%% ulinear modell : forward speed modell
figure(2); hold on; xlabel('time [s]'); ylabel('yaw rate [m/s]'); 
title('Estimation of 2nd. order Nomoto','FontSize',12);
Legend = {};
for i =1:1:length(dc_list)
    dc = dc_list(i);
    sim BoatyMcBoatface;
    x0 = [118 7.8 18.5 0.089]';
    F = @(x,t) sim_nomoto2(x, dc, tstop, tsamp);
    [x,psi_est] = lsqcurvefit(F, x0, t, r,[100 100 0 -1],[300 300 400 0.2],OPT);
    T1 = x(1);
    T2 = x(2);
    T3 = x(3);
    K  = x(4);
    plot(t,-r*rad2deg,'o'); 
    plot(t,-F(x,t)*rad2deg);
    Legend(2*i-1) = {strcat('Ship, d_c = ', num2str(dc*rad2deg), ' deg')};
    Legend(2*i)   = {strcat('Model, d_c = ', num2str(dc*rad2deg),...
                    ' deg, ' ,'T1=', num2str(x(1)),', T2=',...
                    num2str(x(2)), ',T3=', num2str(x(3)),...
                    ',K=',num2str(x(4)))}; 
end
legend(Legend);
% plot(t,psi);title('Yaw rate,r, 2nd. order');

%%
scrsz = get(groot,'ScreenSize'); 
    
fig2 = figure('OuterPosition',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
hold on; grid on; ylabel('Yaw rate [deg/s]'); xlabel('Time [s]');
title('2st order linear Nomoto model compared to ship response','FontSize',14);
delta_list = [3 5 8 18]; %maks +-25deg
legend_string = cell(length(delta_list),1);
coeff_mtx = zeros(4,length(delta_list));
for i = 1:length(delta_list) 
    delta_c = deg2rad*(delta_list(i));
    dc = delta_c;
    sim BoatyMcBoatface;
    x0 = [118 7.8 18.5 0.089]';
    F = @(x,t) sim_nomoto2(x, dc, tstop, tsamp);
    [x,psi_est] = lsqcurvefit(F, x0, t, r,[100 100 0 -1],[300 300 400 0.2],OPT);
    T1 = x(1);
    T2 = x(2);
    T3 = x(3);
    K  = x(4);
%     x
    coeff_mtx(:,i) = [T1 T2 T3 K]';
    plot(t, -rad2deg*(r),'o' );
    plot(t, -rad2deg*(F(x,t)), 'LineWidth',2);
    text(500+delta_list(i)*40, 0.1,{['\delta=', num2str(delta_list(i))],['T1=',num2str(T1,3)],['T2=',num2str(T2,3)],['T3=',num2str(T3,3)],['K=',num2str(K,3)]});
    legend_string{2*i-1} = strcat('Ship, \delta = ',   int2str(delta_list(i)));
    legend_string{2*i}   = strcat('Nomoto1, \delta = ',int2str(delta_list(i)));
end
axis([0 tstop 0 0.55]);
legend(legend_string);
coeff_mean = mean(coeff_mtx,2)
T1 = coeff_mean(1);
T2 = coeff_mean(2);
T3 = coeff_mean(3);
K  = coeff_mean(4);

