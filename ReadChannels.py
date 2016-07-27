import numpy as np
import matplotlib.pyplot as plt
from rpfunctions import startRP, resetRP, gencont, gensweep, getdata

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

startRP(1024, 10)
gencont(1,1000)
gencont(2,100)

#-----------------------------------------------------------------------------
ch1 = np.asarray(getdata(1,1)) #get data from red pitaya
#ch2 = np.asarray(getdata(2,2))
y=np.zeros(16384)
for i in range(0,16383):
    y[i]=np.sin(2*np.pi*(i**1.5)/16384)
signal = ch1*y
l, = ax.plot(ch1) #plot data
g, = ax2.plot(y)
h, = ax3.plot(signal)
#ax2.set_xlim([0, 340])
#ax2.set_ylim([-8000,8000])
plt.show()

i=1
j=1
while 1:
    try:
#        gencont(2,i*100)
#        i=i+j
#        if i >= 20 or i<=1:
#            j=-j
        ch1 = np.asarray(getdata(1,1)) #get data from red pitaya
#        ch2 = np.asarray(getdata(2,2))
        signal = ch1*y
        l.set_ydata(ch1) #updata graph   
        g.set_ydata(y) #updates fft
        h.set_ydata(signal)
        ax.set_ylim([1.2*np.min(ch1), 1.2*np.max(ch1)])
        ax3.set_ylim([1.2*np.min(signal), 1.2*np.max(signal)])
        ax2.set_ylim([np.min(y), np.max(y)])
        plt.draw()
        plt.pause(0.0000000001)
    except KeyboardInterrupt:
        resetRP()   #reset acqusition
        break