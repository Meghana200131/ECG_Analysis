clc;
load('100m.mat')
ECGsignal=(val-1024)/200;
Fs=360;
t=(0:length(ECGsignal)-1)/Fs
plot(t,ECGsignal)