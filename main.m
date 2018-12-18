%% AM modulatie
clear;
clc;
Fs = 10000;                 % Sample frequency
t_length = 3;               % signal length in seconds
t = 0:1/Fs:t_length-1/Fs;   % time steps
N = length(t);              % total number of datapoints
signal = sin(2*pi*t);       % Input signal
f_carrier = 100;            % carrier frequency
subplot(5,2,1)
plot(t,signal)
title("Signal")

% fourrier tranform of the input singnal
y = fft(signal);            % fft
fshift = (-N/2:N/2-1)*Fs/N; % frequency axis centered around 0
yshift = fftshift(y);       % fft centered around 0
subplot(5,2,2)
plot(fshift, abs(yshift))
axis([0 10 0 t_length*Fs/2])
title("fft input signal")

% DSB modulatie
modulated_signal = (1+signal) .* sin(2*pi*f_carrier*t);
subplot(5,2,3)
plot(t, modulated_signal)
title("Modulated signal")

% fourrier tranform of the modulated singnal
y = fft(modulated_signal);  % fft
fshift = (-N/2:N/2-1)*Fs/N; % frequency axis centered around 0
yshift = fftshift(y);       % fft centered around 0
subplot(5,2,4)
plot(fshift, abs(yshift))
axis([75 125 0 t_length*Fs/2])
title("fft modulated signal")

% Am demodulation
phi = 0;  % phase shift
IO_0 = cos(2*pi*f_carrier*t + phi);     % internal oscillator
IO_90 = sin(2*pi*f_carrier*t + phi);
I = IO_0 .* modulated_signal;
Q = IO_90 .* modulated_signal;

% filter signal
% https://stackoverflow.com/questions/1783633/matlab-apply-a-low-pass-or-high-pass-filter-to-an-array
tau = 0.1;  % low pass filter time constant
a = (1/Fs)/tau;
I_filtered = filter(a, [1 a-1], I);
Q_filtered = filter(a, [1 a-1], Q);
received_signal = sqrt(I_filtered.^2 + Q_filtered.^2);
subplot(5,2,5)
plot(t, I_filtered)
title("I")
subplot(5,2,6)
plot(t, Q_filtered)
title("Q")
subplot(5,2,7:8)
plot(t, received_signal)
title("Received signal")

% fourrier tranform of the demodulated singnal
y = fft(received_signal);   % fft
fshift = (-N/2:N/2-1)*Fs/N; % frequency axis centered around 0
yshift = fftshift(y);       % fft centered around 0
subplot(5,2,9)
plot(fshift, abs(yshift))
axis([0 10 0 t_length*Fs/2])
title("fft received signal")
subplot(5,2,10)
plot(fshift, abs(yshift))
axis([190 210 0 t_length*Fs/20])
title("fft received signal")


%% FM modulatie
clear;
clc;
Fs = 10000;                 % Sample frequency
t_length = 2;               % signal length in seconds
t = 0:1/Fs:t_length-1/Fs;   % time steps
N = length(t);              % total number of datapoints
signal = sin(2*pi*t);       % Input signal
f_carrier = 100;            % carrier frequency
subplot(5,2,1)
plot(t,signal)
title('signal')

% fourrier tranform of the input singnal
y = fft(signal);            % fft
fshift = (-N/2:N/2-1)*Fs/N; % frequency axis centered around 0
yshift = fftshift(y);       % fft centered around 0
subplot(5,2,2)
plot(fshift, abs(yshift))
axis([0 10 0 t_length*Fs/2])
title("fft input signal")

% FM modulation
RF_signal = cos(2*pi*f_carrier*t + 0.0005*cumsum(signal));
subplot(5,2,3)
plot(t, RF_signal)
title('RF modulated')

% fourrier tranform of the modulated singnal
y = fft(RF_signal);         % fft
fshift = (-N/2:N/2-1)*Fs/N; % frequency axis centered around 0
yshift = fftshift(y);       % fft centered around 0
subplot(5,2,4)
plot(fshift, abs(yshift))
axis([75 125 0 t_length*Fs/2])
title("fft modulated signal")

% IQ demodulation
phi = 0.0;  % phase shift
IO_0 = cos(2*pi*f_carrier*t + phi);     % internal oscillator
IO_90 = sin(2*pi*f_carrier*t + phi);
I = IO_0 .* RF_signal;
Q = IO_90 .* RF_signal;

% filter signal
a = (1/Fs)/0.1;
I_filtered = filter(a, [1 a-1], I);
Q_filtered = filter(a, [1 a-1], Q);
M = sqrt(I_filtered.^2 + Q_filtered.^2);
phi = atan(Q_filtered./I_filtered);
subplot(5,2,5)
plot(t, I_filtered)
title('I')
subplot(5,2,6)
plot(t, Q_filtered)
title('Q')
subplot(5,2,7:8)
plot(t, phi)
title("Received signal")

% fourrier tranform of the demodulated singnal
y = fft(phi);               % fft
fshift = (-N/2:N/2-1)*Fs/N; % frequency axis centered around 0
yshift = fftshift(y);       % fft centered around 0
subplot(5,2,9)
plot(fshift, abs(yshift))
axis([0 10 0 t_length*Fs/2])
title("fft received signal")
subplot(5,2,10)
plot(fshift, abs(yshift))
axis([190 210 0 t_length*Fs/20])
title("fft received signal")






















