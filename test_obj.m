clc;
global omega_c phi_mr tau k;
omega_c=2.51;
phi_mr=83.9;

x = [2.6992, 0, 0.6192, 0, 0.9694]; % start point away from the minimum
% disp('% k_p=x(1); k_i=x(2); k_d=x(3); lambda=x(4); mu=x(5);')
% disp(x);
% disp('obj_fun_apm(x)=');
% disp(obj_fun_apm(x));
% disp('simple_constraint(x)=');
[c,ceq]=simple_constraint(x);

% disp('ceq=')
% disp(ceq);
disp('Desired phase margin <phi_mr>=');
disp(phi_mr);
%% checking inside of obj_fun


k_p=x(1);
k_i=x(2);
k_d=x(3);
lambda=x(4);
mu=x(5);

delta=0.5;
omega_c_minus=omega_c*(1-delta);
omega_c_plus=omega_c*(1+delta);


%parallel computing
EE=k_d*omega_c^mu*sin(pi*mu/2) - k_i*omega_c^(-lambda)*sin(pi*lambda/2);
FF=k_p + k_i*omega_c^(-lambda)*cos(pi*lambda/2) + k_d*omega_c^mu*cos(pi*mu/2);
phi_m=(atan2(EE,FF) + atan2(1,omega_c*pi))/pi*180;

AA=k_d * omega_c_minus^mu * sin(pi*mu/2) - k_i*omega_c_minus^(-lambda)*sin(pi*lambda/2);
BB=k_p + k_i*omega_c_minus^(-lambda)*cos(pi*lambda/2) + k_d*omega_c_minus^mu*cos(pi*mu/2);
phi_m_minus=(atan2(AA,BB) + atan2(1,pi*omega_c_minus))/pi*180;

CC=k_d * omega_c_plus^mu * sin(pi*mu/2) - k_i*omega_c_plus^(-lambda)*sin(pi*lambda/2);
DD=k_p + k_i*omega_c_plus^(-lambda)*cos(pi*lambda/2) + k_d*omega_c_plus^mu*cos(pi*mu/2);
phi_m_plus= (atan2(CC,DD) + atan2(1,pi*omega_c_plus))/pi*180;

M1=100;

obj = M1 * abs(phi_mr-phi_m) - phi_m_minus - phi_m_plus;


disp('<phi_m>= ');
disp(phi_m);
% disp('<phi_m_minus>= ')
% disp(phi_m_minus);
% disp('<phi_m_plus>= ')
% disp(phi_m_plus);



%% 



disp('Plotting Bode plot:');
k_p=x(1); k_i=x(2); k_d=x(3); lambda=x(4); mu=x(5);
%k_p depends on k_i, k_d and 
k = 1.0263;
tau = 0.71;

% disp('Calculating FOPID open-loop transfer function');
s=fotf('s');
c_tf=k_p + k_i/s^lambda + k_d*(s^mu);%Test
p_tf=k/(tau*s+1)/s;
sys_tf=c_tf*p_tf;
[Gm,Pm,Wcg,Wcp] = margin(sys_tf)
%
% disp('Calculating IOPID open-loop transfer function');
ioKp = 1.95;ioKi = 0.369;ioKd = 1.48;%dynamic computing in futher
ioc_tf=ioKp+ioKi/s+ioKd*s;
p_tf=k/(tau*s+1)/s;
iosys_tf=ioc_tf*p_tf;
%
h1=figure(2);
bode(sys_tf);
grid on
hold on
bode(iosys_tf);
lgd=legend('FOPD','IOPID');
hold off
disp('Done.');