function[TT]= train
global TT
TT=cell(1,2);
path=fullfile('C:\Users\matthew\Documents\MATLAB\Built emotion recognition\trainwav')
files = dir(path);
for fileIndex=1:length(files)
    i=fileIndex;
if (files(fileIndex).isdir == 0)
        if (~isempty(strfind(files(fileIndex).name,'wav')))
            fullfile(path,files(fileIndex).name)
            [x,fs] = audioread(fullfile(path,files(fileIndex).name));
            tok=files(fileIndex).name;
            token = strtok(tok);
            

Train_M(1,:)=feature_extraction(x,fs);

ee=cell(1,2);
ee{1,1}=Train_M;
ee{1,2}=token;
TT=[TT;ee];

        end 
end
end
TT=TT(~cellfun(@isempty, TT(:,1)), :);
ans=TT;
