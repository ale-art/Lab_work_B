%% Param init

line_width=0.5;
col1='b';
col2='b';
col3='b';


%% Handle data

n = length(sim_result);
for i=1:n
    sim_result_y1{i}=[sim_result{i}.Time, ...
        sim_result{i}.Data(:,1)];

    sim_result_y2{i}=[sim_result{i}.Time, ...
        sim_result{i}.Data(:,2)];

    sim_result_y3{i}=[sim_result{i}.Time, ...
        sim_result{i}.Data(:,3)];
end

%% Handle plots

% y1
figure();
hold on;
for i=1:length(sim_result)
   plot(sim_result_y1{i}(:,1),sim_result_y1{i}(:,2),col1, ...
       'LineWidth',line_width);
end
leg_entries = [repmat('|',1,n-1) '$y_1$'];
auto_plot('Estimating $w_I$',...
        leg_entries,'time (s)|magnitude');
saveas(gcf,'Plots/sim_result_y1.m')

% y2
figure();
hold on;
for i=1:length(sim_result)
   plot(sim_result_y2{i}(:,1),sim_result_y2{i}(:,2),col2, ...
       'LineWidth',line_width);
end
leg_entries = [repmat('|',1,n-1) '$y_2$'];
auto_plot('Estimating $w_I$',...
        leg_entries,'time (s)|magnitude');
saveas(gcf,'Plots/sim_result_y2.m')


% y3
figure();
hold on;
for i=1:length(sim_result)
   plot(sim_result_y3{i}(:,1),sim_result_y3{i}(:,2),col2, ...
       'LineWidth',line_width);
end
leg_entries = [repmat('|',1,n-1) '$y_3$'];
auto_plot('Estimating $w_I$',...
        leg_entries,'time (s)|magnitude');
saveas(gcf,'Plots/sim_result_y3.m')
