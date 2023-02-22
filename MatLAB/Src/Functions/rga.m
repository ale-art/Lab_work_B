function [lambda,omega]=rga(G,omega)
%   [Lambda, Omega]=RGA(G,omega) 
%
%   Calculate the relative gain array (RGA) of an LTI-object G.
%   if no output arguments are given, a plot is displayed.
%
%   [Lambda, Omega]=RGA(G,omega)
%
%   Lambdar resulting DRGA frequency response matrix
%   Omega   resulting frequency vector
%   G       LTI object
%   omega   input frequency vector. If not supplied, the function will
%           determine an appropriate frequency vector for analysis.
%
%	 W. Birk 2014-05-22

if nargin~=2
	%   Only to get a well formated frequency vector
	[sv,omega]=sigma(G); %#ok<ASGLU>
end
%   Compute the frequency response
Gfrsp=freqresp(G,omega);

%   Compute the RGA over the frequency
lambda=zeros(size(G,1),size(G,2),length(omega));
for i=1:length(omega)
   lambda(:,:,i)=Gfrsp(:,:,i).*(pinv(Gfrsp(:,:,i))).';
end

if nargout==0
    % Plot the RGA
    clf;
    rgaplot(omega,lambda,1);
    clear lambda omega
end
