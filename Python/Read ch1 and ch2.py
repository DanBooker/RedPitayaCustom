from rpfunctions import getdata, startRP, resetRP, rp_s
import numpy as np
import matplotlib.pyplot as plt
#import time
Decimation = 64
tc = 8192/Decimation

startRP(Decimation)
    
'''
rp_s.tx_txt('GEN:RST')
rp_s.tx_txt('SOUR' +str(2)+ ':FUNC ' + str('sine').upper())
rp_s.tx_txt('SOUR' +str(2)+ ':FREQ:FIX ' + str(100000))
rp_s.tx_txt('SOUR' +str(2)+ ':VOLT ' + str(1))
    
#Enable output
rp_s.tx_txt('OUTPUT' +str(2)+ ':STATE ON')

'''
'''

minfreq = 1000
maxfreq = 200000
    
rp_s.tx_txt('GEN:RST')
rp_s.tx_txt('SOUR' +str(1)+ ':FUNC ' + str('sine').upper())
rp_s.tx_txt('SOUR' +str(1)+ ':FREQ:FIX ' + str(1000))
rp_s.tx_txt('SOUR' +str(1)+ ':VOLT ' + str(1))
    
#Enable output
rp_s.tx_txt('OUTPUT' +str(1)+ ':STATE ON')
    
j=1
while 1:
    try:
        i=minfreq
        rp_s.tx_txt('SOUR' +str(1)+ ':FREQ:FIX ' + str(i))
        i=i+j*1000
        time.sleep(0.5*0.008*1000/(maxfreq-minfreq))
        if i >= maxfreq or i <= minfreq:
            j=-j
    except KeyboardInterrupt:
        break
'''

plt.ion()                           #Start interactive mode
fig = plt.figure(figsize=(8,6))     #Set up subplot
ax = fig.add_subplot(211)           #subplot 1
ax2 = fig.add_subplot(212)          #subplot 2

ch1 = np.asarray(getdata(1,2))      #get data from channel 1
ch2 = np.asarray(getdata(2,2))      #get data from channel 2
t = np.linspace(0,1.0/tc, 1*len(ch1))

g, = ax.plot(t, ch1)                #Set up updating plots
h, = ax2.plot(t, ch2)

while 1:
    try:
        ch1 = np.asarray(getdata(1,2))      #get data from channel 1
        ch2 = np.asarray(getdata(2,2))      #get data from channel 2
        g.set_ydata(ch1)
        h.set_ydata(ch2)
        ax.set_xlim(0,0.0005)
        ax2.set_xlim(0,0.0005)
        plt.draw()
        plt.pause(0.00000000001)
    except KeyboardInterrupt:
        resetRP()                           #Reset Acquistion
        break
        