clc;
clear all;
close all;    


% First example

% syms n
% f =sin(n);
% ztrans(f)

% second example
% syms m n
% f =exp(m+n);
% ztrans(f);

% Third example
% syms n

% f= (0.8*0.5^n)-(0.5*0.8^n)/0.3 ;
% ztrans(f);

% Fouth example
% syms f(n) z
% f(n) = 1/n;
% F = iztrans(f,z,n);
% F=ztrans(1/n,n,z)

x = [zeros(1, 10) ones(1, 7) zeros(1, 10)];
a = [1];
b = [1/4 1/4 1/4 1/4];
z = filter (b, a, x);
f14 = figure("Name", 'Signals');
set(f14, 'color', '#BDACE4');

subplot(2, 1, 1)

stem(x, 'color', '#F5A9F7', 'LineWidth', 2)

xlabel('n', 'color', '#ad2750')
ylabel('x[n]', 'color', '#ad2750')
title('Signal x[n]', 'color', '#0d6efd')
subplot(2, 1, 2)

stem(z, 'color', '#F5A9F7', 'LineWidth', 2)
title('Signal x[n]', 'color', '#0d6efd')
xlabel('n', 'color', '#ad2750')
ylabel('x[n]', 'color', '#ad2750')
