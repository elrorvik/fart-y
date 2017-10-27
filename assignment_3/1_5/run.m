%clear;
%close all;
tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)

n_c = 7.3;
sim MSFartoystyring % The measurements from the simulink model are automatically written to the workspace.

u = v(:,1);
v = v(:,2);
psi = psi;
r = r;
x = p(:,1);
y = p(:,2);

figure(1);
subplot(211); plot(t,u); title('u');hold on;
subplot(212); plot(t,v); title('v'); hold on;


figure(2);
subplot(211); plot(t,x); title('x');
subplot(212); plot(t,y); title('y');

figure(3);
subplot(211); plot(t,psi); title('\psi');
subplot(212); plot(t,r); title('r');


n_c_1 = 7.3;

n_c_vec = 7.3*ones(tstop*tsamp+1,1);
n_c_2 = 5;
u_1 = 5.9547;
u_2 = 4.0785;

c = 9.87*10^-6; %-( n_c_2 - n_c_1/u_1)/( u_2^2 /u_1 + u_2^2);
b = -1.22598; %1/u_2*(n_c_1 - c*u_1^2);
a = 1550;

h = 0.01; % 100 hz
u_est = zeros(tstop,1);
u_est(1) = v0(1);
v_est(1) = v0(2);
i = 1;
n_max = 85*2*pi/60;
for j = [0:h:tstop]
    n = n_c;
    u_dot = 1/a * ( n_c + b*u_est(i) + c*u_est(i)^2);
    u_est(i+1) = u_est(i) + h*u_dot;
    i = i+1;   
end

subplot(211); plot([0:h:tstop+h],u_est); hold on;
legend('true','est');
%plot(t,f);






