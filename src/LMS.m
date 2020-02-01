close all;
clearvars;
clc;

% [x,fs] = audioread('noisyvoice.m4a');
[x,fs] = audioread('noisyvoice2.m4a');
% [refer] = audioread('noise.m4a');
n = randn(length(x), 1);
% n = randn(100, 1);
n = n * std(x);
% refer = refer(1:length(x), 1);
refer = n;
primary = x(:, 1) + refer;
% primary = awgn(primary, 2);
% t = 1:0.025:5;
% desired = 5*sin(2*3.*t);
% 
% noise = 5*sin(2*50*3.*t);
% 
% refer = 5*sin(2*50*3.*t+ 3/20);
% 
% primary = desired+noise;

% subplot(4,1,1);
% plot(desired);
% ylabel('desired');

subplot(3,1,1);
plot(refer);
ylabel('refer'); 

subplot(3,1,2);
plot(primary( 100000:103500));
ylabel('Noisy Voice');

order = 2;
mu = 0.001;
n = length(primary);
delayed = zeros(1, order);
adap = zeros(1, order);
cancelled = zeros(1, n);

for k = 1: n
	
    delayed(1) = refer(k);
    y = delayed*adap';
    cancelled(k) = primary(k) - y;
    adap = adap + 2*mu*cancelled(k) .* delayed;
    delayed(2: order) = delayed(1: order - 1);
	
end

subplot(3,1,3);
plot(cancelled( 100000:103500));
ylabel('cancelled');

sound(x, fs);
pause(6);
sound(cancelled, fs);
