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
ax3 = fig.add_subplot(413)
ax4 = fig.add_subplot(414)

ch1 = np.asarray(getdata(1,2))      #get data from channel 1
ch2 = np.asarray(getdata(2,2))      #get data from channel 2
sig = ch1*ch2                       #multiply the two sine waves together
t = np.linspace(0,1.0/tc, 1*len(ch1))

#order = 25
#cutoff = 0.139329
order = 5
cutoff = 80
fs = 16384

def butter_lowpass(cutoff, fs, order=5):
    nyq = 0.5 * fs
    normal_cutoff = cutoff / nyq
    b, a = butter(order, normal_cutoff, btype='low', analog=False)
    return b, a

def butter_lowpass_filter(data, cutoff, fs, order=5):
    b, a = butter_lowpass(cutoff, fs, order=order)
    y = lfilter(b, a, data)
    return y

y = butter_lowpass_filter(sig, cutoff, fs, order) #Filter Data

g, = ax.plot(t, sig)                #Set up updating plots
h, = ax2.plot(t, y)
ch1i, = ax3.plot(t, ch1)
ch2i, = ax4.plot(t, ch2)
while 1:
    try:
        ch1 = np.asarray(getdata(1,2))      #get data from channel 1
        ch2 = np.asarray(getdata(2,2))      #get data from channel 2
        sig = ch1*ch2                       #multiply the two sine waves together
        g.set_ydata(sig)                    #update graph
        y = butter_lowpass_filter(sig, cutoff, fs, order) #Filter Data
        ax.set_xlim(0.00004,0.00008)
        ax2.set_xlim(0.00004,0.00008)
        ax3.set_xlim(0.00004, 0.00008)
        ax4.set_xlim(0.00004, 0.00008)
        ch1i.set_ydata(ch1)
        ch2i.set_ydata(ch2)
        h.set_ydata(y)                      #update graphs of various filtration
        plt.draw()
        plt.pause(0.00000000001)
    except KeyboardInterrupt:
        resetRP()                           #Reset Acquistion
        break
        








