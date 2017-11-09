%% TTK4190
% parameters for heading controller universal

deg2rad = pi/180;
rad2deg = 180/pi;

%% Controller parameters - psi PID controller
Kp_psi = 6;
Ki_psi = 0;%7*10^(-4);
Kd_psi = 250;
delta_max = 25*deg2rad;

%% referance modell
zeta = 1;
omega_psi = 0.09;