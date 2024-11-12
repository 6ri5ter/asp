function h_hat = impulrep(sig,pitch,fs,winlen)
period = pitch.^(-1);
i = round(fs/3);
A100 = sig(i:i+0.1*fs);
[~,j] = findpeaks(A100,'MinPeakDistance',period*0.9*fs);
Aw = A100(j(2):j(round(2+winlen)));
Aw = Aw.*hamming(length(Aw));
cAw = cceps(Aw);
wind = hann(round(0.85*winlen*period*fs));
windw = [wind(round((end+1)/2):end);zeros(length(cAw)-length(wind),1);...
    wind(1:floor(end/2))];
h_hat = cAw.*windw;
h_hat = icceps(h_hat);