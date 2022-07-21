% Defining Prameters
Points = 2048;              % Sampling points

rBinary= randi([-1,1],1,Points);
             
Fc = 2;                     % Carrier frequency              
Fs = 8;                     % Sampling frequency            
Tb = 1/Fc;                  % The ratio of the bit rate in seconds   
nCycles=1;                  % Number of cycle period
t = 0:1/Fs:(nCycles-1/Fs);  % Time (period of one cycle)in seconds
Ac = 1;                     % Amplitude of the carrier signal           
Carrier = Ac*sin(2*pi*t);      % Carrier wave

bitStream = [];
carrierSignal = [];
helo = [];
i = 1;
while(i<=Points)
    if(rBinary(i))
        bitStream = [bitStream ones(1,length(Carrier))];   % If the bit stream is 1
    else
        bitStream = [bitStream zeros(1,length(Carrier))];  % If the bit stream is 0
    end
    carrierSignal = [carrierSignal Ac*Carrier];            % Finding the carrying sigals
    i = i+1;
end

hello = carrierSignal.*bitStream; 

fuck 
bits = 2*(bitStream-0.5);         % transfering bits
bpskSignal = carrierSignal.*bits; % Generating into BPSK by mutliplying carrierSignal with bis
plot(bits);
xlim([0 300]); ylim([-1.5 1.5]);

figure(1);
subplot(3,1,1); stairs(bitStream); title('Digital Signal'); xlim([0 300]); ylim([-0.2 1.2]); ylabel('Ampliutde V');
subplot(3,1,2); plot(carrierSignal); title('Carrier Signal'); xlim([0 150]); ylim([-1.2 1.2]);ylabel('Ampliutde V')
subplot(3,1,3); plot(bpskSignal); title('BPSK modulated signal'); xlim([0 150]); ylim([-1.2 1.2]);ylabel('Ampliutde V')