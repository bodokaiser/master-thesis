n = 4096;

t = linspace(0, 1, n);
tx = exp(-2i*pi*t);
ph = cumsum(0.1*randn(1, n));
rx = tx .* exp(1i*ph);

[pxx, fx] = pwelch(tx, n, [], n, 1, 'centered');
[pyy, fy] = pwelch(rx, [], [], n, 1, 'centered');

fy = fy + 0.2;

figure
plot(fx, 10*log10(pxx))
hold on
plot(fy, 10*log10(pyy))
xlim([-0.3,0.6])
ylim([-30,40])
legend('Tx', 'Rx')
hold off

datadir = '../data';
writetable(cell2table(num2cell([fx, 10*log10(pxx / max(pxx))])), fullfile(datadir, 'laser-sync-tx.csv'));
writetable(cell2table(num2cell([fy, 10*log10(pyy / max(pyy))])), fullfile(datadir, 'laser-sync-rx.csv'));