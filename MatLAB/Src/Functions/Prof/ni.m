function y = ni(G);
% NI computes the Niederlinski index for an LTI object
%

if ~isa(G,'lti')
    error('Input has to be an LTI object');
end

if size(G,1)~=size(G,2)
    error('Input need to be a square LTI object');
end

Gd=diag(diag(dcgain(G)));
y=det(dcgain(G))/det(Gd);

% end of function