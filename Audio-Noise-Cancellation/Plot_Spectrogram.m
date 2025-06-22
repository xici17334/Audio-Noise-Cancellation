%
% Plot Spectrogram
%

[y,Fs]=audioread('NoisySignal.wav');
spectrogram(y,512,256,512,Fs,'yaxis');
colorbar;
colormap blue;
