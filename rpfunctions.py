import redpitaya_scpi as scpi

rp_s = scpi.scpi('152.78.194.163') #connect to red pitaya ip

#-----------------------------------------------------------------------------

def startRP(dec=1, lvl=0, dly=8192):
    sample_rate_dict = {'125':'125MHz', '15.6': '15_6MHz', '1.9': '1_9MHz'} #possible sample rates
    
    rp_s.tx_txt('ACQ:DEC 64') #decimation
    rp_s.tx_txt('ACQ:SRAT '+ sample_rate_dict['125']) #sample rate
    rp_s.tx_txt('ACQ:TRIG:LEV 100') #trigger level in mV
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
    
def resetRP():
    rp_s.tx_txt('ACQ:RST')
