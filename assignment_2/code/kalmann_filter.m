function output = fcn(y, u, system_information_struct)
persistent P_priori init_flag x_priori

A_d = system_information_struct.A_d;
B_d = system_information_struct.B_d;
E_d = system_information_struct.E_d;
C = system_information_struct.C;
Q = system_information_struct.Q;
I = system_information_struct.I;
R = system_information_struct.R;

if isempty(init_flag) %check if first round 
    init_flag = 1;
    
    P_0_priori= eye(4); 
   
    x_0_priori = [0; 0; 0; 0; 0];
    P_priori = P_0_priori;
    x_priori = x_0_priori;
end

% 1) Compute Kalman gain
L = P_priori * C' * inv( C * P_priori * C' + R); 

% 2) update error covariance matrix
P = ( I - L*C)*P_priori*( I- L*C)' + L* R*L';

% 3) Update estimate with measurement
x_posteriori = x_priori + L * ( y - C*x_priori);

% 4) Project ahead
x_next_priori = A_d * x_posteriori + B_d*u;
P_next_priori = A_d*P*A_d' + E_d*Q*E_d';

x_priori = x_next_priori;
P_priori = P_next_priori; 

output = x_posteriori;