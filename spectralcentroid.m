function y = spectralcentroid(x,fs)
% Spectral Centroid
 %code taken from University of London, school of computer science. (e.g www.eecs.qmul.ac.uk/legacy/easaier/files/technical/identification/MatlabCode.txt
%)

N1 = 1024;  % Points in FFT
N2 = N1/2;  % Half FFT length
fx = fft(x,N1); % FFT of x
f = abs(fx(1:N2)); % Find magnitude spectrum
magSq = f.^2;   % Magnitude squared

for i=1:N2
    num(i) = (i/N1*fs) * (magSq(i));  % multiply k by magnitude squared  
end

num = sum(num);     % Sum all k*magSq
den = sum(magSq);   % Sum magSq

y = num/den;