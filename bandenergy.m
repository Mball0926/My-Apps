function y = bandenergy(x)
% Band Energy Ratio function
%   w = fs/2
%   Band 1: 0:w/8
%   Band 2: w/8:w/4
%   Band 3: w/4:w/2
%   Band 4: w/2:w
%   code taken from University of London, school of computer science. (e.g www.eecs.qmul.ac.uk/legacy/easaier/files/technical/identification/MatlabCode.txt
%)

N1 = 1024;  % Points in FFT
N2 = N1/2;  % Half FFT length
fx = fft(x,N1); % FFT of x
f = abs(fx(1:N2)); % Find magnitude spectrum

% Calculate ranges of bands
w = N2;             
b1 = (1: round(w/8));
b2 = (round(w/8)+1 : round(w/4));
b3 = (round(w/4)+1 : round(w/2));
b4 = (round(w/2)+1 : w);

% Energy in each band
total = sum(f);     % Total energy (all freqs)
y(1,1) = sum(f(b1))/total;  % Energy in band 1
y(2,1) = sum(f(b2))/total;  % 2
y(3,1) = sum(f(b3))/total;  % 3
y(4,1) = sum(f(b4))/total;  % 4
