% fourrier example


% syms x ;

% fplot(triangularPulse(x), [-2 2])

syms t s
% f=t*exp(-4*t); 
% laplace(f)

f= s*(s+6)/((s+3)*(s^2+6*s+18))
ilaplace(f)