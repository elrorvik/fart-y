s = tf('s');

Kp_u = 80; %500*wn^2*T/K 
Ki_u =  0.08; %1000*wn^3*T/(10*K) 
Kd_u = 0;
H_r = Kp_u + Ki_u/s;
% nc = 7;
K = 0.98;
T = 434;
H_u = K/(1+T*s);
H = 1/(H_u*H_r+1);
[wn,zeta,P] = damp(H_u) % wn = natural frequency, zeta = damping ratio , P = poles


% first order nc=0
%K = 1;
%T = 2017;
%H = K/(1+Ts);
%[wn,zeta,P] = damp(sys); % wn = natural frequency, zeta = damping ratio , P = poles

% nc = 2
%K = 1;
%T = 877,5;
%H = K/(1+Ts);
%[wn,zeta,P] = damp(sys); % wn = natural frequency, zeta = damping ratio , P = poles

% nc = 4;
%K = 0.98;
%T = 608.9;
%H = K/(1+Ts);
%[wn,zeta,P] = damp(sys); % wn = natural frequency, zeta = damping ratio , P = poles

% nc = 7;
K = 0.98;
T = 590.2;
H = K/(1+T*s);
[wn,zeta,P] = damp(H); % wn = natural frequency, zeta = damping ratio , P = poles

% nc = 9;
%K = 0.98;
%T = 353.5;
%H = K/(1+Ts);
%[wn,zeta,P] = damp(sys); % wn = natural frequency, zeta = damping ratio , P = poles



% table 12.2