import numpy as np
import matplotlib.pyplot as plt
from rpfunctions import getdata, startRP, resetRP

#-----------------------------------------------------------------------------

'''Create figure'''
plt.ion()
fig = plt.figure(figsize=(8,6))
ax = fig.add_subplot(311)
ax2 = fig.add_subplot(312)
ax3 = fig.add_subplot(313)
ax.set_ylabel('Voltage(V)')
ax.set_xlabel('Time(ms)')

#-----------------------------------------------------------------------------

startRP(1)

#-----------------------------------------------------------------------------

ch1 = np.asarray(getdata(1,2)) #get data from red pitaya
ch2 = np.asarray(getdata(2,2))
signal = ch1*ch2
#time = np.linspace(0, timescale, len(buff))
fft=np.fft.fft(signal)
fft2=np.copy(fft)
for i in range (500,len(fft2)):
    fft2[i]=0

ifft=np.fft.ifft(fft2)
l, = ax.plot(signal) #plot data
g, = ax2.plot(fft)
h, = ax3.plot(ifft)
#ax2.set_xlim([0, 340])
#ax2.set_ylim([-8000,8000])
plt.show()



while 1:
    try:
        ch1 = np.asarray(getdata(1,2)) #get data from red pitaya
        ch2 = np.asarray(getdata(2,2))
        signal = ch1*ch2
        l.set_ydata(signal) #updata graph
        fft=np.fft.fft(signal)
        fft2=np.copy(fft)
        for i in range (500,len(fft2)):
            fft2[i]=0
        ifft=np.fft.ifft(fft2)        
        g.set_ydata(fft) #updates fft
        h.set_ydata(ifft)
        ax.set_ylim([1.2*np.min(signal), 1.2*np.max(signal)])
        ax3.set_ylim([1.2*np.min(ifft), 1.2*np.max(ifft)])
        ax2.set_ylim([np.min(fft), np.max(fft)])
        plt.draw()
        plt.pause(0.0000000001)
    except KeyboardInterrupt:
        resetRP()   #reset acqusition
        break