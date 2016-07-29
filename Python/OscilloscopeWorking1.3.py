import numpy as np
import matplotlib.pyplot as plt
from rpfunctions import startRP, resetRP, gencont, gensweep, getdata

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

#-----------------------------------------------------------------------------

buff = getdata() #get data from red pitaya
#time = np.linspace(0, timescale, len(buff))
l, = ax.plot(buff) #plot data
g, = ax2.plot(np.fft.fft(buff))
#ax2.set_xlim([0, 340])
#ax2.set_ylim([-8000,8000])
plt.show()



while 1:
    try:
        buff = getdata() #get new set of data
        l.set_ydata(buff) #updata graph
        g.set_ydata(np.fft.fft(buff)) #updates fft
        ax.set_ylim([1.08*np.min(buff), 1.08*np.max(buff)])
        ax.set_xlim(0,2000)
        #ax2.set_ylim([np.min(np.fft.fft(buff)), np.max(np.fft.fft(buff))])
        plt.draw()
        plt.pause(0.000001)
    except KeyboardInterrupt:
        resetRP()
        break