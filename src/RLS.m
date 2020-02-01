clc;
close all;
clearvars;

w0 = 0.001;  
phi = 0.1;
[d,fs] = audioread("noisyvoice2.m4a");
noise = audioread("noise.m4a");
noise = noise(1: length(d),1);
N = length(d);
x = d + noise;
w = zeros(1, N);
mu = 0.001;
for i = 1: N
   e(i) = d(i) - w(i) * d(i);
   w(i+1) = w(i) + mu * e(i) * d(i);
end
for i = 1: N
yd(i) = sum(w(i) * d(i));  
end

subplot(221),plot(d(100000:105000)),ylabel('Desired Signal'),
subplot(222),plot(x(100000:105000)),ylabel('Input Signal+Noise'),
subplot(223),plot(e),ylabel('Error'),
subplot(224),plot(yd(100000:105000)),ylabel('Adaptive Desired output');

sound(x, fs);
pause(6);
sound(yd, fs);