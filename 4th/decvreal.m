function decvreal(X,p,letter,gender,fs,col)
subplot(2,2,col(1))
plot(0:1/fs:1-1/fs,X)
title(['Reocrded Signal ',letter,' ',gender])
xlabel('t(s)')
subplot(2,2,col(2))
plot(0:1/fs:1-1/fs,p)
title(['Deconvolved signal ',letter,' ',gender])
xlabel('t(s)')
