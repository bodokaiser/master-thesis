% total number of symbols
num_sym = 1024;

% upsampling factor for pulse-shaping filter
uf_ps = 2;
% upsampling factor for low-pass filter
uf_lp = 4;

% RRC filter
rrc_b = rcosdesign(0.25, 16, uf_ps, 'sqrt');
% LP filter
[lp_b, lp_a] = butter(7, 0.2);

% unit symbol
unit_tx_sym = zeros(num_sym, 1);
unit_tx_sym(16) = 1;
unit_tx_up = upsample(unit_tx_sym, uf_ps);
unit_tx_rrc = conv(unit_tx_up, rrc_b, 'same');
unit_tx_dac = upsample(unit_tx_rrc, uf_lp);
unit_tx_lp = filtfilt(lp_b, lp_a, unit_tx_dac);

% random QPSK symbols
%rand_tx_sym = (2*rand(num_sym, 2) - 1) * [1; 1i];
rand_tx_sym = 2*((rand(num_sym, 2) > 0.5) - 0.5) * [1; 1i];
rand_tx_up = upsample(rand_tx_sym, uf_ps);
rand_tx_rrc = conv(rand_tx_up, rrc_b, 'same');
rand_tx_dac = upsample(rand_tx_rrc, uf_lp);
rand_tx_lp = filtfilt(lp_b, lp_a, rand_tx_dac);
rand_rx_det = rand_tx_lp .* exp(2*pi*1i*0.8 * (0:(length(rand_tx_lp) - 1)).' / (length(rand_tx_lp) / num_sym));
rand_rx_dwnc = rand_tx_lp;
rand_rx_adc = downsample(rand_rx_dwnc, uf_lp);
rand_rx_rrc = conv(rand_rx_adc, rrc_b, 'same');
rand_rx_dwn = downsample(rand_rx_rrc, uf_ps);

% visualize
%plot_time(num_sym, [10, 20], unit_tx_sym, unit_tx_up, unit_tx_rrc, unit_tx_lp)
%plot_freq(length(unit_tx_lp), [-0.4, +0.4],  unit_tx_sym, unit_tx_up, unit_tx_rrc, unit_tx_dac, unit_tx_lp)
%plot_time(num_sym, [10, 20], rand_tx_sym, rand_tx_up, rand_tx_rrc, rand_tx_lp, rand_rx_det, rand_rx_adc, rand_rx_rrc, rand_rx_dwn)
%plot_freq(length(rand_tx_lp), [-0.4, +0.4],  rand_tx_sym, rand_tx_up, rand_tx_rrc, rand_tx_dac, rand_tx_lp, rand_rx_det, rand_rx_dwnc, rand_rx_adc, rand_rx_rrc, rand_rx_dwn)

datadir = '../data/signal-processing';

% export csv
write_time(num_sym, unit_tx_sym, fullfile(datadir, 'unit-time-tx-sym.csv'));
write_time(num_sym, unit_tx_up, fullfile(datadir, 'unit-time-tx-up.csv'));
write_time(num_sym, unit_tx_rrc, fullfile(datadir, 'unit-time-tx-rrc.csv'));
write_time(num_sym, unit_tx_lp, fullfile(datadir, 'unit-time-tx-lp.csv'));
write_freq(num_sym, unit_tx_sym, fullfile(datadir, 'unit-freq-tx-sym.csv'));
write_freq(num_sym, unit_tx_up, fullfile(datadir, 'unit-freq-tx-up.csv'));
write_freq(num_sym, unit_tx_rrc, fullfile(datadir, 'unit-freq-tx-rrc.csv'));
write_freq(num_sym, unit_tx_dac, fullfile(datadir, 'unit-freq-tx-dac.csv'));
write_freq(num_sym, unit_tx_lp, fullfile(datadir, 'unit-freq-tx-lp.csv'));
write_time(num_sym, real(rand_tx_sym), fullfile(datadir, 'rand-time-tx-sym-real.csv'));
write_time(num_sym, imag(rand_tx_sym), fullfile(datadir, 'rand-time-tx-sym-imag.csv'));
write_time(num_sym, real(rand_tx_up), fullfile(datadir, 'rand-time-tx-up-real.csv'));
write_time(num_sym, imag(rand_tx_up), fullfile(datadir, 'rand-time-tx-up-imag.csv'));
write_time(num_sym, real(rand_tx_rrc), fullfile(datadir, 'rand-time-tx-rrc-real.csv'));
write_time(num_sym, imag(rand_tx_rrc), fullfile(datadir, 'rand-time-tx-rrc-imag.csv'));
write_time(num_sym, real(rand_tx_dac), fullfile(datadir, 'rand-time-tx-dac-real.csv'));
write_time(num_sym, imag(rand_tx_dac), fullfile(datadir, 'rand-time-tx-dac-imag.csv'));
write_time(num_sym, real(rand_tx_lp), fullfile(datadir, 'rand-time-tx-lp-real.csv'));
write_time(num_sym, imag(rand_tx_lp), fullfile(datadir, 'rand-time-tx-lp-imag.csv'));
write_time(num_sym, real(rand_rx_det), fullfile(datadir, 'rand-time-rx-det-real.csv'));
write_time(num_sym, imag(rand_rx_det), fullfile(datadir, 'rand-time-rx-det-imag.csv'));
write_time(num_sym, real(rand_rx_adc), fullfile(datadir, 'rand-time-rx-adc-real.csv'));
write_time(num_sym, imag(rand_rx_adc), fullfile(datadir, 'rand-time-rx-adc-imag.csv'));
write_time(num_sym, real(rand_rx_rrc), fullfile(datadir, 'rand-time-rx-rrc-real.csv'));
write_time(num_sym, imag(rand_rx_rrc), fullfile(datadir, 'rand-time-rx-rrc-imag.csv'));
write_time(num_sym, real(rand_rx_dwn), fullfile(datadir, 'rand-time-rx-dwn-real.csv'));
write_time(num_sym, imag(rand_rx_dwn), fullfile(datadir, 'rand-time-rx-dwn-imag.csv'));
write_freq(num_sym, rand_tx_sym, fullfile(datadir, 'rand-freq-tx-sym.csv'));
write_freq(num_sym, rand_tx_up, fullfile(datadir, 'rand-freq-tx-up.csv'));
write_freq(num_sym, rand_tx_rrc, fullfile(datadir, 'rand-freq-tx-rrc.csv'));
write_freq(num_sym, rand_tx_dac, fullfile(datadir, 'rand-freq-tx-dac.csv'));
write_freq(num_sym, rand_tx_lp, fullfile(datadir, 'rand-freq-tx-lp.csv'));
write_freq(num_sym, rand_rx_det, fullfile(datadir, 'rand-freq-rx-det.csv'));
write_freq(num_sym, rand_rx_rrc, fullfile(datadir, 'rand-freq-rx-rrc.csv'));
write_freq(num_sym, rand_rx_dwn, fullfile(datadir, 'rand-freq-rx-dwn.csv'));


function [] = plot_time(n, nlim, varargin)
    figure
    tl = tiledlayout(length(varargin), 1);
    
    for i = 1:length(varargin)
        s = varargin{i};
        t = (0:(length(s) - 1)).' / (length(s) / n);
        
        nexttile
        stem(t, real(s), '-o')
        hold on
        stem(t, imag(s), '-x')
        xlim(nlim)
        hold off
    end
   
    xlabel(tl, 'Symbol')
    ylabel(tl, 'Signal')
end

function [] = plot_freq(n, flim, varargin)
    figure
    tl = tiledlayout(length(varargin), 1);
    
    for i = 1:length(varargin)
        s = varargin{i};
        [pxx, f] = pwelch(s, [], [], [], length(s) / n, 'centered');
        
        nexttile
        plot(f, 10*log10(pxx))
        xlim(flim)
    end
    
    xlabel(tl, 'Frequency')
    ylabel(tl, 'Power spectral density')
end

function [] = write_time(n, x, filename)
    t = (0:(length(x) - 1)).' / (length(x) / n);
    c = num2cell([t, x]);
    m = cell2table(c);
    writetable(m, filename);
end

function [] = write_freq(n, x, filename)
    [pxx, f] = pwelch(x, [], [], [], length(x) / n, 'centered');
    c = num2cell([f, 10*log10(pxx / max(pxx))]);
    m = cell2table(c);
    writetable(m, filename);
end