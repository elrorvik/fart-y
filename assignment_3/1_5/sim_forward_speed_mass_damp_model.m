function u_est = sim_forward_speed_mass_damp_model(k,n_c,tstop,tsamp,u0)
    tstart = 0;
    tau_1 = n_c;
    opt = simset('SrcWorkspace','current');
    sim('forward_speed__mass_damp_model',[],opt);
    u_est = double(u_est);
end