clc;
close all;
clear all;
EMGSIG = load('emg_healthy.txt'); %replace the txt file accordingly
t = EMGSIG(:, 1);
y1 = EMGSIG(:, 2);
N = length(y1);
ls = size(y1);
f = 1/N;
fs = 3000;
T = 1/fs;
t1 = (0 : N-1) *T;
Nyquist = fs/2;
figure;
subplot (3,1,1);
plot(t,y1);
title ('EMG signal of single muscle of healthy patient');
xlabel ('time (sec)');
ylabel ('Amplitute (V)');
grid on;
Y= abs(fft(y1));
Y(1) = [];
power = abs(Y(1:N/2)).^2;
nyquist = 1/(2*0.001);
freq = (1:N/2)/(N/2)*nyquist;
subplot(212), plot(freq,power), grid on
xlabel('Sample number (in Frequency)')
ylabel('Power spectrumen');
title({'Single-sided Power spectrum' ...
 ' (Frequency in shown on a log scale)'});
axis tight
rms_y1 = sqrt(mean(y1.^2));
msgbox(strcat('RMS of EMG signal is = ',mat2str(rms_y1),''));
arv_y1 = abs(mean(y1));
msgbox(strcat('ARV of EMG signal is = ',mat2str(arv_y1),''));
y2 = detrend(y1);
figure;
rec_y = abs(y2);
plot (rec_y);
xlabel('Sample number (in Frequency)')
ylabel('Rectified EMG signal');
title({'Rectified EMG signal (Frequency in shown on a log scale)'});
figure;
xdft = fft(y1);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/length(y1):fs/2;
plot(freq,10*log10(psdx))
grid on
title(' Power spectrum FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
NFFT = 2 ^ nextpow2(N);
Y = fft(y1, NFFT) / N;
f = (fs / 2 * linspace(0, 1, NFFT / 2+1));
amp = ( 2 * abs(Y(1: NFFT / 2+1)));
figure;
plot(f,amp);
title('plot single-sided amplitude spectrume of the EMG signal')
xlabel('frequency (Hz)')
ylabel('|y(f)|')