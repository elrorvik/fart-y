clear;
close all;

addpath(genpath('../header_control'));
parameters_heading_controller; % pick up parameters

deg2rad = pi/180;
rad2deg = 180/pi;

tstart=0;           % Sim start time
tstop=2000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[4 0]';       % Initial velocity (body)
psi0=0*deg2rad;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=1;                % Current on (1)/off (0)

wn = 0.0017;
K = 0.98;
T = 590.2;

Kp_u = 80;%1.4550*1.5; %500*wn^2*T/K 
Ki_u = 0.08; %0.0042*1.5; %1000*wn^3*T/(10*K) 
Kd_u = 0;
e_u_limit = 0.7;

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
subplot(221); plot(t,u);hold on;
plot(u_d.time, u_d.signals.values, '--'), title('u'), legend('u','u_d');
subplot(223); plot(t,nc); title('nc'); hold on; legend('kp*e','ki*e');
subplot(222); plot(t,psi*rad2deg); title('\psi'); hold on;
subplot(224); plot(u_error.time, u_error.signals.values); title('u_{tilde}'); hold on;
%subplot(224); plot(t,dc*rad2deg); title('dc'); hold on; legend('kp*e','ki*e','kd*e');

