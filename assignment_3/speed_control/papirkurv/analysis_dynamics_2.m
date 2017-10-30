close all;
clear;

options = optimset('Display','off');

tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=100;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
u0 = v0(1);
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)

n_c = 7.3;
sim MSFartoystyring % The measurements from the simulink model are automatically written to the workspace.

u = v(:,1);
v = v(:,1);
psi = psi;
r = r;
x = p(:,1);
y = p(:,2);

k0 = [942 8 0.1];
F = @(k,t) sim_forward_speed_mass_damp_model(k,n_c,tstop,u0);

k = lsqcurvefit(F,k0,t,u,[],[],options);
figure(1);
plot(t,u); hold on;
plot(t,F(k,t)); hold on;

legend('real','est');
