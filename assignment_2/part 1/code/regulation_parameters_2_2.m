close all;
clear all;
clc;

parameters_longitudal_autopilot;
figNum = 1;

s = tf('s');
sys = ss(A,B,C,D);
Phi = inv(s*eye(5)-A);
trans = C*Phi*B + D;

% Task 2b
H_evCar = s*(s^2+(a_phi_1 + a_phi_2*k_d_phi)*s + a_phi_2*k_p_phi);
figure(figNum)
%controlSystemDesigner('rlocus',1/H_evCar);
rlocus(1/H_evCar);

H_phi_open = minreal(a_phi_2*(k_p_phi*s + k_i_phi)/(s^2*(s + a_phi_1 + a_phi_2*k_d_phi)));
H_phi_closed = H_phi_open/(1+H_phi_open);
H_chi_open = minreal(g/(V_g*s)*(H_phi_closed)*(k_i_chi/s+k_p_chi));
H_chi_closed = H_chi_open/(H_chi_open +1);

%%
opt = stepDataOptions('StepAmplitude', 15*deg2rad);
figure(figNum);
i = 1;
for W_chi = [5, 7, 10]
    omega_n_chi = 1/W_chi*omega_n_phi;
    k_p_chi = 2*zeta_chi*omega_n_chi*V_g/g;
    k_i_chi = omega_n_chi^2*V_g/g;
    
    H_chi_open = minreal(g/(V_g*s)*(H_phi_closed)*(k_i_chi/s+k_p_chi));
    H_chi_closed = H_chi_open/(H_chi_open +1);
    step(H_chi_closed, opt); hold on;
    Legend(i) = {strcat('W_\chi = ', num2str(W_chi))};
    i = i+1;
end
legend(Legend);
parameters_longitudal_autopilot;
%%
parameters_longitudal_autopilot;
figNum = figNum +1;
H_phi_open = minreal(a_phi_2*(k_p_phi*s + k_i_phi)/(s^2*(s + a_phi_1 + a_phi_2*k_d_phi)));
H_phi_closed = H_phi_open/(1+H_phi_open);
figure(figNum)
Legend = {};
i = 1;
for zeta_chi = [0.5, 0.8, 1, 1.2, 1.4]

    k_p_chi = 2*zeta_chi*omega_n_chi*V_g/g;
    H_chi_open = minreal(g/(V_g*s)*(H_phi_closed)*(k_i_chi/s+k_p_chi));
    H_chi_closed = H_chi_open/(H_chi_open +1);
    bode(H_chi_closed); hold on;
    Legend(i) = {strcat('\zeta_\chi = ', num2str(zeta_chi))};
    i = i+1;
end
legend(Legend)
parameters_longitudal_autopilot;
%% Task 2d

H_phi_open = minreal(a_phi_2*(k_p_phi*s + k_i_phi)/(s^2*(s + a_phi_1 + a_phi_2*k_d_phi)));
H_phi_closed = H_phi_open/(1+H_phi_open);
H_chi_open = minreal(g/(V_g*s)*(H_phi_closed)*(k_i_chi/s+k_p_chi));

figNum = figNum +1;
figure(figNum)
bode(H_phi_open); hold on; grid on;
bode(H_chi_open); legend('H_{\phi}','H_{\chi}');

figNum = figNum +1;
figure(figNum)
margin(H_phi_open);grid on; legend('H_{\phi}');

figNum = figNum +1;
figure(figNum)
margin(H_chi_open);grid on; legend('H_{\chi}');

% Changing the freq

omega_n_chi = omega_n_phi;

k_p_chi = 2*zeta_chi*omega_n_chi*V_g/g;

k_i_chi = omega_n_chi^2*V_g/g;

H_phi_open = minreal(a_phi_2*(k_p_phi*s + k_i_phi)/(s^2*(s + a_phi_1 + a_phi_2*k_d_phi)));
H_phi_closed = H_phi_open/(1+H_phi_open);
H_chi_open = minreal(g/(V_g*s)*(H_phi_closed)*(k_i_chi/s+k_p_chi));

figNum = figNum +1;
figure(figNum)
bode(H_phi_open); hold on; grid on;
bode(H_chi_open); legend('H_{\phi}','H_{\chi}'); title ('Equal natural frequencies');

figNum = figNum +1;
figure(figNum)
margin(H_phi_open);grid on; legend('H_{\phi}');

figNum = figNum +1;
figure(figNum)
margin(H_chi_open);grid on; legend('H_{\chi}');







