
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