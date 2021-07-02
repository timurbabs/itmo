import random
from decimal import *
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from shapely.geometry import Point
from shapely.ops import cascaded_union
# G = 6.67430e-11 * (3600 ** 2) / (1000 ** 3)
G = 6.67430e-11 / (1000 ** 3)
time = 120
 
 
class Object:
    mass = 0
    rad = 0
    vx = 0
    vy = 0
    vz = 0
    x = 0
    y = 0
    z = 0
    color = ''
    isSun = 0
 
    def __init__(self, mass, x, y, z, vx, vy, vz, rad, color, isSun):
        self.mass = mass
        self.x = float(x)
        self.y = float(y)
        self.z = float(z)
        self.vx = float(vx)
        self.vy = float(vy)
        self.vz = float(vz)
        self.rad = float(rad)
        self.color = color
        self.isSun = isSun
 
    def move(self):
        self.x += time * self.vx
        self.y += time * self.vy
        self.z += time * self.vz
 
    def change_speed(self, obj):
        rad_between = np.sqrt(((abs(obj.x - self.x)) ** 2) + ((abs(obj.y - self.y)) ** 2) + ((abs(obj.z - self.z)) ** 2))
        ax = G * obj.mass * (obj.x - self.x) / rad_between / rad_between / rad_between
        ay = G * obj.mass * (obj.y - self.y) / rad_between / rad_between / rad_between
        az = G * obj.mass * (obj.z - self.z) / rad_between / rad_between / rad_between
        # self.vx = self.vx + time * ax
        # self.vy = self.vy + time * ay
        # self.vz = self.vz + time * az
        self.vx += time * ax
        self.vy += time * ay
        self.vz += time * az
        # self.vx = self.vx + (time * G * (obj.x - self.x) / (rad_between ** 3))
        # self.vy = self.vy + (time * G * (obj.y - self.y) / (rad_between ** 3))
        # self.vz = self.vz + (time * G * (obj.z - self.z) / (rad_between ** 3))
 
    def __lt__(self, other):
        return self.y < other.y
 
fig, axs = plt.subplots(3)
fig.set_size_inches(8, 8)
axs[0] = plt.subplot2grid((2, 2), (0, 1))
axs[1] = plt.subplot2grid((2, 2), (1, 0), colspan=2, rowspan=1)
axs[2] = plt.subplot2grid((2, 2), (0, 0))
axs[0].set_xlim(-800, 800)
axs[0].set_ylim(-800, 800)
axs[0].set_title("Проекция xy")
axs[1].set_title("Светимость")
# axs[1].set_ylim(0.9998, 1.0001)
axs[2].set_xlim(-800, 800)
axs[2].set_ylim(-800, 800)
axs[2].set_title("Проекция xz")
line_fig, = axs[0].plot([], [], lw=2)
line_x, = axs[1].plot([], [], lw=2, label="x(t)")
line_y, = axs[1].plot([], [], lw=2, label="y(t)")
line_os, = axs[2].plot([], [], lw=2)
axs[0].set_xlabel("X, км * 10^6")
axs[0].set_ylabel("Y, км * 10^6")
axs[1].set_xlabel("t, " + str(time) + " * ч")
axs[1].set_ylabel("Светимость")
axs[2].set_xlabel("X, км * 10^6")
axs[2].set_ylabel("Y, км * 10^6")
 
dot, = axs[1].plot([0], [1], 'ro-')
# fig = plt.figure(figsize=(8, 8))
#
# ax = fig.add_subplot(221, xlim=(-40000, 40000), ylim=(-40000, 40000))
# ax2 = fig.add_subplot(222, xlim=(-40000, 40000), ylim=(-40000, 40000))
# ax3 = fig.add_subplot(223)
 
 
sun = Object(1.989e30, 0, 0, 0, 0, 0, 0, 696340, 'y', 1)
earth = Object(5.972e24, 1496e5, 0, 0, 0, np.sqrt((sun.mass * G) / 1496e5), 0, 6371.3, 'g', 0)
mars = Object(6.39e23, 2279e5, 0, 0, 0, np.sqrt((sun.mass * G) / 2279e5), 0, 3389.5, 'r', 0)
jupiter = Object(1.8986e27, 75573e4, 0, 0, 0, np.sqrt((sun.mass * G) / 755730000), 0, 69911, 'r', 0)
 
