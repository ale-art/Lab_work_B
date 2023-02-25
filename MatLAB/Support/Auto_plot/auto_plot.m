function p = auto_plot(varargin)
% La presente funzione è di supporto nel plot dei grafici. In particolare,
% consente di semplificare la procedura di plot dei grafici, quando in
% genere per una stessa variabile indipendente si vogliono confrontare
% correlazioni con diverse variabili indipendenti. Inoltre, permette di
% associare in maniera molto semplice un titolo al plot, nonchè poter
% specificare le voci da inserire nella legenda in maniera più comoda
% rispetto al classio legend('...','...',...).
% E' infine possibile specificare le etichette degli assi.
%
% Per poter funzionare, è necessario passare gli input nella forma:
%
%           auto_plot2(t,x,y,...,'title','x|y|...','xLab|yLab'),
%
% dove,:
%   - t (il primo parametro), rappresenta il vettore della variabili
%        indipendenti;
%   - x, y, ..., sono i vettori delle variabili dipendenti;
%   - 'title', la stringa del titolo;
%   - 'x|y ...', la stringa delle voci della legenda; in particolare,
%       ciascuna voce deve essere separata da un '|';
%   - 'xLab|yLab', stringa delle etichette degli assi; ciascuna voce deve
%       essere separata da un '|'.
%
% La funzione opera correttamente anche nel caso non si desideri assegnare
% titolo o voci della legenda (ma è obbligatorio passare delle stringhe
% vuote, come '').
%
% Per le voci degli assi, non è obbligatorio passare entrambe, ma anche
% solo quella dell'asse x.
%
% Di default la funzione permette di interpretare voce titolo e legenda con
% il markup di LaTeX


% *** Togliere commento per avere immagini larghezza A4 ***
set(gcf,'WindowState','maximized'); % Full screen

numPlotInputs = nargin - 4;

% L'ultimo parametro passato è la stringa degli elementi delle labels degli
% assi.
label_vect = strsplit(varargin{nargin},'|');
%     display(legend_vect);

% Il penultimo parametro passato è la stringa degli elementi della legenda.
legend_vect = strsplit(varargin{nargin-1},'|','CollapseDelimiters',false);
%     display(legend_vect);

% Il terzultimo parametro passato è la stringa del titolo.
myTitle = varargin{nargin-2};

x = varargin{1};

if numPlotInputs ~= -1
    for i = 1:numPlotInputs
        funToPlot{2*i-1} = x(:);
        funToPlot{2*i} = varargin{i+1};
    end
    p = plot(funToPlot{1:numPlotInputs*2});
    xlim([x(1),x(end)]);
end

if ~isempty(varargin{nargin-1})
    name = {};
    legend_vect = cellstr(strcat(legend_vect,"~~~"));
    for i = 1:(length(legend_vect))
        if legend_vect(i) == "~~~"
            legend_vect(i) = {''};
        end
        name(i) = legend_vect(i);
    end
    title(myTitle,'FontSize',10,'interpreter','latex');
    l = legend(name(:),'Location','NorthOutside','Orientation','horizontal', ...
        'Box','off','interpreter','latex', ...
        'FontSize',10);
    l.ItemTokenSize(1) = 15;
    set(l,'LineWidth',1.75);
else
    title(myTitle,'FontSize',10,'interpreter','latex');
end

if ~isempty(varargin{nargin})
    if length(label_vect) == 1
        xLab = label_vect(1);
        xlabel(xLab,'interpreter','latex');
    elseif length(label_vect) == 2
        xLab = label_vect(1);
        yLab = label_vect(2);
        xlabel(xLab,'interpreter','latex');
        ylabel(yLab,'interpreter','latex');
    else
        error('Attenzione, il parametro relativo le etichette è errato');
    end
end
grid on;

end