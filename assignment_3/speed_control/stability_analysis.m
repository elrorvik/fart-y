
solve_diff ; % finds nomoto speed coefficients
w_n = 1;
lambda = 1;
w_b = w_n*sqrt(1-lambda^2 + sqrt(4*lambda^4 - 4*lambda^2 +2))
K_u = K_v;
T_u = K_v;

Kp = 1000;
Ki = 0.1;
Kd = 0.2;

s = tf('s');

H_u = K_u*(1+ T_u*s)/((1+T1*s)*(1+T2*s));
H_r = Kp + Ki/s + Kd*s;

H_1 = H_u*H_r;
margin(H_u);