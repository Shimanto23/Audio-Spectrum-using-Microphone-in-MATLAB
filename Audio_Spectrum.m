% Audio Spectrum 

% Different Parameters
audio_rates = 48000/4;
time  = 0:1/audio_rates:1-1/audio_rates;
n     = length(time);
hz    = linspace(0,audio_rates,n);

% Plotting the Graph
clf, figure(1)

% Frequency
subplot(211)
frequencym = plot(hz,zeros(n,1),'linew',2);
set(gca,'xlim',[0,2000],'ylim',[0,8]*1e-6)
xlabel('Frequency (Hz)'), ylabel('Power')
title('Frequency Domain')

% Time
subplot(212)
timem = plot(time, zeros(n,1));
set(gca,'ylim',[-1,1]/7)
xlabel('Time (S)'), ylabel('Amplitude')
title('Time Domain')

% Creating Recorder
audio_r = audiorecorder(audio_rates,8,1);
record(audio_r);
pause(1.1);

while 1
    
    data = getaudiodata(audio_r);
    data = data(end-audio_rates+1:end);
    
    % using plots
    set(frequencym,'yData',abs(fft(data)/n).^2);
    set(timem,'yData',data);
    
    pause(0.1)
end

% End