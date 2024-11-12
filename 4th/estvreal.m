function estvreal(X,Xest,Xf,Xestf,fs,letter)
tiledlayout(2,2)
nexttile
plot(0:1/fs:1-1/fs,X)
title(['Recorded signal sound',letter,' male'])
xlabel('t(s)')
nexttile
plot(0:1/fs:1-1/fs,Xf)
title(['Recorded signal sound',letter,' female'])
nexttile
plot(0:1/fs:1-1/fs,Xest)
title(['Estimated signal sound',letter,' male'])
nexttile
plot(0:1/fs:1-1/fs,Xestf)
title(['Estimated signal sound',letter,' female'])