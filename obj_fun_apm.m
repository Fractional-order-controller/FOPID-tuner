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



%% 

k = 1.0263;
tau = 0.71;

% disp('Calculating FOPID open-loop transfer function');
s=fotf('s');
c_tf=k_p + k_i/s^lambda + k_d*(s^mu);%Test
p_tf=k/(tau*s+1)/s;
sys_tf=c_tf*p_tf;
% [Gm,Pm,Wcg,Wcp] = margin(sys_tf)
%% 
% if nargin==1, w=logspace(-4,4); end
% w=omega_c_minus;
% j=sqrt(-1); H1=freqresp(j*w,sys_tf); H1=frd(H1,w);
% [mag,phase,wout]=bode(H1,w)
%% 

%parallel computing
% EE=k_d*omega_c^mu*sin(pi*mu/2) - k_i*omega_c^(-lambda)*sin(pi*lambda/2);
% FF=k_p + k_i*omega_c^(-lambda)*cos(pi*lambda/2) + k_d*omega_c^mu*cos(pi*mu/2);
% phi_m=pi + atan(EE/FF) + atan(1/omega_c/pi);
w=omega_c;
j=sqrt(-1); H1=freqresp(j*w,sys_tf); H1=frd(H1,w);
[mag,phase,wout]=bode(H1,w);
phi_m=180-phase;

% AA=k_d * omega_c_minus^mu * sin(pi*mu/2) - k_i*omega_c_minus^(-lambda)*sin(pi*lambda/2);
% BB=k_p + k_i*omega_c_minus^(-lambda)*cos(pi*lambda/2) + k_d*omega_c_minus^mu*cos(pi*mu/2);
% phi_m_minus= pi + atan(AA/BB) + atan(1/(pi*omega_c_minus));
w=omega_c_minus;
j=sqrt(-1); H1=freqresp(j*w,sys_tf); H1=frd(H1,w);
[mag,phase,wout]=bode(H1,w);
phi_m_minus=180-phase;

% CC=k_d * omega_c_plus^mu * sin(pi*mu/2) - k_i*omega_c_plus^(-lambda)*sin(pi*lambda/2);
% DD=k_p + k_i*omega_c_plus^(-lambda)*cos(pi*lambda/2) + k_d*omega_c_plus^mu*cos(pi*mu/2);
% phi_m_plus= pi + atan(CC/DD) + atan(1/(pi*omega_c_plus));
w=omega_c_plus;
j=sqrt(-1); H1=freqresp(j*w,sys_tf); H1=frd(H1,w);
[mag,phase,wout]=bode(H1,w);
phi_m_plus=180-phase;

M1=100;

obj = M1 * abs(phi_mr-phi_m) - phi_m_minus - phi_m_plus;
end