sun_clone = Object(1.989e30, 0, 0, 0, 0, 0, 0, 696340, 'y', 1)
earth_clone = Object(5.972e24, 1496e5, 0, 0, 0, np.sqrt((sun.mass * G) / 1496e5), 0, 6371.3, 'g', 0)
mars_clone = Object(6.39e23, 2279e5, 0, 0, 0, np.sqrt((sun.mass * G) / 2279e5), 0, 3389.5, 'r', 0)
jupiter_clone = Object(1.8986e27, 75573e4, 0, 0, 0, np.sqrt((sun.mass * G) / 755730000), 0, 69911, 'r', 0)
 
T = round((2 * np.pi * earth.x / earth.vy) / time)
 
planets = []
planets_clone = []
 
planets.append(sun)
planets.append(earth)
planets.append(mars)
# planets.append(jupiter)
 
planets_clone.append(sun_clone)
planets_clone.append(earth_clone)
planets_clone.append(mars_clone)
# planets.append(jupiter_clone)
 
planet_info = []
 
xs = []
ys = []
def graph():
    for k in range(T):
        for i in range(len(planets_clone)):
            for j in range(len(planets_clone)):
                if i != j:
                    planets_clone[i].change_speed(planets_clone[j])
 
        for i in range(len(planets_clone)):
            planets_clone[i].move()
 
        light = 1
        planet_list = []
        zone = Point(sun_clone.x, sun_clone.z).buffer(sun_clone.rad)
        for i in range(len(planets_clone)):
            if planets_clone[i].isSun == 0 and planets_clone[i].y < sun_clone.y:
                new_point = Point(planets_clone[i].x, planets_clone[i].z).buffer(planets_clone[i].rad)
                planet_list.append(new_point)
        sum_planets = cascaded_union(planet_list)
        zone = zone.intersection(sum_planets)
        square = (np.pi * (sun_clone.rad ** 2))
        less = (zone.area / square)
 
        # light = light - less + random.randint(-1, 0) / 1000000
        light = light - less
        xs.append(k)
        ys.append(light)
    axs[1].plot(xs, ys)
    f = open("light.txt", "w")
    for i in range(len(xs)):
        f.write(str(xs[i]) + '\t' + str(ys[i]).replace('.', ',') + '\n')
    f.close()
 
 
def animate(i):
    dot.set_data(i, ys[i])
    for obj in axs[0].findobj(match=type(plt.Circle(1, 1))):
        obj.remove()
    for obj in axs[2].findobj(match=type(plt.Circle(1, 1))):
        obj.remove()
 
    for i in range(len(planets)):
        for j in range(len(planets)):
            if i != j:
                planets[i].change_speed(planets[j])
 
    for i in range(len(planets)):
        planets[i].move()
 
    planets.sort()
    planets.reverse()
    for i in range(len(planets)):
        x = planets[i].x / (10 ** 6)
        y = planets[i].y / (10 ** 6)
        z = planets[i].z / (10 ** 6)
        clr = planets[i].color
        if planets[i].isSun:
            rad = planets[i].rad / 10000
        else:
            rad = planets[i].rad / 1000
 
        circle = plt.Circle((x, y), rad, color=clr, fill=True)
        circle1 = plt.Circle((x, z), rad, color=clr, fill=True)
 
        axs[0].add_patch(circle)
        axs[2].add_patch(circle1)
#
graph()
# anim = FuncAnimation(fig, animate, frames=T, interval=20)
# anim.save("anim.gif", fps = 10)
# plt.show()
