function NRMSE = gianrmse(X,v,h_hat,name)
%%
N = length(X);
X_hat = conv(v,h_hat);
X_hat = X_hat(1:N);
NRMSE = sqrt(sum((X_hat-X).^2)/N)/(max(X)-min(X));
if nargin > 3
    plot(X)
    hold on
    plot(X_hat)
    grid on
    hold off
    title(['X vs Xest for ',name])
    legend('X[k]','Xest[k]')    
end