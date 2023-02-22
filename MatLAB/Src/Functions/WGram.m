function [Gamma_c,Gamma_o] = WGram(G,Gf);
% Computation of weighted gramians via Lyapunov equations
% [Gamma_c,Gamma_o] = WGram(G,Gf)
%
%   Gamma_c :   controllability gramian
%   Gamma_o :   observability gramian
%   G :         linear system (LTI object)
%   Gf :        scalar filter (LTI object)
%
% W. Birk, 2002-05-18

if (nargin==0)
    error('Need at least one argument');
end

if (isa(G,'lti')~=1)
    error('Need an LTI object as input.');
end

if (isproper(G)~=1)
    error('Can only process proper LTI systems.');
end

if (nargin==1)
    % No weighting function given => standard gramians
    Gamma_c=gram(ss(G),'c');
    Gamma_o=gram(ss(G),'o');
else
    % Weighting function given => weighted gramians
    if (isa(Gf,'lti')~=1)
        error('Filter must be an LTI object.');
    end
    if (issiso(Gf)~=1)
        error('Can only use scalar filter LTI systems.');
    end
    
    % Discrete or continuous system
    if (G.ts~=0)
        discrete=1;
        if (Gf.ts==0)
            % Weight needs to be discrete too
            Gf=c2d(Gf,G.ts);
        end
    else
        discrete=0;
        if (Gf.ts~=0)
            % Weight needs to be continuous too
            Gf=d2c(Gf);
        end
    end
    
    % Make state space systems of G and Gf
    [no,ni]=size(G);
    Gss=ss(G);
    nx=size(Gss,'order');
    Gfss=ss(Gf);
    
    % Compute the controllability gramian
    % => Weighting function at the input side
    [a,b,c,d]=ssdata(series(Gfss*eye(ni,ni),Gss));
    nxf=size(a,1);
    if discrete
        Gc=dlyap(a,b*b');
    else
        Gc=lyap(a,b*b');
    end
    % Weighted gramian is the lower right submatrix
    Gamma_c=Gc(1:nx,1:nx);
    
    % Compute the observability gramian
    % => Weighting function at the output side
    [a,b,c,d]=ssdata(series(Gss,Gfss*eye(no,no)));
    nxf=size(a,1);
    if discrete
        Go=dlyap(a',c'*c);
    else
        Go=lyap(a',c'*c);
    end
    % Weighted gramian is the upper left submatrix
    Gamma_o=Go(nxf-nx+1:nxf,nxf-nx+1:nxf);            
end

% End of function
    
    