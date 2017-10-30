function u_est = sim_forward_speed_model_ulin(k,n_c,tstop,tsamp,u0)
    tstart = 0;
    tau_1 = n_c;
    opt = simset('SrcWorkspace','current');
    sim('forward_speed_model_ulin',[],opt);
    u_est = double(u_est);
end