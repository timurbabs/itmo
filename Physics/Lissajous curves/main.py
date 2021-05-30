from tkinter import Tk, BOTH, LEFT, X, messagebox
from tkinter.ttk import Frame, LabelFrame, Label, Entry, Style
from matplotlib.animation import FuncAnimation
from PIL import Image, ImageTk, ImageOps
from ttkthemes import ThemedStyle
import matplotlib.pyplot as plt
import matplotlib
import tkinter
import numpy as np
p_temp = 0
p_time = 10


def convert_to_float(frac_str):
    try:
        return float(frac_str)
    except ValueError:
        num, denom = frac_str.split('/')
        try:
            leading, num = num.split(' ')
            whole = float(leading)
        except ValueError:
            whole = 0
        frac = float(num) / float(denom)
        return whole - frac if whole < 0 else whole + frac


def pi_parse(frac_str):
    frac_str = frac_str.replace("PI", "3.14159265359")
    frac_str = frac_str.replace("pi", "3.14159265359")
    frac_str = frac_str.replace("Pi", "3.14159265359")
    return frac_str


class Menu(Frame):

    def __init__(self, parent):
        Frame.__init__(self, parent)
        self.style = Style()
        self.parent = parent
        self.entry_x = None
        self.entry_y = None
        self.entry_xa = None
        self.entry_ya = None
        self.entry_sh = None
        self.entry_tm = None
        self.initUI()

    def initUI(self):
        self.parent.title("Lissajous")
        self.pack(fill=BOTH, expand=True)
        style = ThemedStyle(self)
        style.set_theme("equilux")
        self.pack(fill=BOTH, expand=1)

        frame_frequency = LabelFrame(self, text="Frequency:")
        frame_frequency.pack(fill=X)

        frame_x = Frame(frame_frequency)
        frame_x.pack(fill=X)

        lbl_x = Label(frame_x, text="a:", width=10)
        lbl_x.pack(side=LEFT, padx=5, pady=5)

        self.entry_x = Entry(frame_x)
        self.entry_x.pack(side=LEFT)

        frame_y = Frame(frame_frequency)
        frame_y.pack(fill=X)

        lbl_y = Label(frame_y, text="b:", width=10)
        lbl_y.pack(side=LEFT, padx=5, pady=5)

        self.entry_y = Entry(frame_y)
        self.entry_y.pack(side=LEFT)

        frame_amplitude = LabelFrame(self, text="Amplitude:")
        frame_amplitude.pack(fill=X, pady=10)

        frame_xa = Frame(frame_amplitude)
        frame_xa.pack(fill=X)

        lbl_xa = Label(frame_xa, text="A:", width=10)
        lbl_xa.pack(side=LEFT, padx=5, pady=5)

        self.entry_xa = Entry(frame_xa)
        self.entry_xa.pack(side=LEFT)

        frame_ya = Frame(frame_amplitude)
        frame_ya.pack(fill=X)

        lbl_ya = Label(frame_ya, text="B:", width=10)
        lbl_ya.pack(side=LEFT, padx=5, pady=5)

        self.entry_ya = Entry(frame_ya)
        self.entry_ya.pack(side=LEFT)

        frame_phase = LabelFrame(self, text="Phase shift:")
        frame_phase.pack(fill=X, pady=10)

        lbl_sh = Label(frame_phase, text="δ:", width=10)
        lbl_sh.pack(side=LEFT, padx=5, pady=5)

        self.entry_sh = Entry(frame_phase)
        self.entry_sh.pack(side=LEFT)

        frame_time = LabelFrame(self, text="Point plot update time(default is 10):")
        frame_time.pack(fill=X, pady=10)

        lbl_time = Label(frame_time, text="Time:", width=10)
        lbl_time.pack(side=LEFT, padx=5, pady=5)

        self.entry_tm = Entry(frame_time)
        self.entry_tm.pack(side=LEFT)

        make_button = tkinter.ttk.Button(self, text="Show", command=self.lissajous_curve)
        make_button.place(x=95, y=390)

        bard = Image.open("my.png")
        if isinstance(5, int) or isinstance(5, tuple):
            bard = ImageOps.expand(bard, border=5)
        else:
            raise RuntimeError('Border is not an integer or tuple!')
        formula = ImageTk.PhotoImage(bard)
        label1 = Label(self, image=formula)
        label1.image = formula
        label1.place(x=35, y=300)

    def lissajous_curve(self):
        try:
            global p_time
            freq_a = pi_parse(self.entry_x.get())
            freq_a = convert_to_float(freq_a)
            freq_b = pi_parse(self.entry_y.get())
            freq_b = convert_to_float(freq_b)
            ampl_a = pi_parse(self.entry_xa.get())
            ampl_a = convert_to_float(ampl_a)
            ampl_b = pi_parse(self.entry_ya.get())
            ampl_b = convert_to_float(ampl_b)
            phase = pi_parse(self.entry_sh.get())
            phase = convert_to_float(phase)
            if len(self.entry_tm.get()) != 0:
                p_time = convert_to_float(self.entry_tm.get())
            else:
                p_time = 10

        except ValueError:
            messagebox.showerror("Error", "Enter only float or integer numbers, or fill the fields")
            return

        # plt.style.use('dark_background') # optional style '3B1B'.
        fig, axs = plt.subplots(3)
        fig.set_size_inches(9, 8)
        axs[0] = plt.subplot2grid((3, 3), (0, 1))
        axs[1] = plt.subplot2grid((3, 3), (1, 0), colspan=2, rowspan=1)
        axs[2] = plt.subplot2grid((3, 3), (0, 0))
        axs[0].set_xlim(-4, 4)
        axs[0].set_ylim(-4, 4)
        axs[0].set_title("Point trajectory")
        axs[1].set_xlim(0, 6)
        axs[1].set_ylim(-8, 8)
        axs[1].set_title("Waves")
        axs[2].set_xlim(-4, 4)
        axs[2].set_ylim(-4, 4)
        axs[2].set_title("Lissajous figure")
        line_fig, = axs[0].plot([], [], lw=2)
        line_x, = axs[1].plot([], [], lw=2, label="x(t)")
        line_y, = axs[1].plot([], [], lw=2, label="y(t)")
        line_os, = axs[2].plot([], [], lw=2)
        dot, = axs[0].plot([0], [0], 'ro-')

        axs[0].set_xlabel("X axis --------->")
        axs[0].set_ylabel("Y axis --------->")
        axs[1].set_xlabel("Time(t) --------->")
        axs[1].set_ylabel("Waves --------->")
        axs[2].set_xlabel("X axis --------->")
        axs[2].set_ylabel("Y axis --------->")

        axs[1].legend([line_x, line_y], [line_x.get_label(), line_y.get_label()])
        matplotlib.pyplot.tight_layout()

        x_data = []
        y_data = []

        def animate(i):
            t = 0.01 * i
            global p_time
            global p_temp

            step = np.linspace(0, 2 * np.pi, 1000)
            x = ampl_a * np.sin(freq_a * t + phase)
            y = ampl_b * np.sin(freq_b * t)
            xc = ampl_a * np.sin((freq_a * step + t) + phase)
            yc = ampl_b * np.sin(freq_b * step + t)
            x_data.append(x)
            y_data.append(y)
            line_fig.set_data(x_data, y_data)
            line_x.set_data(step, xc)
            line_y.set_data(step, yc)
            line_os.set_data(xc, yc)
            dot.set_data(x, y)

            if t == 0:
                p_temp = 0
            if t > p_temp:
                p_temp = p_temp + p_time
                x_data.clear()
                y_data.clear()

            return line_fig, dot, line_x, line_y, line_os,

        ani = FuncAnimation(fig, animate, interval=10, blit=True)
        # ani.save('0.gif', writer='ffmpeg')
        plt.show()


def main():
    root = Tk()
    root.geometry("300x450")
    root.resizable(width=False, height=False)
    Menu(root)
    root.mainloop()


if __name__ == '__main__':
    main()
