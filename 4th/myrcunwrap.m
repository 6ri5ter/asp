function y = myrcunwrap(x)

n = max(size(x));
y = unwrap(x);
nh = fix((n+1)/2);
y(:) = y(:)' - pi*round(y(nh+1)/pi)*(0:(n-1))/nh;