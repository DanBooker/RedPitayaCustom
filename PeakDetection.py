import numpy as np
import peakutils
from peakutils.plot import plot as pplt
from matplotlib import pyplot as plt

centers = (30.5, 72.3)
x = np.linspace(0, 120, 121)
y = (peakutils.gaussian(x, 5, centers[0], 3) +
    peakutils.gaussian(x, 7, centers[1], 10) +
    np.random.rand(x.size))
plt.figure(figsize=(10,6))
plt.plot(x, y)
plt.title("Data with noise")

dx = x[1]-x[0]
dydx = np.gradient(y,1)

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