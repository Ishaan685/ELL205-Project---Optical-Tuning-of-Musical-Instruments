clear all; %clearing the command window

filename= "5-A-finetuned.mp4";

[y, Fs] = audioread (filename); %reading the music signal
%Fs - here Fs is the sampling frequency

K=fft (y); %computing the double sided spectrum for the music signal

N=length (K); %length  of the spectrum

P1 = abs(K/N); %P1 is the amplitude of the double sided spectrum, dividing by n
%in order to average out the ampplitudes that awere added while computing the fft

%we are interested in the single sided spectrum not in double sided, since most frequency analysis componenets display only the positive half of the spectrum 
%of the signal so the negative side of the signal is redundant.

P = P1 (1:N/2+1); %taking half of the vector/spectrum of P1 and putting it in P since
% the same information is repeated in P1 twice due to the signal being symmetric around f = 0

P1 (2: end-1) = 2*P1 (2: end-1) ; %double the energy of the postive part 
% only of the frquency spectrum excluding the dc part

f = Fs * (0: (N/2) ) /N; %plotting only the single spectrum part of the signal

b = transpose(P);
if Fs == 44100
    [pks,locs] = findpeaks(b ,'SortStr' ,'descend','MinpeakDistance' , 100 ,'NPeaks',3 );
else
    [pks,locs] = findpeaks(b ,'SortStr' ,'descend','MinpeakDistance' , 50 ,'NPeaks',3 );
end
freq = (min(locs)*(Fs/2))/(N/2);

figure, plot (f,P); %fft
title (filename);
xlabel('frequency');
ylabel('Amplitude');
figure, plot (y); %the input signal
title (filename);