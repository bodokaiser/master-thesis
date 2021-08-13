sps = 32;

rrc_b = rcosdesign(0.25, 16, sps, 'sqrt');

x = [zeros(10,1); 1; zeros(10,1)];
y = upfirdn(x, rrc_b, sps);

n = 0:length(y) - 1;

y_tx = y(32:8:end);
y_rx = y(6:8:end-26);
n_tx = sps*(0:length(y_tx) - 1);
n_rx = sps*(0:length(y_rx) - 1);

tiledlayout(5, 1)
nexttile
plot(n_tx, y_tx)
hold on
stem(n_tx, y_tx)
xlim([1000, 3500])
title('Transmitter DAC')
hold off

nexttile
plot(n_rx, y_rx)
hold on
stem(n_rx, y_rx)
xlim([1000, 3500])
title('Receiver ADC')
hold off

X = fftshift(fft(y));
f = (-length(X)/2:length(X)/2-1) / length(X);

X_tx = fftshift(fft(y_tx));
f_tx = (-length(X_tx)/2:length(X_tx)/2-1) / (length(X));

X_rx = fftshift(fft(y_rx));
f_rx = (-length(X_rx)/2:length(X_rx)/2-1) / length(X);

nexttile
plot(f, log10(abs(X).^2 / length(X)))
hold on
plot(f_tx, log10(sqrt(sps) * abs(X_tx).^2  / length(X_tx)))
plot(f_rx, log10(sqrt(sps) * abs(X_rx).^2 / length(X_rx)))
title('Power')
xlim([-0.1, 0.1])
legend('Original', 'Downsampled (Tx)', 'Downsampled (Rx)')
hold off

phi = unwrap(angle(X));
phi_tx = unwrap(angle(X_tx));
phi_rx = unwrap(angle(X_rx));

nexttile
plot(f, phi)
hold on
plot(f_tx, phi_tx)
plot(f_rx, phi_rx)
xlim([-0.1, 0.1])
title('Phase')
legend('Original', 'Downsampled (Tx)', 'Downsampled (Rx)')
hold off

nexttile
plot(f_rx, phi_rx - phi_tx)
title('Phase difference between Rx and Tx')