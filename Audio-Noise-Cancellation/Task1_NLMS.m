clc; clear; close all;

% Load audio files
[x_mix, Fs] = audioread('NoisySignal.wav');     % Mixed signal (speech + noise)
[v1, ~] = audioread('NoiseRef1.wav');           % Noise reference 1 (construction)
[v2, ~] = audioread('NoiseRef2.wav');           % Noise reference 2 (crowd)

% Set processing duration and trim signals
sec = 58;  % Processing duration in seconds
N = min([length(x_mix), length(v1), length(v2), round(Fs * sec)]);
x_mix = x_mix(1:N);
v1 = v1(1:N);
v2 = v2(1:N);
noise_refs = [v1, v2];  % Combine noise references into matrix

% NLMS Noise Cancellation Parameters
order = 500;       % Filter order (higher = better noise modeling but slower convergence)
beta = 0.3;        % Step size (0 < beta < 2 for stability)

% Perform noise cancellation
[noise_est, target_est, w] = nlms_noise_cancel(x_mix, noise_refs, order, beta);

% Normalize and output results
target_est = target_est / max(abs(target_est));    % Normalize amplitude
soundsc(target_est, Fs); pause(6);                 % Play processed audio
audiowrite('NLMS_Only.wav', target_est, Fs);       % Save output
disp('Processing complete. Saved as NLMS_Only.wav');

% Time vector for plotting
t = (0:N-1)/Fs;

% Create comparison plot
figure('Name','NLMS Noise Cancellation Results','NumberTitle','off');

subplot(4,1,1);
plot(t, x_mix, 'k');
title('Mixed Signal (x_{mix})');
ylabel('Amplitude');
ylim([-1 1]);  
grid on;

subplot(4,1,2);
plot(t, v1, 'r');
title('Noise Reference 1 (Construction Noise)');
ylabel('Amplitude');
ylim([-1 1]);
grid on;

subplot(4,1,3);
plot(t, v2, 'g');
title('Noise Reference 2 (Crowd Noise)');
ylabel('Amplitude');
ylim([-1 1]);
grid on;

subplot(4,1,4);
plot(t, target_est, 'b');
title('NLMS-Filtered Signal (Estimated Speech)');
xlabel('Time (s)');
ylabel('Amplitude');
ylim([-1 1]);
grid on;

% Optional: Add spectral analysis
figure('Name','Spectral Comparison','NumberTitle','off');
nfft = 2048;
f = (0:nfft/2-1)*Fs/nfft;
Pxx = abs(fft(x_mix,nfft)).^2/N;
Pyy = abs(fft(target_est,nfft)).^2/N;
semilogy(f,Pxx(1:nfft/2), hold on;
semilogy(f,Pyy(1:nfft/2), hold off;
legend('Original','Processed');
xlabel('Frequency (Hz)');
ylabel('Power Spectrum');
title('Spectral Comparison Before/After Processing');
grid on;