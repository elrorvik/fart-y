% some constants
deg2rad = pi/180;   
rad2deg = 180/pi;
g = 9.81;

V_g = 637/3.6; % m/s
Tl = 1/10;
delta_a_max = 25*deg2rad;
integrator_max = 25*deg2rad;
e_phi_max = 15*deg2rad;
zeta_phi = 0.707;

a_phi_1 = 2.87;
a_phi_2 = -0.65;

omega_n_phi = sqrt(abs(a_phi_2)*delta_a_max /e_phi_max);
k_p_phi = sign(a_phi_2)*delta_a_max /e_phi_max; 

k_d_phi = (2*zeta_phi*omega_n_phi - a_phi_1) / a_phi_2;
k_i_phi = 0; %temp

W_chi = 7;
zeta_chi = 1;
omega_n_chi = 1/W_chi*omega_n_phi;

k_p_chi = 2*zeta_chi*omega_n_chi*V_g/g;
k_i_chi = omega_n_chi^2*V_g/g;

A = [ -0.322 0.052 0.028 -1.12 ;
     0 0 1 -0.001 ;
     -10.6 0 -2.87 0.46 ;
     6.87 0 -0.04 -0.32 ;];
B = [ 0.002 0 -0.65 -0.02]';
C = [0 0 1 0 ;
     1 0 0 0  ;
     0 1 0 0 ];
D = [0 0 0]';
E = [0 0 0 0];
h = 0.01;
I= diag([1 1 1 1]);

A_d = I + A*h;
B_d = h*B;
E_d = h*E;
C_d = C;
D_d = D;

var_r = 2^2*deg2rad;
var_p = 0.5^2*deg2rad;
var_phi = 0.2^2*deg2rad;
Q = 10^(-6)*diag([1 1 1 1]);
R = diag([var_r var_p var_phi]);
