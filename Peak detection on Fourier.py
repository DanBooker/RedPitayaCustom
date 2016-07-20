import matplotlib.pyplot as plt
import numpy as np
import peakutils
from peakutils.plot import plot as pk

Fc = 1000
Fa = 65
fs = 10000
fsi = 2.0/fs
timeEnd =1
time = np.linspace(0,2,fs*timeEnd)

carrier = np.sin(2*np.pi*Fc*time)  #Set up Carrier, Audio, and FM waves
audio = np.sin(2*np.pi*Fa*time)
audioInt = -np.cos(2*np.pi*Fa*time)
freqMod = np.sin(2*np.pi*Fc*time +2*np.pi*audioInt)

fftm = np.abs(np.fft.fft(freqMod))
freqm = np.fft.fftfreq(fftm.size, fsi)

positives = np.where(freqm>=0)
fftm = fftm[positives]
freqm = freqm[positives]

fig = plt.figure(figsize=(8,6))
fig1 = fig.add_subplot(111)
fig1.set_xlim([0,max(freqm)])
fig1.plot(freqm, fftm)

indexes = peakutils.indexes(fftm, thres=0.001, min_dist=30)
print(indexes)
print(freqm[indexes], fftm[indexes])
plt.figure(figsize=(10,6))
pk(freqm, fftm, indexes)
plt.title('First estimate')
plt.show()

Fc1 = freqm[indexes[(len(indexes))/2]]
Fa1 = ((Fc1 - freqm[indexes[(len(indexes)-1)/2]]) + (freqm[indexes[(1+len(indexes))/2]] - Fc))

print Fc1
print Fa1
