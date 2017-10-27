close all;
clear;

options = optimset('Display','off');

n_c_max = (85*2*pi)/60;

tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=100;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
u0 = v0(1);
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)

figNum = 0;
kMat = zeros(3, 5);
i = 1;

for n_c = [n_c_max, 6, 5, 2, 0]
    sim MSFartoystyring % The measurements from the simulink model are automatically written to the workspace.

    u = v(:,1);
    v = v(:,2);
    psi = psi;
    r = r;
    x = p(:,1);
    y = p(:,2);

    k0 = [900 0.9 0.1];
    F3 = @(k,t) sim_forward_speed_model_ulin(k,n_c,tstop,u0);
    lb = [600  -1 -1];
    ub = 10*[2000 1 1];
    kMat(:,i) = lsqcurvefit(F3,k0,t,u,lb,ub,options)
    figNum = figNum +1;
    figure(figNum);
    plot(t,u); hold on;
    plot(t,F3(kMat(:,i),t),'LineWidth',2); hold on;

    legend('real','est');
    i = i + 1;
end

figNum = figNum +1;
figure(figNum);
n_c = 6.5;
sim MSFartoystyring % The measurements from the simulink model are automatically written to the workspace.

u = v(:,1);
v = v(:,2);
psi = psi;
r = r;
x = p(:,1);
y = p(:,2);

for i = 1:5
    F3 = @(k,t) sim_forward_speed_model_ulin(k,n_c,tstop,u0);
    plot(t,u,'LineWidth',2); hold on;
    plot(t,F3(kMat(:,i),t)); hold on;
end
