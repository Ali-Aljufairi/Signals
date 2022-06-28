%%  Find the sum  of numbers 
A = [450 150 350 200 125 134 32 150;
     250 250 150 200 123 134 32 50;
     130 50 250 100 120 10 32 50;
     50 15 250 120 123 13 32 150;
     220 15 250 200 120 14 32 20;
     250 10 50 40 13 134 32 40;
     50 10 20 20 12 13 32 30;
    150 10 250 200 20 16 32 150];
E=sum(A)  ;

%% Calculate the DCT matrix A. 
T=dct(A);


%% Third Question part 1 
x=0:01:30;
y=sin(x)+x-x.cos(x);
plot(y)
title('Signal')
xlabel('x=Time');
ylabel('y=sin(x)+x-xcos(x)')
