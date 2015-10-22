# IPython log file

import fractions as fr
import numpy as np

# problem 3:
# calculate s=P(B=3):
u1 = np.arange(fr.Fraction(0,1), 11)
s = np.sum((u1/10)**3*(1-u1/10)**7, axis=1)

# calculate res3=P(U=u|B=3):
u = np.arange(fr.Fraction(0,1), 11)
res3 = (u/10)**3*(1-u/10)**7 / s
res3_real = res.astype(float)

# plot distribution
import matplotlib.pyplot as plt
plt.bar(np.arange(11), res)
plt.show()

# problem 4:
res4_frac = np.sum(np.arange(11) * fr.Fraction(1,10) * res)
res4_real = float(res_frac)

