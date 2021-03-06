% some constants
deg2rad = pi/180;   
rad2deg = 180/pi;

g               = 9.81;
V_g             = 637/3.6; % m/s
Tl              = 1/10;
delta_a_max     = 25*deg2rad;
integrator_max  = 25*deg2rad;
e_phi_max       = 15*deg2rad;
a_phi_1         = 2.87;
a_phi_2         = -0.65;

zeta_phi        = 0.707;
omega_n_phi     = sqrt(abs(a_phi_2)*delta_a_max /e_phi_max);
k_p_phi         = sign(a_phi_2)*delta_a_max /e_phi_max; 

k_d_phi         = (2*zeta_phi*omega_n_phi - a_phi_1) / a_phi_2;
k_i_phi         = 0; 

W_chi           = 10;
zeta_chi        = 1;
omega_n_chi     = 1/W_chi*omega_n_phi;

k_p_chi = 2*zeta_chi*omega_n_chi*V_g/g; % 3.75;
k_i_chi = omega_n_chi^2*V_g/g;

integrator_error_limit = 2.1*deg2rad;

A = [ -0.322 0.052 0.028 -1.12 0.002;
     0 0 1 -0.001 0;
     -10.6 0 -2.87 0.46 -0.65;
     6.87 0 -0.04 -0.32 -0.02;
     0 0 0 0 -10];
B = [ 0 0 0 0 10]';
C = [0 0 0 1 0;
     0 0 1 0 0;
     0 1 0 0 0];
D = [0 0 0]';

A_k = [ -0.322 0.052 0.028 -1.12 ;
         0 0 1 -0.001 ;
        -10.6 0 -2.87 0.46 ;
         6.87 0 -0.04 -0.32 ;];
B_k = [ 0.002 0 -0.65 -0.02]';
C_k = [0 0 0 1 ;
       0 0 1 0  ;
       0 1 0 0 ];
D_k = [0 0 0]';
E_k = eye(4);

h = 0.01; % 100 hz
I = eye(4);

[A_d,B_d] = c2d(A_k,B_k,h); %I + A_k*h; %cd2 B_d = h*B_k;
[A_d,E_d] = c2d(A_k,E_k,h);
C_d = C_k;
D_d = D_k;

var_phi = (2*deg2rad)^2;
var_p = (0.5*deg2rad)^2;
var_r = (0.2*deg2rad)^2;
Q = 10^(-6)*diag([1 1 1 1]);
R = diag([var_r var_p var_phi]);
