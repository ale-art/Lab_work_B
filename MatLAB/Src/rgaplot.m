function rgaplot(varargin)
% RGAPLOT   Generates a plot of the RGA contents over frequency
%           The elements are arranged in a array of plots
%           rgaplot(omega1,lambda1,omega2,lambda2,...,type);
%
%           lambda1 ... lambdaN is the RGA of 1st LTI ... nth LTI
%           omega1 ... omegaN is the respective frequency vector
%           type is the plot type used:
%               1   only the real part is plotted (used as default
%                   if type is omitted)
%               2   the absolute value is plotted
%               3   only the imaginary part is plotted
%               4   imaginary versus real part is plotted
%               5   the absolute value plus the sign is plotted
%               6   inhomogenuously scaled plot for the real part. Values
%                   between -0.5 and 1.5 are linearly scale. Above 1.5 the
%                   scaling is 2.5-exp(-alpha*(y-1.5)) or below -0.5 it is
%                   -1.5+exp(alpha*(y+0.5))  
%
% W. Birk, 2014-06-28, LTU 
%

NumIn=length(varargin);
if NumIn<3
    error('Not enough input arguments');
end
if mod(NumIn,2)==1
    type=floor(varargin{NumIn});
else
    type=1;
end
if (type<1) || (type>6)
    error('Unknown plot type');
end
num=floor(NumIn/2);
for i=1:num
    o{i}=varargin{i*2-1}; %#ok<AGROW>
    if i==1
        mino=min(o{i});
        maxo=max(o{i});
    elseif min(o{i})<mino
        mino=min(o{i});
    elseif max(o{i})<maxo
        maxo=max(o{i});
    end    
    l{i}=varargin{i*2}; %#ok<AGROW>
    if i==1
        [m,n,p]=size(l{i}); %#ok<NASGU>
    elseif (m~=size(l{i},1)) || (n~=size(l{i},2))
        error('Passed RGAs have to be for LTIs with the same number of inputs and outputs');
    end
end

clf;
framedsubplot(m,n);
set(gcf,'Name','RGA Plot');
minl=0;
maxl=1;

for y=1:m
    for x=1:n
        framedsubplot((y-1)*n+x)
        if type==1
            set(gca,'xscale','log')
            co=get(gca,'colororder');
            for i=1:num
                line(o{i},real(squeeze(l{i}(y,x,:))),'color',co(mod(i,7)+1,:),'linewidth',1);
            end    
            xlim([mino,maxo]);
            maxl=max([maxl,max(real(squeeze(l{i}(y,x,:))))]);
            minl=min([minl,min(real(squeeze(l{i}(y,x,:))))]);
        elseif type==2
            set(gca,'xscale','log')
            co=get(gca,'colororder');
            for i=1:num
                line(o{i},abs(squeeze(l{i}(y,x,:))),'color',co(mod(i,7)+1,:),'linewidth',1);
            end
            xlim([mino,maxo]);
            ylabel(['abs(\lambda_{',label,'})']);
            maxl=max([maxl,max(abs(squeeze(l{i}(y,x,:))))]);
            minl=min([minl,min(abs(squeeze(l{i}(y,x,:))))]);
        elseif type==3
            set(gca,'xscale','log')
            co=get(gca,'colororder');
            for i=1:num
                line(o{i},imag(squeeze(l{i}(y,x,:))),'color',co(mod(i,7)+1,:),'linewidth',1);
            end
            xlim([mino,maxo]);
            maxl=max([maxl,max(imag(squeeze(l{i}(y,x,:))))]);
            minl=min([minl,min(imag(squeeze(l{i}(y,x,:))))]);
        elseif type==4
            co=get(gca,'colororder');
            for i=1:num
                line(real(squeeze(l{i}(y,x,:))),imag(squeeze(l{i}(y,x,:))),'color',co(mod(i,7)+1,:),'linewidth',1);
            end
            maxl=max([maxl,max(imag(squeeze(l{i}(y,x,:))))]);
            minl=min([minl,min(imag(squeeze(l{i}(y,x,:))))]);
        elseif type==5
            set(gca,'xscale','log')
            co=get(gca,'colororder');
            for i=1:num
                line(o{i},sign(real(squeeze(l{i}(y,x,:)))).*abs(squeeze(l{i}(y,x,:))),'color',co(mod(i,7)+1,:),'linewidth',1);
            end
            xlim([mino,maxo]);
            maxl=max([maxl,max(sign(real(squeeze(l{i}(y,x,:)))).*abs(squeeze(l{i}(y,x,:))))]);
            minl=min([minl,min(sign(real(squeeze(l{i}(y,x,:)))).*abs(squeeze(l{i}(y,x,:))))]);
        elseif type==6
            set(gca,'xscale','log')
            co=get(gca,'colororder');
            for i=1:num
                lr=real(squeeze(l{i}(y,x,:)));
                alpha=5;
                lr(lr>1.5)=2.5-exp(-(lr(lr>1.5)-1.5)*alpha);
                lr(lr<-0.5)=-1.5+exp((lr(lr<-0.5)+0.5)*alpha);
                line(o{i},lr,'color',co(mod(i,7)+1,:),'linewidth',1);
            end
            line([mino,maxo],[1,1],'color','k','linestyle','-','linewidth',1);
            xlim([mino,maxo]);
            minl=-1.5;maxl=2.5;
        end
        box on
        if x==1
            ylabel(['y_',num2str(y)]);
        end
        if y==1
            title(['u_',num2str(x)]);
        end
    end
end

% Determine the x and y tick vectors
framedsubplot(1)
ylim([minl,maxl])
xlim([mino,maxo]);
if type==6
    yticks=[-1.5,-1,-0.5,0,0.5,1,1.5,2,2.5];
else
    yticks=get(gca,'ytick');
end
xticks=10.^(ceil(log10(mino)):floor(log10(maxo)));

% Fix the y-axis limits and the labels
for y=1:m
    for x=1:n
        framedsubplot((y-1)*n+x)
        ylim([minl,maxl]);
        xlim([mino,maxo]);
        set(gca,'ytick',yticks);
        if x>1
            set(gca,'yticklabel',[]);
        elseif type==6
            set(gca,'yticklabel',{'',sprintf('%4.1f',-1.5+exp(-0.5*alpha)),'-0.5','0','0.5','1','1.5',sprintf('%4.1f',2.5-exp(-0.5*alpha)),''});
            text(0.8*min(xticks),2.5,'$\infty$','Interpreter','latex','horizontalalignment','right');
            text(0.8*min(xticks),-1.5,'$-\infty$','Interpreter','latex','horizontalalignment','right');
        end
        set(gca,'xtick',xticks);
        if y<m
            set(gca,'xticklabel',[]);
        end
    end
end

% Create a label axes for all the text
axes('position',[0,0,1,1]);
axis off
if type==4
    hxl=text(0.55,0.05,'real(\Lambda)');
else
    hxl=text(0.55,0.05,'frequency (rad/sec)');
end
set(hxl,'horizontalalignment','center');
if type==1
    hyl=text(0.025,0.525,'real(\Lambda)');
elseif type==2
    hyl=text(0.025,0.525,'abs(\Lambda)');    
elseif type==3
    hyl=text(0.025,0.525,'imag(\Lambda)');    
elseif type==4
    hyl=text(0.025,0.525,'imag(\Lambda)');        
elseif type==5
    hyl=text(0.025,0.525,'sign\cdotabs(\Lambda)');
elseif type==6
    hyl=text(0.025,0.525,'scaled real(\Lambda)');
end
set(hyl,'horizontalalignment','center','rotation',90);
setfontsize(gcf,8);