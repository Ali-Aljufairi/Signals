%%Program for the generation of unit impulse signal


f14=figure("Name",'Signals');
set(f14,'color','#BDACE4');
t= -2:1:2;
y=[zeros(1,2),ones(1,1),zeros(1,2)];
subplot(2,2,1);
stem(t,y ,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude','color','#D21D55')
xlabel('(a) n --.','color','#D21D55');
title ('impulse signal','color','#0d6efd');grid on;


%% Program for the generation of unit step sequence [u(n)-u(n-N]

 first = [zeros(1,1),ones(1,1),zeros(1,1)];
    second = [zeros(1,2),ones(1,1),zeros(
 
n=input('enter the N value');
t1=0:1:n-1;
y1=ones(1,n);
subplot(2,2,2);
stem(t1,y1,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude','color','#D21D55');
xlabel('(b) n --.','color','#D21D55');
title ('step sequence','color','#0d6efd');grid on;



%% Program for the generation of ramp sequence

n1=input('enter the length of ramp sequence');
t2=0:n1;
subplot(2,2,3);
stem(t2,t2,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude','color','#D21D55');
xlabel('(c) n --.','color','#D21D55');
title ('ramp sequence','color','#0d6efd');grid on;



%% Program for the generation of exponential sequence

n2=input('enter the length of exponential sequence');
t=0:n2;
a=input('Enter the a value');
y2=exp(a*t);
subplot(2,2,4);
stem(t,y2,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude','color','#D21D55');
xlabel('(d) n --.','color','#D21D55');
title ('exponential sequence','color','#0d6efd');grid on;


%% Program for the generation of sine sequence
f13=figure(2);
set(f13,'color','#BDACE4');
t=0:.01:pi;
y=sin(2*pi*t);
figure(2);
subplot(2,1,1);
plot(t,y,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude','color','#D21D55');
xlabel('(a) n --.','color','#D21D55');
title ('sine sequence','color','#0d6efd');grid on;


%% Program for the generation of cosine sequence

t=0:.01:pi;
y=cos(2*pi*t);
subplot(2,1,2);
plot(t,y,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude','color','#D21D55');
xlabel('(b) n --.','color','#D21D55');
title ('cosine sequence','color','#0d6efd');grid on;


%%  Program for linear convolution of the sequence x=[1, 2] and h=[1, 2, 4]
f17=figure("Name",'Signals');
set(f17,'color','#BDACE4');
x=input('enter the 1st sequence');
h=input('enter the 2nd sequence');
y=conv(x,h);
subplot(3,1,1);
stem(x,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude --.','color','#D21D55');
xlabel('(a) n --.','color','#D21D55');
subplot(3,1,2);
stem(h,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude --.','color','#D21D55');
xlabel('(b) n --.','color','#D21D55');
subplot(3,1,3);
stem(y,'color' ,'#AD2851' ,'lineWidth',2);
ylabel('Amplitude --.','color','#D21D55');
xlabel('(c) n --.','color','#D21D55');
disp('The resultant signal is');
y




























