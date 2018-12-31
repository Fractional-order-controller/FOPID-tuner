%% IOPID
s=tf('s');
p=1.0263/(0.71*s+1)/s;
c=2.89+1.04/s+1.79*s;
io_sys=c*p;
bode(io_sys);
hold on
%% FOPID
s=fotf('s');
p=1.0263/(0.71*s+1)/s;
c=2.89+1.04/s+1.79*s;
fo_sys=c*p;
bode(fo_sys);

%% FOPD
s=fotf('s');
p=1.0263/(0.71*s+1)/s;

c=2.6992*(1+0.6192*s^0.9694);
%2016 paper has something wrong here

fopd_sys=c*p;
bode(fopd_sys);

% wc=2.51;




