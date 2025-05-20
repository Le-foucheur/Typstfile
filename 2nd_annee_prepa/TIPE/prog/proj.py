import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D

def dec(v):
    if v < 0:
        return -np.arccosh(1 - v)
    else:
        return np.arccosh(v + 1)

# Surface 3D (exemple : une sphère)
theta = np.linspace(0, 2 * np.pi, 500)
phi = np.linspace(-7, 7, 500)
for i in range(len(phi)):
    phi[i] = dec(phi[i])
print(phi)
theta, phi = np.meshgrid(theta, phi)
r = 1
x = r * np.cos(theta) / np.cosh(phi)
y = r * np.sin(theta) / np.cosh(phi)
z = phi - np.tanh(phi)

# Projection personnalisée (exemple : projection cylindrique)
image = plt.imread("/home/jvj/Telechargements/merci.jpg")
u = (theta - np.min(theta)) / (np.max(theta) - np.min(theta))  # Normalisation
v = (phi - np.min(phi)) / (np.max(phi) - np.min(phi))
image = image[::-1]
texture = image[
    (v * (image.shape[0] - 1)).astype(int), (u * (image.shape[1] - 1)).astype(int)
]

# Affichage
fig = plt.figure()
ax: Axes3D = fig.add_subplot(111, projection="3d")
ax.set_axis_off()
ax.view_init(elev=4, azim=-180, roll=0)
ax.set_xlim(-3, 3)
ax.set_ylim(-3, 3)
ax.plot_surface(x, y, z, facecolors=texture / 255.0, rstride=1, cstride=1)

plt.savefig("result.png", format="png", dpi=1000)
#plt.show()