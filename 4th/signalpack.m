%%
function spack = signalpack(s)
spack = cell(3,2);
for i = 1:length(s)
    spack{1,i} = s{i};
    %% Calculating the real and the complex cepstrum using the hosa functions
    spack{2,i} = rceps(s{i});%ifft(log(abs(fft(s))))
    spack{3,i} = cceps(s{i});
end