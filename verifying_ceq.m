k_p=2.6992;
k_i=0;
k_d=2.6992*0.6192;
lambda=0;
mu=0.9694;
x=[k_p,k_i,k_d,lambda,mu];
obj=obj_fun_apm(x)
[c,ceq]=simple_constraint(x)
%%
% k_p=x(1); k_i=x(2); k_d=x(3); lambda=x(4); mu=x(5);
%     2.6000         0    3.9348         0    1.0000
% 
% obj_fun_apm(x)=
%    1.6646e+04
% 
% simple_constraint(x)=
% c=
%    -2.6000
%    -3.9348
% 
% ceq=
%    1.4730e-08
%    Conclusion: 
% ceq is wrong.