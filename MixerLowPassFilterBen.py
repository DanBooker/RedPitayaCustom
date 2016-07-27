from rpfunctions import getdata, startRP, resetRP
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
Decimation = 1
tc = 8192/Decimation

startRP(Decimation)

plt.ion()                           #Start interactive mode
fig = plt.figure(figsize=(8,6))     #Set up subplot
ax = fig.add_subplot(411)           #subplot 1
ax2 = fig.add_subplot(412)          #subplot 2
ax3 = fig.add_subplot(413)          #subplot 3
ax4 = fig.add_subplot(414)          #subplot 4

ch1 = np.asarray(getdata(1,2))      #get data from channel 1
ch2 = np.asarray(getdata(2,2))      #get data from channel 2
sig = ch1*ch2                       #multiply the two sine waves together
t = np.linspace(0,1.0/tc, 1*len(ch1))

b, a = signal.butter(3, 0.5)               #Set up low pass
zi = signal.lfilter_zi(b,a)
z, _ = signal.lfilter(b,a,sig, zi=zi*sig[0])
z2, _ = signal.lfilter(b,a, z, zi=zi*z[0])
z3, _ = signal.lfilter(b,a,z2, zi=zi*z2[0])

g, = ax.plot(t, sig)                #Set up updating plots
h, = ax2.plot(t, z)
j, = ax3.plot(t,z2)
k, = ax4.plot(t,z3)
#y=[]

while 1:
    try:
        ch1 = np.asarray(getdata(1,2))      #get data from channel 1
        ch2 = np.asarray(getdata(2,2))      #get data from channel 2
        sig = ch1*ch2                       #multiply the two sine waves together
        g.set_ydata(sig)                    #update graph
        ax.set_xlim(0,0.00001)
        ax2.set_xlim(0,0.00001)
        ax3.set_xlim(0,0.00004)
        ax4.set_xlim(0,0.00001)
        b, a = signal.butter(3, 0.5)
        zi = signal.lfilter_zi(b,a)         #Re-filter the signal
        z, _ = signal.lfilter(b,a,sig, zi=zi*sig[0])
        z2, _ = signal.lfilter(b,a, z, zi=zi*z[0])
        z3, _ = signal.lfilter(b,a,z2, zi=zi*z2[0])
        h.set_ydata(z)                      #update graphs of various filtration
        j.set_ydata(z2)
        k.set_ydata(z3)
        #y.append(np.max(z3))
        plt.draw()
        plt.pause(0.00000000001)
    except KeyboardInterrupt:
        resetRP()                           #Reset Acquistion
        break
        







