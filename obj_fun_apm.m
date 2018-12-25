function [obj] = obj_fun_apm(x)

k_p=x(1);
k_i=x(2);
k_d=x(3);
lambda=x(4);
mu=x(5);






EE=k_d*omega^lambda*sin(pi*lambda/2);
FF=1+k_d*omega^lambda*cos(pi*lambda/2);
phi_m=pi+atan(EE/FF)+atan(1/tau/pi);

AA=k_d * omega_c_minus^lambda * sin(pi*lambda) - k_i*omega_c_minus^(-lambda)*sin(pi*lambda/2);
BB=k_p + k_i*omega_c_minus^(-lambda)*cos(pi*lambda/2)+k_d*omega_c_minus^lambda*cos(pi*lambda/2);
phi_m_minus= pi + atan(AA/BB) + atan(1/pi*omega_c_minus);

CC=k_d * omega_c_plus^lambda * sin(pi*lambda) - k_i*omega_c_plus^(-lambda)*sin(pi*lambda/2);
DD=k_p + k_i*omega_c_plus^(-lambda)*cos(pi*lambda/2)+k_d*omega_c_plus^lambda*cos(pi*lambda/2);
phi_m_plus= pi + atan(CC/DD) + atan(1/pi*omega_c_plus);

M=100;
phi_mr=100;
obj = M * abs(phi_mr-phi_m) - phi_m_minus - phi_m_plus;
end

