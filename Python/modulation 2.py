#import numpy as np
#import matplotlib.pyplot as plt

#def sleep_spindle_match(sampling_freq):
#    freq = 13 #Hz

#    x = np.arange(0,1,1.0/sampling_freq)
#    y = np.sin(2 * np.pi * freq * x + (np.pi/2)) * np.cos(np.pi * x + (np.pi/2))

#    spindle = {'x':x, 'y':y}

#    return spindle



#x = sleep_spindle_match(44100)
#plt.plot(x['x'], x['y'])
#plt.show()

import numpy as np
import matplotlib.pyplot as plt

def wave1(sampling_freq):
    freqc = 100 #Hz
    freqm = 4 #Hz
    am = 0.8 #Modulation Amplitude
    x = np.arange(0,1,1.0/sampling_freq)
    y = np.cos(2*np.pi*freqc*(x + (am/(2*np.pi*freqm))*np.sin(2*np.pi*freqm*x)))
    
    return y
    
r = np.arange(0,1,1.0/1000)  
  
fig = plt.figure(figsize=(8,6))
ax = fig.add_subplot(211)
ax2 = fig.add_subplot(212)
   
x2 = wave1(1000)
d=np.fft.fft(x2)
ax.plot(r, x2)
ax2.set_xlim([0,213])
ax2.plot(abs(d))
plt.show()
    