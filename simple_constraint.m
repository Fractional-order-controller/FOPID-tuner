function [c,ceq] = simple_constraint(x)
%SIMPLE_CONSTRAINT Summary of this function goes here
%   Detailed explanation goes here
global omega_c tau k
k_p=x(1);
k_i=x(2);
k_d=x(3);
lambda=x(4);
mu=x(5);

U_c1=k_p + k_i*omega_c^(-lambda)*cos(pi*lambda/2) + k_d*omega_c^mu*cos(pi*mu/2);
U_c2=k_d*omega_c^mu*sin(pi*mu/2) - k_i*omega_c^(-lambda)*sin(pi*lambda/2);



c=[-k_p; -k_d];
ceq=sqrt(U_c1^2 + U_c2^2)*k/omega_c/sqrt(tau^2*omega_c^2+1)-1;

end