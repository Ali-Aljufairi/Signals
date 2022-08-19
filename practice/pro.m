clear all, close all, clc
%%Create a simple signal with two frequencies
dt=.001;
t= 0:dt:1;
msg="Enter the values of the frequencies of the signal ";
input1=input(msg);

input2=input(msg+'2:');
fclean = sin(2*pi*input1*t) + sin(2*pi*input2*t); % Sum of 2 frequen
f= fclean + 2.5*randn(size(t));%Add some noise
nf=figure; set(gcf, 'Position',[1500 200 1000 1000],'Name', ...
    "Signal with noise",'color','#a6fcef');
subplot (3, 1,1)
plot(t,f,'color','#4990df', 'LineWidth', 2), hold on
plot(t, fclean, 'k', 'LineWidth',2.5)
grid off ;
l1 = legend ('Noisy', 'Clean' ); 
set (l1, 'FontSize',20)
ylim([-10 10]); set(gca, 'Fontsize',20)

%%Compute the Fast Fourier Transform FFT
n=length(t);
fhat = fft(f,n);% Compute the fast Fourier transform
PSD = fhat.*conj (fhat)/n; % Power spectrum (power per freq)
freq = 1/(dt*n)* (0:n); %Create x-axis of frequencies in Hzor
L=1:floor(n/2);% Only plot the first half of freqs
subplot(3,1,3) ; 
ax=gca;

set (gca, 'FontSize',16,'Color','none')
plot(freq(L), PSD (L),'c','LineWidth',3), hold on
set(gca,'FontSize',20)
%%Use the PSD to filter out noise
indices = PSD>100;% Find all freqs with large power
PSDclean = PSD.*indices;% Zero out all others
fhat = indices.*fhat;% Zero out small Fourier coeffs. in Y
ffilt = ifft (fhat); % Inverse FFT for filtered time signal
plot(freq(L), PSDclean(L), '-', 'Color','#6019ab', 'LineWidth',2.5)
l1=legend (' Noisy', 'Filtered'); set(l1,'Fontsize',20)
subplot(3,1,2); set(gca,'FontSize',16)
plot(t,ffilt,'Color', '#6019ab','LineWidth',2.5)
l1 = legend ('Filtered');
ylim([-10 10]); set(gca, 'FontSize', 20)
