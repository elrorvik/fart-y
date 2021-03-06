close all; clear all; clc; OPT = optimset('Display','off');

set(0,'DefaultLineLineWidth',2);
set(0,'DefaultLegendFontSize',16);
set(0,'defaultAxesFontSize',11)
set(0,'defaultTextInterpreter','latex');
set(0,'defaultLegendInterpreter','latex');

green = [153, 204, 0];
orange = [255, 153, 51];
turquis = [0,153,153];
pink = [255,0,102];
purple = [204,153,255];
color = [green; orange; turquis; pink; purple]/255;

addpath(genpath('../header_control'));
%n = 10;
%old_colormap = get(0,'FactoryAxesColorOrder');
%set(0,'DefaultAxesColorOrder',brewermap(n,'Paired'))

tstart = 0;       %Sim start time
tstop  = 5000;    %Sim stop time
tsamp  = 100;      %Sampling time (NOT ODE solver time step)

%System
p0  = zeros(2,1);           %Initial position (NED)
v0  = [6.63 0]';            %Initial velocity (body)[m/s]
psi0= 0;                    %Inital yaw angle [rad]
r0  = 0;                    %Inital yaw rate [rad]
c   = 0;                    %Current on (1)/off (0)


parameters_heading_controller
delta_max = 25*pi/180;
delta_min = -delta_max;
psi_amp = 0;
psi_freq = 0.1;
%% first oder system
figure(1); hold on; xlabel('time [s]'); ylabel('speed [m/s]'); 
title('Estimation based on first order system','FontSize',12);
nc_list = [0 20 40 65 85]*2*pi/60;
Legend = {};
for i = 1:1:length(nc_list)
    nc = nc_list(i);
    sim '../header_control/heading_controller';
    u = v(:,1);
    k0 = [600 1];
    F = @(x,t) x(2)*nc - (x(2)*nc - v0(1))*exp(-t/x(1));
    k = lsqcurvefit(F, k0, t, u,[],[],OPT);
    figure(1);
    plot(t,u,'o','Color',color(i,:)); 
    plot(t,F(k,t),'Color',color(i,:)); 
    Legend(2*i-1) = {strcat('Ship, $n_c$ = ', int2str(nc_list(i)), ' rpm')};
    Legend(2*i)   = {strcat('Model, $n_c$ = ', int2str(nc_list(i)),' rpm, T=', num2str(k(1),4), ', K=', num2str(k(2),2))}; 
end

legend(Legend);
%set(0,'DefaultAxesColorOrder',old_colormap)
%n = 10;
%old_colormap = get(0,'FactoryAxesColorOrder');
%set(0,'DefaultAxesColorOrder',brewermap(n,'Paired'))


%% ulinear modell : forward speed modell
figure(2); hold on; xlabel('time [s]'); ylabel('speed [m/s]'); 
title('Estimation based on forward speed system','FontSize',12);
Legend = {};
for i =1:1:length(nc_list)
    nc = nc_list(i);
    sim '../header_control/heading_controller';
    u = v(:,1);
    k0 = [900 0.2 0.1];
    F = @(k,t)sim_forward_speed_model_ulin(k,nc,tstop,tsamp,v0(1));
    k = lsqcurvefit(F, k0, t, u,[600 0.2 0.09],[1150 0.6  0.13],OPT);
    figure(2);
    plot(t,u,'o','Color',color(i,:)); 
    plot(t,F(k,t),'Color',color(i,:));
    Legend(2*i-1) = {strcat('Ship, $n_c$ = ', int2str(nc_list(i)), ' rpm')};
    Legend(2*i)   = {strcat('Model, $n_c$ = ', int2str(nc_list(i)),' rpm, ' ,'k1=', num2str(k(1),4),', k2=', num2str(k(2),4), ',k2=', num2str(k(3),4))}; 
end
legend(Legend);
set(0,'DefaultAxesColorOrder',old_colormap);