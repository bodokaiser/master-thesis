% total number of symbols
num_sym = 1024;

% upsampling factor for pulse-shaping filter
uf_ps = 2;
% upsampling factor for low-pass filter
uf_lp = 4;

% unit response
unit_sym = unitsym(num_sym, 16);
[unit_ps_up, unit_ps_out] = pulse_shape_filter(unit_sym, uf_ps);
[unit_lp_up, unit_lp_out] = low_pass_filter(unit_ps_out, uf_lp);
[unit_lp_up2, unit_lp_out2] = low_pass_filter(unit_sym, uf_lp);
%plot_time(num_sym, [10, 20], unit_sym, unit_ps_up, unit_ps_out, unit_lp_out)
%plot_freq(length(lp_out), [-0.4, +0.4],  unit_sym, unit_ps_up, unit_ps_out, unit_lp_up, unit_lp_out, unit_lp_out2)
write_time(num_sym, unit_sym, '../data/pulse-shaping/unit-symbols.csv');
write_time(num_sym, unit_ps_up, '../data/pulse-shaping/unit-pulse-shape-up.csv');
write_time(num_sym, unit_ps_out, '../data/pulse-shaping/unit-pulse-shape-out.csv');
write_time(num_sym, unit_lp_out / max(unit_lp_out), '../data/pulse-shaping/unit-low-pass-out.csv');

% random symbols
rnd_sym = randsym(num_sym);
[rnd_ps_up, rnd_ps_out] = pulse_shape_filter(rnd_sym, uf_ps);
[rnd_lp_up, rnd_lp_out] = low_pass_filter(rnd_ps_out, uf_lp);
%plot_time(num_sym, [10, 20], rnd_sym, rnd_ps_up, rnd_ps_out, rnd_lp_out)
%plot_freq(length(lp_out), [-0.4, +0.4],  rnd_sym, rnd_ps_up, rnd_ps_out, rnd_lp_up, rnd_lp_out)


function x = unitsym(n, i)
    x = zeros(n, 2) * [1; 1i];
    x(i) = 1;
end

function x = randsym(n)
    x = randn(n, 2) * [1; 1i] / sqrt(2);
end

function [up, out] = pulse_shape_filter(x, uf)
    b = rcosdesign(0.25, 16, uf, 'sqrt');
    b = b / b(8*uf + 1);
    up = upsample(x, uf);
    out = conv(up, b, 'same');
end

function [up, out] = low_pass_filter(x, uf)
    [b, a] = butter(7, 0.2);
    up = upsample(x, uf);
    out = filtfilt(b, a, up);
end

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