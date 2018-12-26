function [obj] = obj_fun_apm(x)

k_p=x(1);
k_i=x(2);
k_d=x(3);
lambda=x(4);
mu=x(5);


global omega_c phi_mr; %preset parameters in main

delta=0.5;
omega_c_minus=omega_c*(1-delta);
omega_c_plus=omega_c*(1+delta);






%parallel computing
EE=k_d*omega_c^mu*sin(pi*mu/2) - k_i*omega_c^(-lambda)*sin(pi*lambda/2);
FF=k_p + k_i*omega_c^(-lambda)*cos(pi*lambda/2) + k_d*omega_c^mu*cos(pi*mu/2);
phi_m=pi + atan(EE/FF) + atan(1/omega_c/pi);

AA=k_d * omega_c_minus^mu * sin(pi*mu/2) - k_i*omega_c_minus^(-lambda)*sin(pi*lambda/2);
BB=k_p + k_i*omega_c_minus^(-lambda)*cos(pi*lambda/2) + k_d*omega_c_minus^mu*cos(pi*mu/2);
phi_m_minus= pi + atan(AA/BB) + atan(1/(pi*omega_c_minus));

CC=k_d * omega_c_plus^mu * sin(pi*mu/2) - k_i*omega_c_plus^(-lambda)*sin(pi*lambda/2);
DD=k_p + k_i*omega_c_plus^(-lambda)*cos(pi*lambda/2) + k_d*omega_c_plus^mu*cos(pi*mu/2);
phi_m_plus= pi + atan(CC/DD) + atan(1/(pi*omega_c_plus));

M1=10^1000;
M2=10^350;
M3=10^2;
U_c1=k_p + k_i*omega_c^(-lambda)*cos(pi*lambda/2) + k_d*omega_c^mu*cos(pi*mu/2);
U_c2=k_d*omega_c^mu*sin(pi*mu/2) + k_i*omega_c^(-lambda)*sin(pi*lambda/2);
obj = M1 * abs(phi_mr-phi_m) - phi_m_minus - phi_m_plus + M2*U_c1 + M3*U_c2;
end

