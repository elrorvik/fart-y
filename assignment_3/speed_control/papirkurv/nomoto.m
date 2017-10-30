N = 200000; % number of samples
h = 0.1; % sample time
xout = zeros(N,2);
x = zeros(6,1);
x(1)= 8.23;
delta_R = 5*(pi/180); % rudder angle step input
for i=1:N,
    xout(i,:) = [(i-1)*h ,x(3)];
    %x = [ u v r x y psi]
    u = [delta_R , 0];
    xdot = msfartoystyring(x,u, 0); % nonlinear Mariner model
    x = euler2(xdot,x,h); % Euler integration
end
% time-series
tdata = xout(:,1);
rdata = xout(:,2)*180/pi;
% nonlinear least-squares parametrization: x(1)=1/T and x(2)=K
x0 = [0.01 0.1]'
F = inline('exp(-tdata*x(1))*0 +x(2)*(1-exp(-tdata*x(1)))*5','x','tdata')
x = lsqcurvefit(F,x0, tdata, rdata);
plot(tdata,rdata,'g',tdata,exp(-tdata*x(1))*0 +x(2)*(1-exp(-tdata*x(1)))*5,'r'),grid