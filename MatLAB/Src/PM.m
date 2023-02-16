function[IM]= PM(G)
% PM computes the participation matrix for an LTI system
%
%   IM = PM(G)
%
%   G :     MIMO System
%
% W. Birk, LTU, 2014-05-22

if (isa(G,'lti')~=1)
    error('Need an LTI system as input.');
end

if (isproper(G)~=1)
    error('Can only process proper LTI systems.');
end

if issiso(G)
    error('Can only process MIMO LTI systems.');
end

[m,n]=size(G);
IM=zeros(m,n);
for k=1:m
    for l=1:n
        sv=hsvd(G(k,l));
        IM(k,l)=sum(sv.^2);
    end
end
IM=IM/sum(sum(IM));