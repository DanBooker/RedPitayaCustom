import numpy as np
import redpitaya_scpi as scpi
import matplotlib.pyplot as plt

#-----------------------------------------------------------------------------

'''Create figure'''
plt.ion()
fig = plt.figure(figsize=(8,6))
ax = fig.add_subplot(211)
ax2 = fig.add_subplot(212)
ax.set_ylabel('Voltage(V)')
ax.set_xlabel('Samples')

#-----------------------------------------------------------------------------

rp_s = scpi.scpi('152.78.193.126') #connect to red pitaya ip

scale = 1 #scale of x-axis in ms

sample_rate_dict = {'125':'125MHz', '15.6': '15_6MHz', '1.9': '1_9MHz'} #possible sample rates

rp_s.tx_txt('ACQ:DEC 1024') #decimation
rp_s.tx_txt('ACQ:SRAT '+ sample_rate_dict['125']) #sample rate
rp_s.tx_txt('ACQ:TRIG:LEV 0') #trigger level in mV
rp_s.tx_txt('ACQ:TRIG:DLY 8192') #trigger delay in sample steps
rp_s.tx_txt('ACQ:AVG ON')

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
step = 50
buff = getdata() #get data from red pitaya
#time = np.linspace(0, timescale, len(buff))
l, = ax.plot(buff[::step]) #plot data
g, = ax2.plot(np.gradient(buff[::step],1))
#ax2.set_xlim([0, 340])
ax2.set_ylim([-1e-3,1e-3])
plt.show()
#-----------------------------------------------------------------------------
samples=100
mem=np.zeros([samples,len(np.gradient(buff[::step],1))])

def average(array,memory,samples=10):
    memory[samples-1,:]=array
    for i in range(0,samples-1):
        mem[i,:]=mem[i+1]
    average=np.zeros([len(array)])
    for i in range(0,len(array)):
        for j in range(0,samples):
            average[i]+=mem[j,i]/samples
    return average
#-----------------------------------------------------------------------------

while 1:
    try:
        buff = getdata() #get new set of data
        l.set_ydata(buff[::step]) #updata graph
        gradient=average(np.gradient(buff[::step],1),mem,samples)
        g.set_ydata(gradient)
        ax.set_ylim([np.min(buff[::step]), np.max(buff[::step])])
        ax2.set_ylim([np.min(gradient), np.max(gradient)])
        plt.draw()
        plt.pause(0.0000000001)
    except KeyboardInterrupt:
        gradient=average(np.gradient(buff[::step],1),mem,samples)
        for i in range(0,len(gradient)-1):
            if gradient[i]>=0 and gradient[i+1]<=0:
                print 'Maximum:',i, gradient[i], gradient[i+1]
            elif gradient[i]<=0 and gradient[i+1]>=0:
                print 'Minimum:',i, gradient[i], gradient[i+1]
        rp_s.tx_txt('ACQ:RST')   #reset acqusition
        break