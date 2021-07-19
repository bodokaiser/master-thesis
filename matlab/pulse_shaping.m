% number of symbols
nsym = 20*128;
% upsampling RRC
uf_rrc = 2;
% upsampling LP
uf_lp = 4;

% complex random symbols
x1 = 2*rand(nsym, 1) - 1;
p1 = 2*rand(length(x1), 1) - 1;
alpha1 = x1 + p1*1i;

% upsampling
alpha2 = upsample(alpha1, uf_rrc);

% symbol time
t1 = (0:(length(alpha1) - 1)).';
t2 = (0:(length(alpha2) - 1)).'/uf_rrc;

% rrc filtering
rrc = rcosdesign(0.8, 16, uf_rrc, 'sqrt');
alpha3 = conv(alpha2, rrc / rrc(8*uf_rrc+1), 'same');

% lowpass filtering
[b, a] = butter(7, 0.08);
alpha4 = filtfilt(b, a, upsample(alpha3, uf_lp));
t4 = (0:(length(alpha4) - 1)).'/(uf_rrc*uf_lp);

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

%[pxx1,f1] = pwelch(alpha1, [], [], [], 1, 'centered');
%[pxx2,f2] = pwelch(alpha2, [], [], [], uf_rrc, 'centered');
%[pxx3,f3] = pwelch(alpha3, [], [], [], uf_rrc, 'centered');
%[pxx4,f4] = pwelch(alpha4, [], [], [], uf_rrc * uf_lp, 'centered');

figure
pwelch(alpha4, [], [], [], 1, 'centered');
%plot(f4, 10*log10(pxx4./max(pxx4)))
hold on
pwelch(alpha3, [], [], [], 1/uf_lp, 'centered');
pwelch(alpha2, [], [], [], 1/uf_lp, 'centered');
pwelch(alpha1, [], [], [], 1/(uf_lp*uf_rrc), 'centered');
%plot(f3, 10*log10(pxx3./max(pxx3)))
%plot(f2, 10*log10(pxx2./max(pxx2)))
%plot(f1, 10*log10(pxx1./max(pxx1)))
%xlim([-1,1])
%plot(fftshift(f4), 10*log10(fftshift(pxx4) / sum(pxx4)))
%legend('Symbols', 'Upsampling', 'Root-raised-cosine')%, 'Lowpass')
grid on
hold off