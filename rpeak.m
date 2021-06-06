[filename,pathname]=uigetfile('*.*','Select the ECG signal')
filewithpath=strcat(pathname,filename);
Fs=input('Enter Sampling Rate');
ecg=load(filename);
ecgsig=(ecg.val)./200;
t=1:length(ecgsig);
tx=t./Fs;
wt=modwt(ecgsig,4,'sym4');
wtrec=zeros(size(wt));
wtrec(3:4,:)=wt(3:4,:);
y=imodwt(wtrec,'sym4');
y=abs(y).^2;
avg=mean(y);
[Repeaks,locs]=findpeaks(y,t,'MinPeakHeight',8*avg,'MinPeakDistance',50);
nohb=length(locs);
timelimit=length(ecgsig)/Fs;
hbpermin=(nohb*60)/timelimit;
disp(strcat('Heart Rate=',num2str(hbpermin)))

subplot(211)
plot(tx,ecgsig);
xlim([0,timelimit]);
grid on;
xlabel('seconds');
title('ECG signal')

subplot(212)
plot(t,y)
grid on;
xlim([0,length(ecgsig)]);
hold on
plot(locs,Rpeaks,'ro')
xlabel('Samples')
title(strcat('r peaks found and heart rate: ',num2str(hbpermin)))