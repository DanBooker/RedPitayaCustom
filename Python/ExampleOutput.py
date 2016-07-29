import numpy as np
import matplotlib.pyplot as plt
from rpfunctions import startRP, resetRP, getdata, gencont, gensweep

#-----------------------------------------------------------------------------

'''Create figure'''
plt.ion()
fig = plt.figure(figsize=(8,6))
ax = fig.add_subplot(211)
ax2 = fig.add_subplot(212)
ax.set_ylabel('Voltage(V)')
ax.set_xlabel('Time(ms)')

#-----------------------------------------------------------------------------

startRP(64)
gencont(1,10000)
gencont(2,10000)
#-----------------------------------------------------------------------------

buff = getdata(1,1) #get data from red pitaya
#buff2 = getdata(2,2)
l, = ax.plot(buff) #plot data
g, = ax2.plot(np.fft.fft(buff))
#ax2.set_xlim([0, 340])
#ax2.set_ylim([-8000,8000])
plt.show()



while 1:
    try:
        buff = getdata(1,1) #get new set of data
        #buff2 = getdata(2,2)
        l.set_ydata(buff) #updata graph
        g.set_ydata(np.fft.fft(buff)) #updates fft
        ax.set_ylim([1.08*np.min(buff), 1.08*np.max(buff)])
        #ax2.set_ylim([np.min(np.fft.fft(buff)), np.max(np.fft.fft(buff))])
        plt.draw()
        plt.pause(0.000001)
    except KeyboardInterrupt:
        resetRP()
        break
