# Oefening 1: Beschouw de functie tanh(𝑥) =𝑒𝑥− 𝑒−𝑥𝑒𝑥+ 𝑒−𝑥○
# Gebruik Python om een plot te maken van deze functie.
# - Wat is het domein en beeld van deze functie volgens de plot?
# - Bereken de afgeleide functie van tanh.
# - Kan je het resultaat schrijven intermen vantanh?

import numpy as np
import matplotlib.pyplot as plt

# Definieer de tanh functie
def tanh(x):
    return lambda x : (np.exp(x) - np.exp(-x)) / (np.exp(x) + np.exp(-x))

# Maak een reeks x-waarden
x_values = np.linspace(-10, 10, 400)

# Bereken de bijbehorende y-waarden
y_values = tanh(x_values)

# Plot de grafiek
plt.plot(x_values, y_values, label=r'$\tanh(x)$')
plt.title('Plot van de functie tanh(x)')
plt.xlabel('x')
plt.ylabel('tanh(x)')
plt.grid(True)
plt.axhline(0, color='black',linewidth=1)
plt.axvline(0, color='black',linewidth=1)
plt.legend()
plt.show()
