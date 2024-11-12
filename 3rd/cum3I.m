function c3i = cum3I(X,M,L)

%% Step 1 (Segmenting the data)
X = reshape(X,M,[]);
%% Step 2 (Substracting each segments mean)
X = X - mean(X);
%% Step 3 (only primary area)
mom3 = zeros(L+1,size(X,2),L+1);
normila = 1;%(1/M)*sum(X.^3);
for m = 0:L
    first2 = X(1:M-m,:).*X(m+1:M,:);
    denomi = (M)*normila;
    for n = 0:m
        mom3(n+1,:,m+1) = diag(first2.'*X(1+n:M-m+n,:));
    end
    mom3(:,:,m+1) = mom3(:,:,m+1)./denomi;
end
%% Step 4
c3 = mean(mom3,2);
c3 = reshape(c3,L+1,L+1);
% Using symmetries
c3 = c3 + triu(c3,1).';
c31 = c3(2:L+1,2:L+1); 
c32 = zeros(L,L);  c33 = c32;  c34 = c32; 
for i=1:L
    temp = c31(i:L,i); 
    c32(L+1-i,1:L+1-i) = temp'; 
    c34(1:L+1-i,L+1-i) = temp; 
    if (i < L) 
        temp = flipud(temp(2:length(temp))); 
        c33 = c33 + diag(temp,i) + diag(temp,-i); 
    end 
end 
c33  = c33 + diag(c3(1,L+1:-1:2)); 
c3i = [ [c33, c32, zeros(L,1)]; [ [c34; zeros(1,L)] , c3 ] ]; 