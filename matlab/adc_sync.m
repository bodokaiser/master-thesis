N = 128;
beta = 0.25;
H_RC = [zeros(1,N/2), ones(1,N), zeros(1,N/2)];
H_inner_range = round(N/2*(1-beta)):round(N/2*(1+beta));
H_RC(H_inner_range) = 0.5*(1-cos(linspace(0, pi, numel(H_inner_range))));
H_RC(H_inner_range+N) = 0.5*(1-cos(linspace(pi, 0, numel(H_inner_range))));
H_RRC = sqrt(H_RC);
h_rrc = real(ifft(fftshift(H_RRC)));
y = h_rrc/max(h_rrc);

y_tx = y(1:end);
y_rx = [y(2:end), y(1)];
n_tx = (0:length(y_tx) - 1);
n_rx = (0:length(y_rx) - 1);

close all;

figure
plot(n_tx, [y_tx(129:end), y_tx(1:128)])
hold on
stem(n_tx, [y_tx(129:end), y_tx(1:128)])
title('Transmitter DAC')
hold off

figure
plot(n_rx, [y_rx(129:end), y_rx(1:128)])
hold on
stem(n_rx, [y_rx(129:end), y_rx(1:128)])
title('Receiver ADC')
hold off

X = fftshift(fft(y));
f = (-length(X)/2:length(X)/2-1) / length(X);

X_tx = fftshift(fft(y_tx));
f_tx = (-length(X_tx)/2:length(X_tx)/2-1) / (length(X));

X_rx = fftshift(fft(y_rx));
f_rx = (-length(X_rx)/2:length(X_rx)/2-1) / length(X);

figure
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

figure
plot(f_tx, phi_tx)
hold on
plot(f_rx, phi_rx)
xlim([-0.1, 0.1])
title('Phase')
legend('Downsampled (Tx)', 'Downsampled (Rx)')
hold off

figure
plot(f_rx, phi_rx - phi_tx)
title('Phase difference between Rx and Tx')

datadir = '.';
writetable(cell2table(num2cell([n_tx; [y_tx(129:end), y_tx(1:128)]].')), fullfile(datadir, 'adc-sync-time-tx.csv'));
writetable(cell2table(num2cell([n_rx; [y_rx(129:end), y_rx(1:128)]].')), fullfile(datadir, 'adc-sync-time-rx.csv'));
writetable(cell2table(num2cell([f_tx; phi_tx].')), fullfile(datadir, 'adc-sync-phase-tx.csv'));
writetable(cell2table(num2cell([f_rx; phi_rx].')), fullfile(datadir, 'adc-sync-phase-rx.csv'));