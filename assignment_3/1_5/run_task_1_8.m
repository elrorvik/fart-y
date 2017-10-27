clear;
close all;

deg2rad = pi/180;
rad2deg = 180/pi;

tstart=0;           % Sim start time
tstop=2000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)



m = 3.5512*10^3;   %a % eq 13.197
d_1 = 0.003*10^3;  % b
d_2 = 0.004*10^3;  %c 

K_p_u = 0.8;
K_i_u = 0.025/10*K_p_u/5;
u_d = 4;
e_u_limit = 100000000000;

Kp_psi = 0.8;
Ki_psi = 0.025/10*Kp_psi/5;
Kd_psi = 150;
psi_d = 0*rad2deg;

nc = 7.3; 

psi_d = 8*deg2rad;
r_d = 0*deg2rad;

sim MSFartoystyring_1_8 % The measurements from the simulink model are automatically written to the workspace.

u = v(:,1);
v = v(:,2);
psi = psi;
r = r;
x = p(:,1);
y = p(:,2);

figure(1);
subplot(221); plot(t,u); title('u');hold on;
subplot(223); plot(t,nc*rad2deg); title('nc'); hold on; legend('kp*e','ki*e');
subplot(222); plot(t,psi*rad2deg); title('psi'); hold on;
%subplot(224); plot(t,dc*rad2deg); title('dc'); hold on; legend('kp*e','ki*e','kd*e');

