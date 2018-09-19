function [vector,frames] = feature_extraction(x,fs)
% Extract audio features and return a feature vector
% x = sample data
% fs = sample frequency

%   zc  - Zero Crossings
%   rm  - RMS (Root Mean Squared)
%   sr  - Spectral Rolloff
%   sc  - Spectral Centroid
%   bw  - Bandwidth
%   ber - Band Energy Ratio
%   MFCC- Mel-Frequency Cepstral Coefficients

windowLen = 1024;    % Window length in samples
start = 1;          % Window start index 
halfwin = windowLen / 2;    % Half window for calculating overlaps
win = hamming(windowLen);   % Generate window

frames = floor(length(x)/halfwin)-1;    % Calc number of frames in x

threshold = 0.1*rms(x);     % Define silence threshold

% Declare output arrays
zc = []; rm = []; sr = [];
sc = []; bw = []; ber = [];
mfcc = []; 



% --- Loop through frames ---
for i = 1:frames
    
    signal = x(start:start+windowLen-1);  % Samples in current frame
    t = signal .* win;      % Apply window function
    
    rm1 = rms(t);   % RMS of frame
    if rm1 > threshold  % if RMS below threshold do not extract anything
        
        % Extract features
        zc1 = zerocrossings(t);   
        sr1 = specrolloff(t,fs);
        sc1 = spectralcentroid(t,fs);
        bw1 = bandwidth_extraction(t,fs,sc1);
        
                
        % Append to output arrays
        zc = [zc zc1];
        sr = [sr sr1];
        sc = [sc sc1];
        bw = [bw bw1];
       
        rm = [rm rm1];
        
    end
        start = start + halfwin;  % Move to start of next window
end




% Create feature vector
% means
zcM = mean(zc);
rmM = mean(rm);
srM = mean(sr);
scM = mean(sc);
bwM = mean(bw);
mfcc = mfcc_extraction(x);
mfccVec = [];

  for i=1:size(mfcc,1)              % All MFCC coeffs except 1st (always = 1)
    mfcc(i) = mean(mfcc(i,:));      % Calc mean
     mfccVec = [mfccVec mfcc(i)];      % Append to MFCC mean value vector
 end
y=(mfccVec);
vector = [zcM rmM srM scM bwM y];
disp(vector)