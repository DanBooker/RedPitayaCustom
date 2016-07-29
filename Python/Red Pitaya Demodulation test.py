import numpy as np
import redpitaya_scpi as scpi
import matplotlib.pyplot as plt
import peakutils
from peakutils.plot import plot as pk

#-----------------------------------------------------------------------------

'''Create figure'''
plt.ion()
fig = plt.figure(figsize=(8,6))
ax = fig.add_subplot(421)
ax2 = fig.add_subplot(422)
ax3 = fig.add_subplot(423)
ax4= fig.add_subplot(424)
ax.set_ylabel('Voltage(V)')
ax.set_xlabel('Time(ms)')


#-----------------------------------------------------------------------------

rp_s = scpi.scpi('152.78.193.126') #connect to red pitaya ip

timescale = 1 #timescale of x-axis in ms

sample_rate_dict = {'125':'125MHz', '15.6': '15_6MHz', '1.9': '1_9MHz'} #possible sample rates

rp_s.tx_txt('ACQ:DEC 8192') #decimation
rp_s.tx_txt('ACQ:SRAT '+ sample_rate_dict['125']) #sample rate
rp_s.tx_txt('ACQ:TRIG:LEV 0') #trigger level in mV
rp_s.tx_txt('ACQ:TRIG:DLY 8192') #trigger delay in sample steps

#-----------------------------------------------------------------------------

'''Function to read data from Red Pitaya and return as array'''
def getdata(ch=1, tch=1):
    rp_s.tx_txt('ACQ:START')
    rp_s.tx_txt('ACQ:TRIG CH%d_PE' % tch)
    while 1:        
        rp_s.tx_txt('ACQ:TRIG:STAT?')
        if rp_s.rx_txt() == 'TD':
            break
    rp_s.tx_txt('ACQ:SOUR%d:DATA:LAT:N? 16384' % ch)
    buff_string = rp_s.rx_txt()
    buff_string = buff_string.strip('{}\n\r').replace("  ", "").split(',')
    buff = map(float, buff_string)
    return buff

#-----------------------------------------------------------------------------

freqMod = getdata() #get data from red pitaya
#time = np.linspace(0, timescale, len(buff))

fs = len(freqMod)
fsi = 1.0/fs
timeEnd =1
time = np.linspace(0,1,fs*timeEnd)

fftm = np.abs(np.fft.fft(freqMod))
freqm = np.fft.fftfreq(fftm.size, fsi)
positives = np.where(freqm>=0)
fftm = fftm[positives]
freqm = freqm[positives]

l, = ax.plot(time, freqMod) #plot data
g, = ax2.plot(freqm, fftm)
#ax2.set_xlim([0, 340])
#ax2.set_ylim([-8000,8000])

plt.show()

while 1:
    try:
        freqMod = getdata() #get new set of data
        fs = len(freqMod)
        fsi = 1.0/fs
        fftm = np.abs(np.fft.fft(freqMod))
        freqm = 0.93165381*np.fft.fftfreq(fftm.size, fsi)
        positives = np.where(freqm>=0)
        fftm = fftm[positives]
        freqm = freqm[positives]
        l.set_ydata(freqMod) #updata graph
        l.set_xdata(time)
        g.set_ydata(fftm) #updates fft
        g.set_xdata(freqm)
        ax.set_ylim([0.97*np.min(freqMod), 1.1*np.max(freqMod)])
        ax2.set_xlim([0,10000])
        plt.draw()
        plt.pause(0.0000000001)
    except KeyboardInterrupt:
        rp_s.tx_txt('ACQ:RST')   #reset acqusition
        break
