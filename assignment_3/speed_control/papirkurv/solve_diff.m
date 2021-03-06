syms K T T1 T2

data_matrix = [

    4.1888  ,  0.0016  ,  1.0000  ,  0.0016 ,  98.2184  ,  0.0016  ,  1.0000;
    6.8068  ,  0.3120  ,  1.0000  ,  0.3180 ,  20.7147  ,  0.3180  ,  1.0000;
    8.9012  ,  0.0028  ,  1.0000  ,  0.0029 ,  99.1487  ,  0.0029  ,  1.0000]

a = data_matrix(i,2);
b = data_matrix(i,3);
c = data_matrix(i,3);
d = 9.609*10^-8;

eq1 = a/d == K;
eq2 = T*K == b/d;
eq3 = 1/d == T1*T2;
eq4 = (T1+T2) == c/d;

eq = [eq1,eq2,eq3,eq4];
S = solve(eq, K, T, T1, T2);
K_v = double(S.K(1));
T_v = double(S.T(1));
T1 = double(S.T1(1));
T2 = double(S.T2(1));

[K,T, T1, T2]
T = T1 + T2 - T;

%n_c_1 = 7.3;
%n_c_2 = 5;
%u_1 = 5.9547;
%u_2 = 4.0785;

%c = ( n_c_2 - n_c_1/u_1)/( u_1 - u_2^2);
%b = - 1/u_1*(n_c_1 + c*u_1^2);

%syms b c
%eq_1 = (n_c_1 == b*u_1 + c*u_1);
%eq_2 = (n_c_2 == b*u_2 + c*u_2);
%eq = [eq_1,eq_2];
%[b,c] = solve([eq_1,eq_2], b, c);
%b = double(b)



%syms y(t) a b c d
%ode = (diff(y,t)*a - b*y - c*y*y) == 0;
%cond = y(0) == 6.3;
%ySol(t) = dsolve(ode,cond)

% x = [a,b,c]; 
%f =@(x,t) (x(2)*(tanh((x(2)*((2*atanh((63*x(3))/(5*x(2)) + 1))/x(2) - t/x(1)))/2) - 1))/(2*x(3));

%x = lsqcurvefit(f,[0.5,0.5,0.5],t,u);

%u_est = (x(2)*(tanh((x(2)*((2*atanh((63*x(3))/(5*x(2)) + 1))/x(2) - t./x(1)))/2) - 1))/(2*x(3));
%plot(t,u_est); hold on;