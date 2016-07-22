import numpy as np
import redpitaya_scpi as scpi
import matplotlib.pyplot as plt
import peakutils
from peakutils.plot import plot as pk

#-----------------------------------------------------------------------------

'''Create figure'''
plt.ion()
fig = plt.figure(figsize=(8,6))
ax = fig.add_subplot(211)
ax2 = fig.add_subplot(212)
ax.set_ylabel('Voltage(V)')
ax.set_xlabel('Time(ms)')


#-----------------------------------------------------------------------------

rp_s = scpi.scpi('152.78.193.126') #connect to red pitaya ip

timescale = 1 #timescale of x-axis in ms

sample_rate_dict = {'125':'125MHz', '15.6': '15_6MHz', '1.9': '1_9MHz'} #possible sample rates

rp_s.tx_txt('ACQ:DEC 1') #decimation
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

'''Decimation and Correction Factor'''

rp_s.tx_txt('ACQ:DEC?')
Decimation = rp_s.rx_txt()
Decimation = int(Decimation.replace("ERR!", ""))
Sf = 8192/Decimation
#Cf = 0.928 # 200KHz to 400KHz 
Cf = 0.93185 # 750KHz Upwards
#Cf = 0.939 # 100Khz and Below
#Cf = 0.935 # Around 500KHz
Ff = 0.9975

#-----------------------------------------------------------------------------

freqMod = getdata() #get data from red pitaya
#time = np.linspace(0, timescale, len(buff))

fs = len(freqMod)
fsi = 1.0/fs
timeEnd =1
time = np.linspace(0,1.0/Sf,fs*timeEnd)

fftm = np.abs(np.fft.fft(freqMod))
freqm = np.fft.fftfreq(fftm.size, fsi)
positives = np.where(freqm>=0)
fftm = fftm[positives]
freqm = freqm[positives]

FaS = np.sin(2*np.pi*Fa1*time)
FcS = np.sin(np.arcsin(freqMod) - FaS)

l, = ax.plot(time, freqMod) #plot data
g, = ax2.plot(freqm, fftm)
#ax2.set_xlim([0, 340])
#ax2.set_ylim([-8000,8000])

plt.show()

print "Carrier Frequency | Modulating Frequency | Lower Sideband | Higher Sideband"

while 1:
    try:
        freqMod = getdata() #get new set of data
        fs = len(freqMod)
        fsi = 1.0/fs
        fftm = np.abs(np.fft.fft(freqMod))
        freqm = Sf*Cf*np.fft.fftfreq(fftm.size, fsi)
        positives = np.where(freqm>=0)
        fftm = fftm[positives]
        freqm = freqm[positives]
        
        l.set_ydata(freqMod) #updata graph
        l.set_xdata(time)
        g.set_ydata(fftm) #updates fft
        g.set_xdata(freqm)
        ax.set_ylim([np.min(freqMod), np.max(freqMod)])
        ax.set_xlim([0,0.00001])
        ax2.set_xlim([0,0.5*np.max(freqm)])
        ax2.set_ylim([0,np.max(fftm)])
        
        indexes = peakutils.indexes(fftm, thres=0.03, min_dist=10)
        l1=freqm[indexes[(len(indexes)-1)/2]] #Defining peaks left and right of the centre peak
        r1=freqm[indexes[(1+len(indexes))/2]]
        Al1=fftm[indexes[(1+len(indexes))/2]]
        Ar1=fftm[indexes[(len(indexes)-2)/2]]
        
        Fao = freqm[indexes[(len(indexes))/2]] #Carrier Frequency
        Fa1 = Ff*((Fao - l1) + (r1 - Fao)) #Distance between two frequencies, FM Frequency
        
        FaS = np.sin(2*np.pi*Fa1*time)*np.max(freqMod)
        FcS = np.sin(np.arcsin(freqMod) - FaS)
        
        plt.draw()
        plt.pause(0.0000000001)
        Sbl=Fao-Fa1
        Sbh=Fao+Fa1
        print "  ",Fao,"  |     ",Fa1,"   | ",Sbl," | ",Sbh
        print Al1, Ar1
    except KeyboardInterrupt:
        rp_s.tx_txt('ACQ:RST')   #reset acqusition
        break
    


#indexes = peakutils.indexes(fftm, thres=0.02, min_dist=30)
#plt.figure(figsize=(10,6))
#pk(freqm, fftm, indexes)
#plt.title('First estimate')
#plt.show()




