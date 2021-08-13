n = 4096;

t = linspace(0, 1, n);
tx = exp(-2i*pi*t);
ph = cumsum(0.1*randn(1, n));
rx = tx .* exp(1i*ph);

[pxx, fx] = pwelch(tx, n, [], n, 1, 'centered');
[pyy, fy] = pwelch(rx, [], [], n, 1, 'centered');

figure
plot(fx, 10*log10(pxx))
hold on
plot(fy + 0.2, 10*log10(pyy))
xlim([-0.3,0.6])
ylim([-30,40])
legend('Tx', 'Rx')
hold off