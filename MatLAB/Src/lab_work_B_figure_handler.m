%%% Con questo script vengono gestiti in maniera centralizzata tutti i
%%% salvataggi delle immagini.

extraOpt = {'title style={font={\huge\bfseries},yshift=1cm}',...
                        'legend style={font={\LARGE}}',...
                        'x tick label style={font={\Large}}',...
                        'y tick label style={font={\Large}}',...
                        'z tick label style={font={\Large}}',...
                        'xlabel style={font={\Large}}',...
                        'ylabel style={font={\Large}}',...
                        'zlabel style={font={\Large}}'};
                    % To get the bold font it should be used like...
                    %   {\Large\bfseries}

secPausa = 0.01;

fprintf("*** Conversione e salvataggio immagini Tikz ***\n...\n");

lab_work_A_init_routine;


% *** Esempio di salvataggio ***
% %% Plot delle forze (generalizzate) Fqm e check
% figure();
% subplot(2,1,1);
%     auto_plot(t,Fqm(1,:),Fqm(2,:),Fqm(3,:),...
%         'Andamendo delle forze generalizzate $F_{qm}$',...
%         '$F_{\lambda}$|$C_{\beta}$|$C_{\gamma}$','time (s)|(N) (Nm)');
% subplot(2,1,2);
%     auto_plot(t,WInvDyn,'','','');
%     hold on
%     auto_plot(t(2:end),WChInvDyn,...
%         'Andamento della potenza $W$',...
%         '$W$|$W_{Ch}$','time (s)|(W)');
% saveas(gcf,'MatLab/Plots/task_dinamica.m')


%% 
sensor_curve;
set(gcf,'visible','off')
matlab2tikz('filename',...
    'Assignment/Figures/Sensor_curve/sensor_curve.tex',...
    'showInfo',false,'strict',true,'standalone',true,...
    'extraaxisoptions',extraOpt);
pause(secPausa);



%% 
fprintf("*** Completato*** \n \n");
