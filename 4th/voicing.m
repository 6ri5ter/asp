function pt = voicing(csig,pitch,winlen,fs)
period = pitch.^(-1);
win = hann(round(winlen*period*fs)+1);
w = [win(round((end+1)/2):end);zeros(fs-length(win),1); win(1:floor(end/2))];
env = csig.*w;
% h = ifft(exp(fft(env)));
% h = h(1:fs/2+1);
p = csig - env;
% pt = icceps(p);
pt = ifft(exp(fft(p))); % The voice element (the impulse)
% hpass = [zeros((length(win)+1)/2,1);win(1:(end-1)/2);...
%     ones(fs - 2*length(win),1);win((end+1)/2:end);...
%     zeros((length(win)-1)/2,1)];
% ptc = csig.*hpass;
% ptc = ifft(exp(fft(ptc)));

