%% plot function exe4
function cvreal(signals,letter,fs) %signalM,rcepstrumM,ccepstrumM,signalW,rcepstrumW,ccepstrumW
datacheck = zeros(6,1);
names = {'Signal Male','Signal Female';'Cepstrum Male (Real)',...
    'Cepstrum Female (Real)';'Cepstrum Male (cmplx)',...
    'Cepstrum Female (cmplx)';};
    
for i = 1:3
    for j = 1:2
        datacheck(i*j) =  max(size(signals{i,j}));
    end
end
if max(datacheck - max(datacheck))
    error('Error: Data vectors must have the same length.')
end
figure('Name',letter,'NumberTitle','off')
%Plots
tiledlayout(3,2)
for i = 1:3
    for j = 1:2
        if i == 1
            rplots(signals{i,j},fs,datacheck(1)/fs,names{i,j},letter,...
                't(s)')
        else
            rplots(signals{i,j},fs,datacheck(1)/fs,names{i,j},letter,...
                'Quefrency(s)') 
        end
    end
end
function rplots(s,fs,edge,name,letter,xax)
    name = [name,' ', letter];
    xvec = 0:1/fs:edge-1/fs;
    nexttile
    plot(xvec,s)
    title(name)
    xlabel(xax)
end
end