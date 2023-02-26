%% Script to handle the (ordinary) simulations

i=1;
sim_result=cell(1,2*3*3*3*2);
% fprintf("*** Simulink progress ***");
for tau_1_0=tau_1(1):diff(tau_1):tau_1(2)
    %Gu1_0=k1/(tau_1_0*s+1);
    for k_2_0=k_2(1):diff(k_2)/2:k_2(2)
        for tau_2_0=tau_2(1):diff(tau_2)/2:tau_2(2)
            for zeta_0=zeta(1):diff(zeta)/2:zeta(2)
                %Gu2_0=k_2_0/(tau_2_0^2*s^2+2*zeta_0*tau_2_0*s+1);

                for tau_3_0=tau_3(1):diff(tau_3):tau_3(2)
                    %Gu3_0=k3/(tau_3_0*s+1);

                    time_to_save_points=2;
                    sim('Sim/development_enviroment2',200);
                    sim_result{i}=robustness_sim;

                    simulink_progress(i)
                    i=i+1;
                end
            end
        end
    end
end
save Results/sim_result.mat sim_result