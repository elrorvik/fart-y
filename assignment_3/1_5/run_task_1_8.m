clear;
close all;

tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)

u_d = 4;
m = 3.5512*10^3;   %a % eq 13.197
d_1 = 0.003*10^3;  % b
d_2 = 0.004*10^3;  %c 

lambda = 0.1; 
K_i = lambda^2;
K_p = 2*lambda;
sim MSFartoystyring_1_8 % The measurements from the simulink model are automatically written to the workspace.

u = v(:,1);
v = v(:,2);
psi = psi;
r = r;
x = p(:,1);
y = p(:,2);

figure(1);
subplot(211); plot(t,u); title('u');hold on;
subplot(212); plot(t,v); title('v'); hold on;

