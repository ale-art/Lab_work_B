%% Estimating wI

% k1=1;
% k3=1;
% tau_1=[0.5 1.2];
% k_2=[0.9 1.1];
% tau_2=[0.5 2.5];
% zeta=[0.9 1];
% tau_3=[1 1.8];
% figure();

% Gu1_n=k1/(mean(tau_1)*s+1);
% Gu2_n=mean(k_2)/(mean(tau_2)^2*s^2+2*mean(zeta)*mean(tau_2)*s+1);
% Gu3_n=k3/(mean(tau_3)*s+1);

w=logspace(-3,3,200);

% *** Gu1 ***
lI=zeros(size(w'));
Gu1_n_w =squeeze(freqresp(Gu1_n,w));

figure()
leg_entries = '';
for tau_1_0=tau_1(1):diff(tau_1)/10:tau_1(2)
    Gu1_0=k1/(tau_1_0*s+1);
    Gu1_0_w=squeeze(freqresp(Gu1_0,w));
    q=abs((Gu1_0_w-Gu1_n_w)./Gu1_n_w);
    lI=max(lI,q);
    loglog(w,q,':','Color',blue,'LineWidth',0.75);
    hold on
    leg_entries = [leg_entries '|'];
end
loglog(w,lI,'Color',blue);
leg_entries = [leg_entries '$l_I$|'];

wI_u1=0.357*s/(0.357*s/0.7+1);   % Values got by the plot of lI

wI_u1_w=squeeze(freqresp(wI_u1,w));
loglog(w,abs(wI_u1_w),'--','Color',red);
leg_entries = [leg_entries '$w_{I_1}$'];

auto_plot('Estimating $w_{I_1}$',...
        leg_entries,'$\omega$ (rad/s)|magnitude');
saveas(gcf,'Plots/estimation_wI_u1.m')

% *** Gu2 ***
lI=zeros(size(w'));
% Gu2_n_w =squeeze(freqresp(Gu2_n,w));
Gu2_n_w = Gu2_n;

figure()
leg_entries = '';
for k_2_0=k_2(1):diff(k_2)/4:k_2(2)
    for tau_2_0=tau_2(1):diff(tau_2)/4:tau_2(2)
        for zeta_0=zeta(1):diff(zeta)/4:zeta(2)
            Gu2_0=k_2_0/(tau_2_0^2*s^2+2*zeta_0*tau_2_0*s+1);

            Gu2_0_w=squeeze(freqresp(Gu2_0,w));
            q=abs((Gu2_0_w-Gu2_n_w)./Gu2_n_w);
            lI=max(lI,q);
            loglog(w,q,':','Color',blue,'LineWidth',0.75);
            hold on
            leg_entries = [leg_entries '|'];
        end
    end
end
loglog(w,lI,'Color',blue);
leg_entries = [leg_entries '$l_I$|'];

wI_u2=(1/0.15*s+0.1)/(1/0.15*s/1.5+1);   % Values got by the plot of lI

%0.15 stands for the crossover frequency tau=1/0.2
%1.5 stands for r_infinity which is the gain at w-->infinity
%0.1 stands for r_0 is the gain at zero frequency

wI_u2_w=squeeze(freqresp(wI_u2,w));
loglog(w,abs(wI_u2_w),'--','Color',red);
leg_entries = [leg_entries '$w_{I_2}$'];

auto_plot('Estimating $w_{I_2}$',...
        leg_entries,'$\omega$ (rad/s)|magnitude');
saveas(gcf,'Plots/estimation_wI_u2.m')

% *** Gu3 ***
for tau_3_0=tau_3(1):diff(tau_3)/10:tau_3(2)
    Gu3_0=k3/(tau_3_0*s+1);
end

lI=zeros(size(w'));
Gu3_n_w =squeeze(freqresp(Gu3_n,w));

figure()
leg_entries = '';
for tau_3_0=tau_3(1):diff(tau_3)/10:tau_3(2)
    Gu3_0=k3/(tau_3_0*s+1);

    Gu3_0_w=squeeze(freqresp(Gu3_0,w));
    q=abs((Gu3_0_w-Gu3_n_w)./Gu3_n_w);
    lI=max(lI,q);
    loglog(w,q,':','Color',blue,'LineWidth',0.75);
    hold on
    leg_entries = [leg_entries '|'];
end
loglog(w,lI,'Color',blue);
leg_entries = [leg_entries '$l_I$|'];

wI_u3=(1/2.5*s)/(1/2.5*s/0.4+1);   % Values got by the plot of lI

wI_u3_w=squeeze(freqresp(wI_u3,w));
loglog(w,abs(wI_u3_w),'--','Color',red);
leg_entries = [leg_entries '$w_{I_3}$'];

auto_plot('Estimating $w_{I_3}$',...
        leg_entries,'$\omega$ (rad/s)|magnitude');
saveas(gcf,'Plots/estimation_wI_u3.m')