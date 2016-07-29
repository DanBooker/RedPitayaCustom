import matplotlib.pyplot as plt
import numpy as np

Fc = 1000;
Fa = 100;
fs = 10000;
fsi = 2.0/fs;
timeEnd =1
time = np.linspace(0,2,fs*timeEnd);

fig = plt.figure(figsize=(8,6)) #Set up Figure
fig1 = fig.add_subplot(321) # Row 1 column 1 = Carrier wave
fig2 = fig.add_subplot(323) # Row 2 Column 1 = Audio wave
fig3 = fig.add_subplot(325) # Row 3 Column 1 = FM wave
fig4 = fig.add_subplot(324) # Row 1 Column 2 = Audio Frequency Spectrum
fig5 = fig.add_subplot(322) # Row 2 Column 2 = Carrier Frequency Spectrum
fig6 = fig.add_subplot(326) # Row 3 Column 2 = FM Frequency Spectrum

carrier = np.sin(2*np.pi*Fc*time);  #Set up Carrier, Audio, and FM waves
audio = np.sin(2*np.pi*Fa*time);
audioInt = -np.cos(2*np.pi*Fa*time);
freqMod = np.sin(2*np.pi*Fc*time)*0.4*audio;

fftc = np.abs(np.fft.fft(carrier))   #Setup FFT for all waves
freqc = np.fft.fftfreq(fftc.size, fsi)

ffta = np.abs(np.fft.fft(audio))
freqa = np.fft.fftfreq(ffta.size, fsi)

fftm = np.abs(np.fft.fft(freqMod))
freqm = np.fft.fftfreq(fftm.size, fsi)

fig4.set_xlim([0,max(fftc)]) #Set axis labels
fig5.set_xlim([0,max(ffta)])
fig6.set_xlim([0,max(fftm)])

fig1.plot(time,audio)  #Plot the figures
fig2.plot(time,carrier)
fig3.plot(time,freqMod)
fig4.plot(freqc, fftc)
fig5.plot(freqa, ffta)
fig6.plot(freqm, fftm)
plt.show()
