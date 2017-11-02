function [r_est, psi_est] = sim_nomoto1(x,delta_c,tstop,tsamp)
%     tstart = 0;
%     dc = delta_c;
tstop = tstop;
tsamp = tsamp;
dc = delta_c;
tstart = 0;
options = simset('SrcWorkspace','current');
sim('nomoto2',[],options);
r_est = double(r_est);
psi_est = double(psi_est);
end
