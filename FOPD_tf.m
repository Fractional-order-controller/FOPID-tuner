gam=1.0497;
ww=[1e-4,1e3];
n=5;
kF1=1;
kF=1;
% ================
wb=ww(1); wh=ww(2); 
if kF==1, G=ousta_fod(gam,n,wb,wh);
else, G=new_fod(gam,n,wb,wh); end
num=G.num{1}; den=G.den{1}; T=1/wh; str='Fractional\n';
% MaskDescription=num;
if isnumeric(gam)
	if gam>0, str=[str, 'Der  s^' num2str(gam) ];
	else, str=[str, 'Int  s^{' num2str(gam) '}']; end
else, str=[str, 'Der  s^gam']; end
if kF1==1, G=G*tf(1,[T 1]); end
%%
[p,z] = pzmap(G);
max_pole = max(p)