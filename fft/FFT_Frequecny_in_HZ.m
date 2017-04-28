%%
clear all;
close all;
clc;

%% Creating signal
Fs=1000;                            %Sampling fresquncy
T_inc=1/Fs;                         %Time increament
T_measure=1.5;                      %Duration of measurment
time=0:T_inc:T_measure - T_inc;     %Vector contains sampling time
L=length(time);                     %Lenght of signal             


%% Sum of a 60Hz and 120 Hz sinusoidal
f1=120;
f2=60;
phi1=1.5;
phi2=2.4;
amplitude1=1.5;
amplitude2=2.2;
y=amplitude1*sin(2.*pi.*f1*time+phi1) + amplitude2*sin(2.*pi.*f2*time+phi2);

%% ploting the signal
figure('Name','Signal in time domain'), plot(time(:), y(:) );
xlabel('Time)')
ylabel('Signal');

%% 
signal_FFT=fft(y,L)/L;
amplitude=2*abs( signal_FFT(1: floor(L/2) +1) );
frequency=Fs/2*linspace(0,1, floor(L/2) +1);

%% plotting the amplitude and frequecy in Hz
figure('Name','Signal in frequency domain'), plot(frequency, amplitude );
xlabel(' Frequency (HZ)')
ylabel('Amplitude');


%% plot using fftshift
c=-Fs/2:  Fs/L  :Fs/2-Fs/L;
figure('Name','Signal in frequency domain'),  plot(c,fftshift(abs( fft(y)  ))) ;
xlabel(' Frequecny Bins')
ylabel('Amplitude');
