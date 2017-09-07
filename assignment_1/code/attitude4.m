%% Task 2.3
close all;
% some constants
deg2rad = pi/180;   
rad2deg = 180/pi;

% current parameters
U_c = 0.6; % m/s
alpha_c = 10 * deg2rad;
beta_c = 45 * deg2rad;

% Euler anlges init values
phi_0 = -1 *deg2rad;
theta_0 = 2.0 *deg2rad;
psi_0 = 0 * deg2rad;

%omega init values
p_0 = 0;
q_0 = 0;
r_0 = 0;

%% Task 2.4   Simulation and plotting

% Without current
t_end = 419*3;
h = 0.1;
N = t_end/h;
U = 1.5;
w = 0.859 * deg2rad ;                   % turning rate  of vechicle based on circular motion

v_n_b = zeros(N, 3);                    % velocities of body  realtive to ned in body coordinates                     
p_n_b = zeros(N, 3);                    % position of body realative to ned in ned coordinates

Theta = zeros(N, 3);                    % Euler angles  
w = zeros(N, 3);                        % omega 
              
Theta(1,:) = [phi_0, theta_0, psi_0];
w(1,:) = [p_0, q_0, r_0];

for i = 1:N-1;
    t = i*h
    
    R_n_b = Rzyx(phi,theta,psi);            % Rotation matrix from ned to body
    
    p_dot = -2*zeta_p*omega_p - omega_p^2*Theta(i,1);
    q_dot = -2*zeta_q*omega_q - omega_q^2*Theta(i,2);
    
    %% hmmm ??? 
    v_b_b = [U*cos(w*t); U*sin(w*t); 0];
    v_n_b(i+1,:) = (R_n_b * v_b_b)';
    
    if i == 0
        
    else
        p_n_b(i+1,:) = p_n_b(i,:) + v_n_b(i,:)*h;
        p_n_b_c(i+1,:) = p_n_b_c(i,:) + v_n_b_c(i,:)*h;
    end
    
end

% plotting without current

speed = ( v_n_b(:,1).^2 + v_n_b(:,2).^2 + v_n_b(:,3).^2 ).^(1/2);
crab_angle = asin(v_n_b(:,2)./speed) .* rad2deg;
sideslip_angle = asin(v_n_b(:,2)./speed) .* rad2deg;
course_angle = (psi*rad2deg).*ones(N,1) + crab_angle ;

t = [0:h:t_end-1*h]';
figure_num = 1;

figure(figure_num)
plot(t, p_n_b); xlabel('s'),ylabel('m'), title('Distance from initial point');legend('x','y','z');

figure_num = figure_num + 1;
figure(figure_num)
plot(p_n_b(:,1), p_n_b(:,2)), xlabel('east [m]'),ylabel('north [m]'), title('Plot of vechicle position without current'), grid;

figure_num = figure_num + 1;
figure(figure_num)
subplot(211), plot(t, v_n_b), xlabel('s'), ylabel('m/s'),title('Relative velocities'); legend('u','v','w');
subplot(212), plot(t,speed), xlabel('s'), ylabel('m/s'), title('Speed');

figure_num = figure_num + 1;
figure(figure_num)
plot(t, crab_angle), hold on; 
plot(t,sideslip_angle)
plot(t,course_angle);title('Crab-, slip- and courseangle'); xlabel('t'); ylabel('deg'); legend('\beta', '\beta_r','\chi');

% plots with current
speed_c = ( v_n_b_c(:,1).^2 + v_n_b_c(:,2).^2 + v_n_b_c(:,3).^2 ).^(1/2);
crab_angle = asin(v_n_b(:,2)./speed) .* rad2deg;
sideslip_angle = asin(v_n_b_c(:,2)./speed_c) .* rad2deg;
course_angle = (psi*rad2deg).*ones(N,1) + crab_angle;

figure_num = figure_num + 1;
figure(figure_num)
plot(t, s); xlabel('s'),ylabel('m'), title('Distance from initial point with current');legend('x','y','z');

figure_num = figure_num + 1;
figure(figure_num)
plot(s(:,1), s(:,2)), xlabel('east [m]'),ylabel('north [m]'), title('Plot of vechicle position with current'), grid;

figure_num = figure_num + 1;
figure(figure_num)
subplot(211), plot(t, v_n_b_c), xlabel('s'), ylabel('m/s'),title('Relative velocities with current'); legend('u','v','w');
subplot(212), plot(t,speed_c), xlabel('s'), ylabel('m/s'), title('Speed');

figure_num = figure_num + 1;
figure(figure_num)
plot(t, crab_angle), hold on
plot(t,sideslip_angle), hold on
plot(t,course_angle), hold on
title('Crab-, slip- and courseangle with current'), xlabel('t'), ylabel('deg'), legend('\beta', '\beta_r','\chi');
