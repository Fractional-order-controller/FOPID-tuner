
clear;clc;
tic
global omega_c phi_mr tau k;
omega_c=2.51;
phi_mr=83.9;

% k_p=x(1);
% k_i=x(2);
% k_d=x(3);
% lambda=x(4);
% mu=x(5);
ObjectiveFunction = @obj_fun_apm;
x0 = [2.6992, 0, 2.6992*0.6192, 0, 0.9694]; % start point away from the minimum
A=[];b=[];Aeq=[];beq=[];
lb=[2.6,0,0,0,0.5];
ub=[5,5,5,2,1.5];
ConstraintFunction = @simple_constraint;
x = patternsearch(ObjectiveFunction,x0,A,b,Aeq,beq,lb,ub, ...
    ConstraintFunction);
disp('% k_p=x(1); k_i=x(2); k_d=x(3); lambda=x(4); mu=x(5);')
disp(x);
disp('obj_fun_apm(x)=');
disp(obj_fun_apm(x));
disp('simple_constraint(x)=');
[c,ceq]=simple_constraint(x);
disp('c=');
disp(c);
disp('ceq=');
disp(ceq);


disp('Plotting Bode plot:');
k_p=x(1); k_i=x(2); k_d=x(3); lambda=x(4); mu=x(5);
%k_p depends on k_i, k_d and 
k = 1.02;
tau = 0.179;

disp('Calculating FOPID open-loop transfer function');
s=fotf('s');
c_tf=k_p + k_i/s^lambda + k_d*(s^mu);%Test
p_tf=k/(tau*s+1)/s;
sys_tf=c_tf*p_tf;
%
disp('Calculating IOPID open-loop transfer function');
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
toc
