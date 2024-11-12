%% ex4
% allinone = {files10.A,files10.wA;files10.E,files10.wE;files10.I,files10.wI;
%     files10.O,files10.wO;files10.OU,files10.wOU;};
close all
clear
clc
%% Task 1 (ready)
files10 = load('allinone.mat');%this has the 5+5 vowel signals
files10 = files10.allinone;
fs = 192000;
sounds = {'A';'E';'I';'O';'OU';};
packs = cell(5,1);
pitches = zeros(5,2);%for pitch estimation
p = zeros(fs,5,2);
h = cell(5,2);
Xest = p;
%pitches2 = zeros(5,2);
%% Task 2
for i = 1:5
    packs{i} = signalpack(files10(i,:));%cepstrums
    cvreal(packs{i},sounds{i},fs)%plots 
%     alternatively 
%     open([sounds{i},'.fig'])
    for j = 1:2
        pitches(i,j) = mypitch(packs{i}{2,j},fs);%finding pitch using the real cepstrum
        p(:,i,j) = voicing(packs{i}{3,j},pitches(i,j),2.8,fs);
        if j == 1
            h{i,j} = impulrep(packs{i}{1,j},pitches(i,j),fs,3);
        else
            h{i,j} = impulrep(packs{i}{1,j},pitches(i,j),fs,2);
        end
%         [~,~,D] = alignsignals(h{i,j},p(:,i,j));%uses xcorr 
        X = conv(circshift(p(:,i,j),0),h{i,j},'same');
        Xest(:,i,j) = 2.3*X(1:fs);
%         Uncomment this section to hear the signals (optional)
%         playX = audioplayer(packs{i}{1,j},fs);
%         play(playX)
%         pause(1)
%         playXest = audioplayer(Xest(:,i,j),fs);
%         play(playXest)
%         pause(1)
    end
    name = ['Task 3: sound ',sounds{i}];
    figure('Name',name,'NumberTitle','off')
    decvreal(packs{i}{1,1},p(:,i,1),sounds{i},'male',fs,[1,3])
    decvreal(packs{i}{1,2},p(:,i,2),sounds{i},'female',fs,[2,4])
    name = ['Task 4: sound ',sounds{i}];
    figure('Name',name,'NumberTitle','off')
    estvreal(packs{i}{1,1},Xest(:,i,1),packs{i}{1,2},Xest(:,i,2),...
        fs,sounds{i})
end
