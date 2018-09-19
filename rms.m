function y = rms(x)
% RMS of window (time domain)

N = length(x); % Window length
summed = sum(x.^2);  % Square all values in window and sum
y = sqrt(summed/N);  % Divide by number of samples in window & square root
