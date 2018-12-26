
clear;

global omega_c phi_mr;
omega_c=2;
phi_mr=100;

% k_p=x(1);
% k_i=x(2);
% k_d=x(3);
% lambda=x(4);
% mu=x(5);
x0 = [0.9694,0.6192,1,0.5,0.5]; % start point away from the minimum
A=[];b=[];Aeq=[];beq=[];
lb=[-2,0];
ub=[2,5];
x = patternsearch(@obj_fun_apm,x0,A,b,Aeq,beq,lb,ub);
disp('% k_p=x(1); k_i=x(2); k_d=x(3); lambda=x(4); mu=x(5);')
disp(x);

disp('Plotting Bode plot:');
k_p=x(1); k_i=x(2); k_d=x(3); lambda=x(4); mu=x(5);
k = 1.0263;
tau = 0.71;

disp('Calculating FOPID open-loop transfer function');
s=fotf('s');
c_tf=k_p + k_i/s^lambda + k_d*(s^mu);%Test
p_tf=k/(tau*s+1)/s;
sys_tf=c_tf*p_tf;
%
disp('Calculating IOPID open-loop transfer function');
ioKp = 1.95;ioKi = 0.369;ioKd = 1.48;
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

