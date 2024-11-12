function h_hat = gianest(c3, q)
%%
L = (size(c3,1) - 1)/2;
h_hat = c3(L+q+1,L+1:L+q+1)/c3(L+q+1,L+1);