import numpy as np
import peakutils
from peakutils.plot import plot as pplt
from matplotlib import pyplot as plt
from smooth import smooth

centers = (30.5, 72.3)
x = np.linspace(0, 120, 121)
y = (peakutils.gaussian(x, 5, centers[0], 3) +
    peakutils.gaussian(x, 7, centers[1], 10) +
    np.random.rand(x.size))
plt.figure(figsize=(10,6))
plt.plot(x, y)
plt.title("Data with noise")

y=smooth(y, 10, 'bartlett')
plt.figure(figsize=(10,6))
plt.plot(y)
plt.title("Smoothing test")

dx = x[1]-x[0]
dydx = np.gradient(y,1)
d2ydx2 = np.gradient(dydx,1)
print dydx

indexes = peakutils.indexes(y, thres=0.5, min_dist=30)
print(indexes)
print(x[indexes], y[indexes])
plt.figure(figsize=(10,6))
pplt(x, y, indexes)
plt.title('First estimate')

plt.plot(dydx)

peaks_x = peakutils.interpolate(x, y, ind=indexes)
print(peaks_x)

for i in range(0,len(dydx)-1):
    if dydx[i]>=0 and dydx[i+1]<=0:
        if abs((d2ydx2[i]+d2ydx2[i+1])/2)>=0.05:
            print 'Maximum at:',i, '-', i+1, ' Height:', (y[i]+y[i+1])/2, ' Second derivative:', ((d2ydx2[i]+d2ydx2[i+1])/2)
    elif dydx[i]<=0 and dydx[i+1]>=0:
        if abs((d2ydx2[i]+d2ydx2[i+1])/2)>=0.05:
            print 'Minimum at:',i, '-', i+1, ' Height:', (y[i]+y[i+1])/2, ' Second derivative:', ((d2ydx2[i]+d2ydx2[i+1])/2)