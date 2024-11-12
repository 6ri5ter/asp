%% pitch by cepstrum
function l =  mypitch(cS,fs)
[~,l] = findpeaks(cS,fs,'MinPeakHeight',0.01,'MinPeakDistance',0.002);
l = l(l>0.0025); % < 400Hz
l = 1/l(1);