import redpitaya_scpi as scpi
import time

rp_s = scpi.scpi('152.78.194.163') #connect to red pitaya ip

#-----------------------------------------------------------------------------

def startRP(dec=1, lvl=0, dly=8192):
    sample_rate_dict = {'125':'125MHz', '15.6': '15_6MHz', '1.9': '1_9MHz'} #possible sample rates
    
    rp_s.tx_txt('ACQ:DEC %d' %dec) #decimation
    rp_s.tx_txt('ACQ:SRAT '+ sample_rate_dict['125']) #sample rate
    rp_s.tx_txt('ACQ:TRIG:LEV %d' %lvl) #trigger level in mV
    rp_s.tx_txt('ACQ:TRIG:DLY %d' %dly) #trigger delay in sample steps

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
    
def resetRP():
    rp_s.tx_txt('ACQ:RST')
    rp_s.tx_txt('OUTPUT1:STATE OFF')
    rp_s.tx_txt('OUTPUT2:STATE OFF')
    rp_s.tx_txt('GEN:RST')

#-----------------------------------------------------------------------------

def gencont(ch=2, freq=100000, ampl=1, wave_form='sine'):
    
    rp_s.tx_txt('SOUR' +str(ch)+ ':FUNC ' + str(wave_form).upper())
    rp_s.tx_txt('SOUR' +str(ch)+ ':FREQ:FIX ' + str(freq))
    rp_s.tx_txt('SOUR' +str(ch)+ ':VOLT ' + str(ampl))
    
    #Enable output
    rp_s.tx_txt('OUTPUT' +str(ch)+ ':STATE ON')



def gensweep(ch=1, minfreq=1000, maxfreq=200000, interval=1000, timescale=0.008, ampl=1, wave_form='sine'):
    
    rp_s.tx_txt('GEN:RST')
    rp_s.tx_txt('SOUR' +str(ch)+ ':FUNC ' + str(wave_form).upper())
    rp_s.tx_txt('SOUR' +str(ch)+ ':FREQ:FIX ' + str(minfreq))
    rp_s.tx_txt('SOUR' +str(ch)+ ':VOLT ' + str(ampl))
    
    #Enable output
    rp_s.tx_txt('OUTPUT' +str(ch)+ ':STATE ON')
    
    j=1
    while 1:
        try:
            i=minfreq
            rp_s.tx_txt('SOUR' +str(ch)+ ':FREQ:FIX ' + str(i))
            i=i+j*interval
            time.sleep(0.5*timescale*interval/(maxfreq-minfreq))
            if i >= maxfreq or i <= minfreq:
                j=-j
        except KeyboardInterrupt:
            break
