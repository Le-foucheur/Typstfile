from math import cos, pi
from matplotlib.pyplot import show, plot

def I(x,N):
    res = 0
    for i in range(N):
        res += (1 / (1 + x  * cos(2 * pi * i / N))**2)
    return 2 * pi/N * res

precision = 10000
N = 10000

Y = [I(i/(2*N), precision) for i in range(N +1)]
X = [i/(2*N) for i in range(N+1)]

plot(X,Y)
show()