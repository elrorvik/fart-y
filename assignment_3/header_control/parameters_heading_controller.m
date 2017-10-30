%% TTK4190
% parameters for heading controller universal

deg2rad = pi/180;
rad2deg = 180/pi;
%% Simulink heading regulator input parameters 

nc = 7.3; 
psi_d = 8*deg2rad;
%psi_d = -0.3*sin(0.008t);
r_d = 0*deg2rad;

%% Controller parameters - psi PID controller
Kp_psi = 0.8;
Ki_psi = 0.025/10*Kp_psi/5;
Kd_psi = 150;

% r PI controller (?)
%Kp_r = 1;
%Ki_r = 1;

% -- safe values, nomoto1
% Kp_psi = 0.9;
% Ki_psi = 0.025/10*Kp_psi;
% Kd_psi = 25;
% --

% -- safe values, ship
% Kp_psi = 0.8;
% Ki_psi = 0.025/10*Kp_psi/5;
% Kd_psi = 150;
% --

%% Model parameters

% nomoto1 model param
T = 197.5;
%K1 = 0.00466/dc; 
K1 = 0.089; % K=r/delta

% nomoto2 model param
num_s = -0.0003433;
num = -1.921*10^(-6);
denum_s = 0.006835;
denum = 2.158*10^(-5);
