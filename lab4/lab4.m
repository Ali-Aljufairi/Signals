
% % Example 1 - Simple Example  
% % syms t 

% % f=5*exp(2*t);

% % L=laplace(f)


% % laplace(12*diff(sym('y'),2)) 

% clc;%reset the workspace command line
% clear all; %clear all the variables
% close all; %close all the plots
% %%====Please use your own value for R and C===================
% R = 10000; %10kohm
% C = 0.1*10^(-6); %0.1 uF
% %%============================================================
% vin = 5; %input amplitude=5 V
% a = [R*C 1 0]; %denominator
% b = vin; %numerator
% %%=========For Plotting==================
% set(gca,'fontsize',18,'FontWeight','bold','FontName','Times New Roman');

% f14 = figure("Name", 'Signals');
% set(f14, 'color', '#BDACE4');
% %%=======================================
% % Method 1: Residue
% display('Method1: Residue');
% [r, p, K] = residue (b, a)
% t=0:0.0001:0.01;
% VB=r(1)*exp(p(1)*t)+r(2)*exp(p(2)*t);
% subplot(1,2,1)
% plot(t, VB, 'color', '#F5A9F7', 'LineWidth', 2)
% xlabel('Time[s]', 'color', '#D21D55');
% ylabel('Voltage [V]', 'color', '#D21D55');

% title('{\bf Method 1 :Residue }', 'color', ...
%     '#0d6efd','FontSize', ...
%      14,'FontName' ...
%     ,'TimeNewRoman'); grid on


% % Method 2: Symbolic
% display('Method2: Symbolic');
% syms s
% F = b/(a(1)*s^2+a(2)*s)
% f = ilaplace(F)
% subplot(1,2,2)
% fplot(f, [0, 0.01], 'color', '#F5A9F7', 'LineWidth', 2);%ezplot plots function f over the specified range
% xlabel('Time[s]', 'color', '#D21D55');
% ylabel('Voltage [V]', 'color', '#D21D55');

% title('{\bf Method 2 :Symbolic}', 'color', ...
%     '#0d6efd','FontSize', ...
%      14,'FontName' ...
%     ,'TimeNewRoman'); grid on

clc
clear

% syms t 
% f=5*exp(-5*t);
% L=laplace(f);


% f2 = (t*sin(2*t) +exp(-2*t));
% L2=laplace(f2);



% f3 = sin(2*t)*cos(2*t) ;
% L3=laplace(f3);
clc 
clear

syms s

fa =(1/s*(s+2)*(s+3));
La=ilaplace(fa);

fb= (10/(s+1)^2*(s+3));
Lb=ilaplace(fb);

fc = (2*(s+1)/2*(s^2+s+2));
Lc=ilaplace(fc);

fd=(1/s +2/s+4 +1/s+5);
Ld=ilaplace(fd)