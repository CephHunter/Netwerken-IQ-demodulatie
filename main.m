%% AM modulatie
Fs = 10000;
t_length = 6; % seconds
t = 0:1/Fs:t_length-1/Fs;
N = length(t);
signal = 0.5*sin(2*pi*t)+0.3*cos(2*pi*5*t);
f_carrier = 100;
subplot(3,2,1)
plot(t,signal)
title("Signal")

RF_0 = cos(2*pi*f_carrier*t);
RF_90 = sin(2*pi*f_carrier*t);
I_in = 0 .* RF_0;
Q_in = (1+signal) .* RF_90;
RF_signal = I_in + Q_in;

% modulated_signal = carrier .* (1 + signal);
modulated_signal = RF_signal;
subplot(3,2,2)
plot(t, modulated_signal)
title("Modulated signal")

y = fft(modulated_signal);
f = (0:N-1)*Fs/N;
fshift = (-N/2:N/2-1)*Fs/N;
yshift = fftshift(y);
subplot(3,2,3)
plot(fshift, abs(yshift))
axis([75 125 0 t_length*Fs/2])
title("fft")

% Am demodulation
I = cos(2*f_carrier*pi*t).*modulated_signal;
Q = sin(2*f_carrier*pi*t).*modulated_signal;
received_signal = movmax(sqrt(I.^2 + Q.^2), Fs/2/f_carrier);

a=1;
b=repelem(1/(Fs/2/f_carrier), Fs/2/f_carrier);
I=filter(b,a,I);
Q=filter(b,a,Q);
received_signal=filter(b,a,received_signal);

subplot(3,2,4)
plot(t,I)
title("I")
subplot(3,2,5)
plot(t,Q)
title("Q")
subplot(3,2,6)
plot(t,received_signal)
title("Recieved signal")

%% FM modulatie
clear;
clc;
Fs = 1000;
t_length = 6; % seconds
t = 0:1/Fs:t_length-1/Fs;
N = length(t);
signal = sin(2*pi*t)+0.5*cos(2*pi*5*t);
f_carrier = 100;
subplot(5,2,1:2)
plot(t,signal)
title('signal')

RF_signal = cos(2*pi*f_carrier*t + 1*signal);
subplot(5,2,3:4)
plot(t, RF_signal)
title('RF modulated')

I = cos(2*f_carrier*pi*t).*RF_signal;
Q = sin(2*f_carrier*pi*t).*RF_signal;
a=1;
b=repelem(1/(Fs/2/f_carrier), Fs/2/f_carrier);
I=filter(b,a,I);
Q=filter(b,a,Q);
M = sqrt(I.^2 + Q.^2);
phi = atan(Q./I);
subplot(5,2,5)
plot(t, I)
title('I')
subplot(5,2,6)
plot(t, Q)
title('Q')
subplot(5,2,7:8)
plot(t, M)
title('M')
subplot(5,2,9:10)
plot(t, phi)
title('phi')






















