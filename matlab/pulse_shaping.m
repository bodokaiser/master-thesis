% number of symbols
nsym = 128;
% samples per symbol (upsampling factor)
sps = 4;

% complex random symbols
x1 = 2*rand(nsym, 1) - 1;
p1 = 2*rand(length(x1), 1) - 1;
alpha1 = x1 + p1*1i;

% upsampling
alpha2 = upsample(alpha1, sps);

% symbol time
t1 = (0:(length(alpha1) - 1)).';
t2 = (0:(length(alpha2) - 1)).'/sps;

% rrc filtering
rrc = rcosdesign(0.8, 16, sps, 'sqrt');
alpha3 = conv(alpha2, rrc / rrc(8*uf+1), 'same');

% lowpass filtering
[b, a] = butter(7, 0.08);
alpha4 = filtfilt(b, a, upsample(alpha3, 10));
t4 = (0:(length(alpha4) - 1)).'/(sps*10);

figure
tl = tiledlayout(4, 1);
symlims = [10, 30];
xlabel(tl, 'Symbol number')
ylabel(tl, 'Signal')
nexttile
stem(t1, real(alpha1), '-o')
hold on
stem(t1, imag(alpha1), '-x')
xlim(symlims)
title('Symbols');
hold off
nexttile
stem(t2, real(alpha2), '-o')
hold on
stem(t2, imag(alpha2), '-x')
xlim(symlims)
title('Upsampling');
hold off
nexttile
stem(t2, real(alpha3), '-o')
hold on
stem(t2, imag(alpha3), '-x')
xlim(symlims)
title('Root-raised-cosine');
hold off
nexttile
plot(t4, real(alpha4))
hold on
plot(t4, imag(alpha4))
xlim(symlims)
title('Lowpass');
hold off

[pxx1,f1] = pwelch(alpha1, [], [], 'centered');
[pxx2,f2] = pwelch(alpha2, [], [], 'centered');
[pxx3,f3] = pwelch(alpha3, [], [], 'centered');
[pxx4,f4] = pwelch(alpha4, [], [], 'centered');

figure
plot(fftshift(f1), fftshift(pxx1) / sum(pxx1))
hold on
plot(fftshift(f2), fftshift(pxx2) / sum(pxx2))
plot(fftshift(f3), fftshift(pxx3) / sum(pxx3))
plot(fftshift(f4), fftshift(pxx4) / sum(pxx4))
legend('Symbols', 'Upsampling', 'Root-raised-cosine', 'Lowpass')
grid on
hold off