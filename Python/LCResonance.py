import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

root = 'C:/Users/Dan/Desktop/'

f = 'BookF.csv'

df = pd.read_csv(root+f)

freq = df['Freq(MHz)']
phase = df['phase(ns)']
phasef = phase/freq
amp = df['Amplitude(mV)']

plt.plot(freq, amp/np.max(amp), lw=5, c='r')