function ans = KnnClassify(TT,Test_M,k)


k_nearest=inf(k,2);
%size of data set
sz = size(TT, 1);

for i = 1:sz
    %find maximum dist in current k-nearest neighbours
    curr_max_index = 1;
    curr_max_dist = k_nearest(1,2);
    disp(k_nearest);
 for j= 1:k
        if(k_nearest(j,2) > curr_max_dist)
            curr_max_index = j;
            curr_max_dist = k_nearest(j,2);
        end
    end
    %dist of input from ith song from training data
    curr_dist = Euclidian_distance(TT{i,1},Test_M);
    if(curr_dist < curr_max_dist)
        %replace song at curr_max with ith song
        k_nearest(curr_max_index,1) = i;
        k_nearest(curr_max_index,2) = curr_dist;
    end
   
end
emotion_count = zeros(1,4);
%get genre counts from k_nearest
for i = 1:k
    curr_index = k_nearest(i,1);
    curr_genre = TT{curr_index,2};
    if(strcmp(curr_genre,'Happy'))
        emotion_count(1,1) = emotion_count(1,1) + 1;
    elseif(strcmp(curr_genre,'Neutral'))
            emotion_count(1,2) = emotion_count(1,2) + 1;
    elseif(strcmp(curr_genre,'Sad'))
        emotion_count(1,3) = emotion_count(1,3) + 1;
        %curr_index
    else
        emotion_count(1,4) = emotion_count(1,4) + 1;
    end
end
max_count = max(emotion_count(1,:));
if(emotion_count(1,1) == max_count)
    ans = 'Happy'
    fid=fopen('C:\Users\matthew\Documents\MATLAB\Built emotion recognition\classification.txt','wt');
fprintf(fid,'Happy');
fclose(fid);
elseif(emotion_count(1,2) == max_count)
    ans = 'Neutral'
    fid=fopen('C:\Users\matthew\Documents\MATLAB\Built emotion recognition\classification.txt','wt');
fprintf(fid,'Neutral');
fclose(fid);

else
    ans = 'Sad'
    fid=fopen('C:\Users\matthew\Documents\MATLAB\Built emotion recognition\classification.txt','wt');
fprintf(fid,'Sad');
fclose(fid);
end
end


