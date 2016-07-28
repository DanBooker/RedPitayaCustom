from rpfunctions import getdata, startRP, resetRP
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import butter, lfilter
Decimation = 1
tc = 8192/Decimation

startRP(Decimation)

plt.ion()                           #Start interactive mode
fig = plt.figure(figsize=(8,6))     #Set up subplot
ax = fig.add_subplot(411)           #subplot 1
ax2 = fig.add_subplot(412)          #subplot 2
ax3 = fig.add_subplot(413)          #subplot 3
ax4 = fig.add_subplot(414)

ch1 = np.asarray(getdata(1,2))      #get data from channel 1
ch2 = np.asarray(getdata(2,2))      #get data from channel 2
t = np.linspace(0,1.0/tc, 1*len(ch1))

orderl = 3
orderh = 3
cutoffl = 100
cutoffh = 1000
fs = 16384

def butter_lowpass(cutoff, fs, order=5):
    nyq = 0.5 * fs
    normal_cutoff = cutoff / nyq
    b, a = butter(order, normal_cutoff, btype='low', analog=False)
    return b, a
    
def butter_highpass(cutoff, fs, order=5):
    nyq = 0.5 * fs
    normal_cutoff = cutoff / nyq
    d, c = butter(order, normal_cutoff, btype='highpass', analog=False)
    return d, c

def butter_lowpass_filter(data, cutoff, fs, order=5):
    b, a = butter_lowpass(cutoff, fs, order=orderl)
    y = lfilter(b, a, data)
    return y
    
def butter_highpass_filter(data, cutoff, fs, order=5):
    d, c = butter_highpass(cutoffh, fs, order=orderh)
    y1 = lfilter(d, c, data)
    return y1

y1 = butter_highpass_filter(ch1, cutoffh, fs, orderh) #highpass modulation

sig = ch1*y1                       #multiply the two sine waves together

y = butter_lowpass_filter(sig, cutoffl, fs, orderl) #Filter Data

g, = ax.plot(t, sig)                #Set up updating plots
k, = ax4.plot(t, ch2)
h, = ax2.plot(t, y1)
j, = ax3.plot(t, y)

while 1:
    try:
        ch1 = np.asarray(getdata(1,2))      #get data from channel 1
        ch2 = np.asarray(getdata(2,2))      #get data from channel 2
        k.set_ydata(ch2)
        ax4.set_xlim(0.00004, 0.00008)
        y1 = butter_highpass_filter(ch1, cutoffh, fs, orderh) #highpass modulation
        sig = ch1*y1                       #multiply the two sine waves together
        g.set_ydata(sig)                    #update graph
        y = butter_lowpass_filter(sig, cutoffl, fs, orderl) #Filter Data
        ax.set_xlim(0.00004,0.00008)
        ax2.set_xlim(0.00004,0.00008)
        ax3.set_xlim(0.00004, 0.00008)
        ax3.set_ylim(-0.075, 0.075)
        j.set_ydata(y)
        h.set_ydata(y1)                      #update graphs of various filtration
        plt.draw()
        plt.pause(0.00000000001)
    except KeyboardInterrupt:
        resetRP()                           #Reset Acquistion
        break
        








