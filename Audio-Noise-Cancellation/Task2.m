clear; clc; close all;

[v2, Fs] = audioread('NoiseRef2.wav');
v2 = v2 - mean(v2);    
N = length(v2);

%no windowing
figure;
[pxx_std, f_std] = periodogram(v2, [], [], Fs);
plot(f_std, 10*log10(pxx_std));
xlabel('Frequency (Hz)'); ylabel('Power/Frequency (dB/Hz)');
title('Standard Periodogram ');
grid on;

% 5 windows
window_names = {'Rectangular','Bartlett','Hanning','Hamming','Blackman'};
figure;
for i = 1:length(window_names)
    win_type = window_names{i};
    switch win_type
        case 'Rectangular'
            win = ones(N,1);
        case 'Bartlett'
            win = bartlett(N);
        case 'Hanning'
            win = hanning(N);
        case 'Hamming'
            win = hamming(N);
        case 'Blackman'
            win = blackman(N);
    end
    [pxx, f] = periodogram(v2, win, [], Fs);
    subplot(3,2,i);
    plot(f, 10*log10(pxx));
    title([win_type]);
    xlabel('Frequency (Hz)'); ylabel('Power (dB)');
    grid on;
end

%welch method
L = 1000;               
over = 0.5;             % D
win_id = 2;             % 1 = Rectangular, 2 = Hamming, 3 = Hanning, 4 = Bartlett, 5 = Blackman

Px = welch(v2, L, over, win_id); 
f_welch = linspace(0, Fs/2, floor(length(Px)/2));

%plot
switch win_id
    case 1
        win_name = 'Rectangular';
    case 2
        win_name = 'Hamming';
    case 3
        win_name = 'Hanning';
    case 4
        win_name = 'Bartlett';
    case 5
        win_name = 'Blackman';
    otherwise
        win_name = 'Unknown';
end

figure;
plot(f_welch, 10*log10(Px(1:length(f_welch))));
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB)');
title(['Welch Method (' win_name ')']);
grid on;

