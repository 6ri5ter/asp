clear
close all
clc
%%
N = 2048;
L = 20;
M = 64;
%% Preparations
b = [1;.93;.85;.72;.59;-.1];%q = 5 
v = load('signals_gian.mat');%exprnd(1,N,1); 
v = v.v;
X = conv(b,v);
X = X(1:N); %We don't need the last 5 values
%% Task 1
skv = sum((v-mean(v)).^3)/((N-1)*std(v)^3);
%% Task 2
c3 = cum3I(X,M,L);
figure('Name','Task 2','NumberTitle','off')
surf(-20:20,-20:20,c3)
xlabel('s')
ylabel('s')
title('Third order cumulant for L = 20')
%% Task 3
h_hat = gianest(c3,length(b) - 1);
%% Task 4
h_sub = gianest(c3,length(b) - 3);
h_sup = gianest(c3,length(b) + 2);
%% Task 5
figure('Name','Task 5','NumberTitle','off')
NRMSEq = gianrmse(X,v,h_hat,'known q (=5)');
%% Task 6
figure('Name','Task 6','NumberTitle','off')
tiledlayout(1,2)
nexttile
NRMSEsub = gianrmse(X,v,h_sub,'sub-estimetion (q=q-2)');
nexttile
NRMSEsup = gianrmse(X,v,h_sup,'sup-estimetion (q=q+3)');
%% Task 7
SNRs = 30:-5:-5;
iter = length(SNRs);
NRMSE = zeros(iter,1);
figure('Name','Task 7: Noisy signals estimations','NumberTitle','off')
tiledlayout(round(iter/2),2)
for i = 1:iter
    Y = awgn(X,SNRs(i),'measured');
    c3y = cum3I(Y,M,L);
    h_haty = gianest(c3y,length(b) - 1);
    nexttile
    name = [' SNR = ',num2str(SNRs(i)),' (q = 5)'];
    NRMSE(i) = gianrmse(Y,v,h_haty,name);
end
% Plotting the NRMSE
figure('Name','Task 7','NumberTitle','off')
plot(SNRs,NRMSE)
title('Giannakis'' formula vs AWGN')
xlabel('SNR')
ylabel('NRMSE')
%% Task 8
valida = 100;
v8 = exprnd(1,N,valida);
X8 = zeros(N+length(b)-1,valida);
for i = 1:valida
    X8(:,i) = conv(b,v8(:,i));
end
X8 = X8(1:N,:); %We don't need the last 5 values
skv8 = mean(sum((v8-mean(v8)).^3)/((N-1)*std(v8).^3));
NRMSE8 = zeros(valida,3);
NRMSEY = zeros(valida,8);
for i = 1:valida
    c38 = cum3I(X8(:,i),M,L);
    h_hat8 = gianest(c38,length(b) - 1);
    h_hat8sub = gianest(c38,length(b) - 3);
    h_hat8sup = gianest(c38,length(b) + 2);
    NRMSE8(i,1) = gianrmse(X8(:,i),v8(:,i),h_hat8);
    NRMSE8(i,2) = gianrmse(X8(:,i),v8(:,i),h_hat8sub);
    NRMSE8(i,3) = gianrmse(X8(:,i),v8(:,i),h_hat8sup);
    for j = 1:iter
        Y8 = awgn(X8(:,i),SNRs(j),'measured');
        c3y8 = cum3I(Y8,M,L);
        h_haty8 = gianest(c3y8,length(b) - 1);
        NRMSEY(i,j) = gianrmse(Y8,v8(:,i),h_haty8);
    end
end
NRMSE8 = mean(NRMSE8);
NRMSEY = mean(NRMSEY);
%plot
figure('Name','Task 8','NumberTitle','off')
plot(SNRs,NRMSEY)
title('Giannakis'' formula vs AWGN (100 realizations)')
xlabel('SNR')
ylabel('meanNRMSE')

















