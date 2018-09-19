function[Test_M]= class_Test(songname)
global Test_M;
%global TT;
Test_M=[];
T=[];
%[filename,pathname] = uigetfile({'*.wav';'*mp3'},'Select File');
[x,fs] = audioread(songname);
Test_M(1,:)= feature_extraction(x,fs);
Train_M=[];

ans = Test_M;


 
 