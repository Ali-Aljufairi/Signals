% fourrier example


% syms x ;

% fplot(triangularPulse(x), [-2 2])

syms z 

f1 =  ((z-1)*(z+0.8))/((z-0.5)*(z+0.2));
f2 = ((z+0.8))/((z+0.2)*(z-0.5));
f3 = (z^3+z+1)/((z^2+0.5*z+0.25)*(z-1));
f4 = ((z^2-1)*(z+0.8))/((z-0.5)^2*(z+0.2));


iztrans(f1) 
iztrans(f2)
iztrans(f3)
iztrans(f4)