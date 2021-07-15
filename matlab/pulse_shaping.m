nsym = 8; % number of symbols
sps = 4; % samples per symbol

x1 = 2*rand(nsym,1) - 1; % random symbols
x2 = upsample(x1,sps); % upsample to sps

% time in units of symbols
t1 = (0:(length(x1)-1)).';
t2 = (0:(length(x2)-1)).'/sps;

% raised-root-cosine filter
rcc = rcosdesign(0.8,16,sps,'sqrt');
%x3 = filter(rcc,1,x2);
x3 = upfirdn(x1,rcc,sps);

% fourier transforms
P1 = abs(fft(x1,length(x1))).^2;
f1 = ((0:1/length(x1):1-1/length(x1))).';
P2 = abs(fft(x2,length(x2))).^2;
f2 = ((0:1/length(x2):1-1/length(x2))).';
P3 = abs(fft(x3,length(x3))).^2;


tl = tiledlayout(3,2,'TileSpacing','Compact','Padding','Compact');
xlabel(tl,'Samples')
ylabel(tl,'Signal')

nexttile
stem(t1,x1)
xlim([0,8])
ylim([-1.2,1.2])
title('Original (time)')

nexttile
plot(f1,P1)
title('Original (freq)')

nexttile
stem(t2,x2)
ylim([-1.2,1.2])
title('Upsampled (time)')

nexttile
plot(f2,P2)
title('Upsampled (freq)')

nexttile
stem(t2,x3)
ylim([-1.2,1.2])
title('Pulse-shaped (time)')

nexttile
plot(f2,P3)
title('Pulse-shaped (freq)')