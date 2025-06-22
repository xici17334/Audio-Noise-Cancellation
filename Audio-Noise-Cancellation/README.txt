This folder contains the following files:


NoiseRef1.wav       
	Audio from one of the interfering noise sources

NoiseRef2.wav       
	Audio from the other interfering noise source

NoisySignal.wav     
	Audio of the speech signal in the presence of interfering noise sources subject to room reverberation and additive hum

Plot_Spectrogram.m  
	MATLAB script for spectrogram construction of NoisySignal.wav

nlms_noise_cancel.m
	Constructing Multi-Channel NLMS Filters

Task1_NLMS.m
	For task 1 when NLMS is used, generate spectrograms comparing the target and hybrid sounds, noise and target sounds when only NLMS is used

Task1_NLMS+notch.m
	For task one when NLMS is used, generate the target sound and the hybrid sound when NLMS and Notch are used, the noise, and the spectrogram comparing the sound when only NLMS is used and the sound when Notch is used.

welch.m
	This MATLAB function estimates the power spectral density (PSD) of a discrete-time signal x using Welch's method

mper.m
	This function computes the Modified Periodogram of a signal x, which is a basic method for power spectral density (PSD) estimation.

Task2.m
	This script is used to compare the performance differences between the Periodogram and Welch's method for power spectrum estimation, and to analyze the effect of five common window functions (Rectangular, Bartlett, Hanning, Hamming, Blackman) on spectral resolution and leakage.

NLMS_Only.wav
	NLMS-generated sounds only

NLMS_Notch.wav
	NLMS+nlms generated sound
	
	




In addition to listening to the quality of the enhanced signal you can also calculate the spectrogram of the enhanced signal and compare with the clean spectrogram 



