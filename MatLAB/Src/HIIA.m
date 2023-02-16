function [Sigma,HSV]=HIIA(G,kind,Gf);
% HIIA computes the Hankel Interaction Index Array with generalisation
% to the use of different norms and weighting by a filter function
%
%   Sigma = HIIA(G,kind,Gf)
%
%   G :     MIMO System
%   kind :  1 -> Hankel norm (default)
%           2 -> H2 norm
%           3 -> Upper bound for infinity norm
%   Gf :    Scalar filter function (default: no weighting)
%
% W. Birk, LTU, 2017-01-10

if (isa(G,'lti')~=1)
    error('Need an LTI system as input.');
end

if (isproper(G)~=1)
    error('Can only process proper LTI systems.');
end

if issiso(G)
    error('Can only process MIMO LTI systems.');
end

weighted=0;
df=1;
if nargin==1
    kind=1;
elseif nargin==3
    weighted=1;
    df=dcgain(Gf);
end

[no,ni]=size(G);        %Determine the number of inputs and outputs
[a,b,c,d]=ssdata(G);    %Extract the state space matrices
nx=size(a,1);           %Determine the order of the model
if (G.ts==0)
    discrete=0;
else 
    discrete=1;
end

%Compute the HSV array
HSV=zeros(no,ni);
normal=0;
for i=1:no
    for j=1:ni
        % Computation of the gramian
        if discrete
            sys=ss(a,b(:,j),c(i,:),d(i,j),G.ts);
        else
            sys=ss(a,b(:,j),c(i,:),d(i,j));
        end        
        if weighted
            [Gamma_c,Gamma_o]=WGram(sys,Gf);
        else
            [Gamma_c,Gamma_o]=WGram(sys);
        end
        
        GP=Gamma_c*Gamma_o;
        
        if kind==1
            HSV(i,j)=sqrt( max( eig( GP )));
        elseif kind==2
            HSV(i,j)=sqrt( trace( c(i,:)*Gamma_c*c(i,:)' )) + norm(df*d(i,j),2);
        elseif kind==3
            HSV(i,j)=2*sum( sqrt( eig( GP )));
        else
            error('Unsupported choice for KIND');
        end
        normal=normal+HSV(i,j);
    end
end

Sigma=HSV/normal;

%End of function