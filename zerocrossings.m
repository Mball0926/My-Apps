function y = zerocrossings(segment)
% Zero Crossing Rate

count = 0;

for i=2:length(segment)

    if segment(i-1) <= 0 && segment(i) > 0
        count = count+1;
    end

    if segment(i-1) >= 0 && segment(i) < 0
        count = count+1;
    end

end

y = count/length(segment);