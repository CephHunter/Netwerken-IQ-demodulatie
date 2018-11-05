%% AM modulatie
Fs = 10000;
t_length = 3; % seconds
t = 0:1/Fs:t_length-1/Fs;
N = length(t);
signal = sin(2*pi*t);
% carrier = sin(2*pi*100*t);
subplot(3,2,1)
plot(t,signal)
title("Signal")

RF_0 = cos(2*pi*100*t);
RF_90 = sin(2*pi*100*t);
I_in = (0) .* RF_0;
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
axis([0 150 0 15000])
title("fft")

% Am demodulation
I = cos(2*100*pi*t).*modulated_signal;
Q = sin(2*100*pi*t).*modulated_signal;
received_signal = movmax(sqrt(I.^2 + Q.^2), 50);

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


























