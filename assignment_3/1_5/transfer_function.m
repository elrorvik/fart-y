
% nc = nc_max , second order
num = [0.132936079273262 4.074084240875063e-04];
den = [1 0.146384836056214 4.149139976838490e-04];
sys = tf(num,den);

% first order
num = [0.743250273462865 0.002796962315084];
den = [1 0.002848270514500];
sys = tf(num,den);

%margin(sys);
[wn,zeta,P] = damp(sys); % wn = natural frequency, zeta = damping ratio , P = poles

% table 12.2