clc; clear; close all;

% Load audio files
[x_mix, Fs] = audioread('NoisySignal.wav');     % Primary mic signal (target speech + noise)
[v1, ~] = audioread('NoiseRef1.wav');           % Reference mic 1 (construction noise)
[v2, ~] = audioread('NoiseRef2.wav');           % Reference mic 2 (crowd noise)

% Unify signal length (58 seconds of data)
sec = 58;  % Processing duration (seconds)
N = min([length(x_mix), length(v1), length(v2), round(Fs * sec)]);
x_mix = x_mix(1:N);  % Trim primary signal
v1 = v1(1:N);        % Trim noise reference 1
v2 = v2(1:N);        % Trim noise reference 2
noise_refs = [v1, v2];  % Combine noise reference channels

% NLMS adaptive filter parameters
order = 500;      % Filter taps (affects modeling accuracy and complexity)
beta = 0.3;       % Step size (0 < beta < 2 ensures stability)

% Execute NLMS noise cancellation
[noise_est, target_est, w] = nlms_noise_cancel(x_mix, noise_refs, order, beta);

%% Notch filter design (eliminates specific frequency interference)
f0 = 800;                       % Target interference frequency (Hz)
r = 0.98;                       % Pole radius (controls bandwidth, 0<r<1)
omega = 2 * pi * f0 / Fs;       % Digital angular frequency
% Generate 2nd-order IIR notch filter coefficients
b_notch = [1, -2*cos(omega), 1];          % Numerator coefficients
a_notch = [1, -2*r*cos(omega), r^2];      % Denominator coefficients

% Apply notch filter
target_filtered = filter(b_notch, a_notch, target_est);  

% Post-processing
target_filtered = target_filtered / max(abs(target_filtered));  % Peak normalization
soundsc(target_filtered, Fs); pause(6);                        % Play results
audiowrite('NLMS_Notch.wav', target_filtered, Fs);             % Save output
disp('Final denoised file generated: NLMS_Notch.wav');

% Time-domain waveform comparison
t = (0:N-1)/Fs;  % Create time axis
figure('Name','Noise Reduction Comparison','NumberTitle','off');

subplot(5,1,1);
plot(t, x_mix, 'k');
title('Original Mixed Signal x_{mix}');
ylabel('Amplitude'); ylim([-1 1]); grid on;

subplot(5,1,2);
plot(t, v1, 'r');
title('Noise Reference 1: Construction Noise v_1');
ylabel('Amplitude'); ylim([-1 1]); grid on;

subplot(5,1,3);
plot(t, v2, 'g');
title('Noise Reference 2: Crowd Noise v_2');
ylabel('Amplitude'); ylim([-1 1]); grid on;

subplot(5,1,4);
plot(t, target_est, 'b');
title('NLMS Output (Initial Speech Estimate)');
ylabel('Amplitude'); ylim([-1 1]); grid on;

subplot(5,1,5);
plot(t, target_filtered, 'm');
title('Final Output (NLMS + Notch Filter)');
xlabel('Time (s)'); ylabel('Amplitude');
ylim([-1 1]); grid on;