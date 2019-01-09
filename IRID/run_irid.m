gam=0.9885+1;
Ts=.01;
dfod=irid_fod(gam,Ts,5); % Try this method
figure
pzmap(dfod)
%% To save the figure
saveas(gcf,'pzmap_analysis.png')
