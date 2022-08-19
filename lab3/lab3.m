
%%Example 1
fs = 200; % Sample frequency (Hz)
t = 0:1 / fs:20 - 1 / fs; % 20 sec sample
x = (1.3) * sin(2 * pi * 20 * t) ... % 15 Hz component
    + (1.7) * sin(2 * pi * 40 * (t - 2)) ... % 40 Hz component
    + 2.5 * gallery('normaldata', size(t), 4);
m = length(x); % Window length
n = pow2(nextpow2(m)); % Transform length
y = fft(x, n); % DFT
f = (0:n - 1) * (fs / n); % Frequency range
power = y .* conj(y) / n;
f14 = figure("Name", 'Signals');
set(f14, 'color', '#BDACE4');
plot(f, power, 'color', '#F5A9F7', 'LineWidth', 2);
ylabel('Frequency (Hz)', 'color', '#D21D55');
xlabel('Power', 'color', '#D21D55');
title ('Periodogram', 'color', '#0d6efd','FontSize',14,'FontName' ...
    ,'TimeNewRoman'); grid on

y0 = fftshift(y); % Rearrange y values 
f0 = (-n/2:n/2-1)*(fs/n); % 0-centered frequency range
power0 = y0.*conj(y0)/n; % 0-centered power 
plot(f0,power0, 'color', '#F5A9F7', 'LineWidth', 2);
xlabel('Frequency (Hz)', 'color', '#D21D55');
ylabel('Power', 'color', '#D21D55') ;
title('{\bf 0-Centered Periodogram}', 'color', ...
    '#0d6efd','FontSize', ...
     14,'FontName' ...
    ,'TimeNewRoman'); grid on



