# oefeningen H1

## 1. Lineaire onafhankelijkheid van vectoren

We moeten bepalen of de gegeven verzamelingen van vectoren lineair onafhankelijk zijn. Vectoren zijn lineair onafhankelijk als de enige oplossing van de vergelijking \( c_1 v_1 + c_2 v_2 = 0 \) de triviale oplossing is \( c_1 = c_2 = 0 \).

- **a)** \( \mathbf{a} = \begin{bmatrix} 1 \\ 1 \end{bmatrix} \), \( \mathbf{b} = \begin{bmatrix} 2 \\ 2 \end{bmatrix} \)

   Deze vectoren zijn lineair afhankelijk omdat \( \mathbf{b} = 2 \cdot \mathbf{a} \).

- **b)** \( \mathbf{a} = \begin{bmatrix} 1 \\ 1 \end{bmatrix} \), \( \mathbf{b} = \begin{bmatrix} 1 \\ 2 \end{bmatrix} \)

   Deze vectoren zijn lineair onafhankelijk, omdat er geen constante \( c_1 \) en \( c_2 \) bestaan die aan de vergelijking \( c_1 \mathbf{a} + c_2 \mathbf{b} = 0 \) voldoen, behalve de triviale oplossing \( c_1 = c_2 = 0 \).

- **c)** \( \mathbf{a} = \begin{bmatrix} 1 \\ 0 \\ 0 \end{bmatrix} \), \( \mathbf{b} = \begin{bmatrix} 1 \\ 1 \\ 0 \end{bmatrix} \)

   Deze vectoren zijn lineair onafhankelijk, omdat ze niet een veelvoud van elkaar zijn.

- **d)** \( \mathbf{a} = \begin{bmatrix} 1 \\ 0 \\ 1 \end{bmatrix} \), \( \mathbf{b} = \begin{bmatrix} 2 \\ -1 \\ 1 \end{bmatrix} \), \( \mathbf{c} = \begin{bmatrix} -3 \\ 1 \\ -2 \end{bmatrix} \)

   Deze vectoren zijn lineair onafhankelijk, aangezien geen enkele vector een lineaire combinatie van de andere twee is.

## 2. Coördinaten van een vector ten opzichte van een andere basis

Je hebt de vector \( \mathbf{v} = \begin{bmatrix} 5 \\ -1 \end{bmatrix} \) en de basis \( \mathbf{b_1} = \begin{bmatrix} 1 \\ 1 \end{bmatrix} \), \( \mathbf{b_2} = \begin{bmatrix} 1 \\ -1 \end{bmatrix} \).

Om de coördinaten van \( \mathbf{v} \) ten opzichte van de basis \( \{ \mathbf{b_1}, \mathbf{b_2} \} \) te vinden, moeten we de lineaire combinatie van \( \mathbf{b_1} \) en \( \mathbf{b_2} \) gelijkstellen aan \( \mathbf{v} \):

\[
\mathbf{v} = c_1 \mathbf{b_1} + c_2 \mathbf{b_2}
\]

Dus,

\[
\begin{bmatrix} 5 \\ -1 \end{bmatrix} = c_1 \begin{bmatrix} 1 \\ 1 \end{bmatrix} + c_2 \begin{bmatrix} 1 \\ -1 \end{bmatrix}
\]

Wat resulteert in het stelsel van vergelijkingen:

\[
\begin{cases}
c_1 + c_2 = 5 \\
c_1 - c_2 = -1
\end{cases}
\]

Door dit stelsel op te lossen, krijgen we:

\[
c_1 = 2, \quad c_2 = 3
\]

Dus de coördinaten van \( \mathbf{v} \) ten opzichte van de basis \( \{ \mathbf{b_1}, \mathbf{b_2} \} \) zijn \( \begin{bmatrix} 2 \\ 3 \end{bmatrix} \).

## 3. Lineaire deelruimte van \( \mathbb{R}^3 \)

We moeten bepalen of de verzameling vectoren van de vorm \( \begin{bmatrix} \alpha_1 \\ \alpha \end{bmatrix} \) met \( \alpha \in \mathbb{R} \) een lineaire deelruimte van \( \mathbb{R}^3 \) vormt.

Deze vectoren liggen in \( \mathbb{R}^2 \), omdat ze slechts twee componenten hebben. Een lineaire deelruimte van \( \mathbb{R}^3 \) moet echter drie componenten hebben, dus deze verzameling vormt geen lineaire deelruimte van \( \mathbb{R}^3 \).

## 4. Loodrechte projectie van vectoren

De formule voor de projectie van een vector \( \mathbf{a} \) op een vector \( \mathbf{b} \) is:

\[
\text{proj}_{\mathbf{b}} \mathbf{a} = \frac{\mathbf{a} \cdot \mathbf{b}}{\mathbf{b} \cdot \mathbf{b}} \mathbf{b}
\]

Nu gaan we dit toepassen op de gegeven vectoren:

- **a)** \( \mathbf{a} = \begin{bmatrix} 1 \\ 0 \\ 2 \end{bmatrix} \), \( \mathbf{b} = \begin{bmatrix} 3 \\ 4 \\ -1 \end{bmatrix} \)
- **b)** \( \mathbf{a} = \begin{bmatrix} 1 \\ 0 \\ 2 \end{bmatrix} \), \( \mathbf{b} = \begin{bmatrix} -2 \\ 0 \\ -4 \end{bmatrix} \)
- **c)** \( \mathbf{a} = \begin{bmatrix} 1 \\ 0 \\ 2 \end{bmatrix} \), \( \mathbf{b} = \begin{bmatrix} 4 \\ -3 \\ -2 \end{bmatrix} \)

De projectie wordt berekend door de formule toe te passen voor elk paar van \( \mathbf{a} \) en \( \mathbf{b} \).

## 5. Cosinus Similariteit met Numpy

De cosinus similariteit \( \text{cosine\_similarity}(\mathbf{a}, \mathbf{b}) \) tussen twee vectoren \( \mathbf{a} \) en \( \mathbf{b} \) wordt gegeven door:

\[
\text{cosine\_similarity}(\mathbf{a}, \mathbf{b}) = \frac{\mathbf{a} \cdot \mathbf{b}}{\|\mathbf{a}\| \|\mathbf{b}\|}
\]

Dit kan als volgt worden geïmplementeerd in Python met Numpy:

```python
import numpy as np

def cosine_similarity(a, b):
    dot_product = np.dot(a, b)
    norm_a = np.linalg.norm(a)
    norm_b = np.linalg.norm(b)
    return dot_product / (norm_a * norm_b)

# Voorbeeld:
a = np.array([1, 2, 3])
b = np.array([4, -5, 6])
print(cosine_similarity(a, b))
```

## 6. Verifiëren van de eigenschappen van het inwendig product (commutativiteit en lineariteit in de tweede component) met NumPy

We willen de volgende eigenschappen van het inwendig product verifiëren

- **Commutativiteit**: \( \mathbf{a} \cdot \mathbf{b} = \mathbf{b} \cdot \mathbf{a} \)
- **Lineariteit in de tweede component**: \( \mathbf{a} \cdot (c_1 \mathbf{b}_1 + c_2 \mathbf{b}_2) = c_1 (\mathbf{a} \cdot \mathbf{b}_1) + c_2 (\mathbf{a} \cdot \mathbf{b}_2) \)

We gaan willekeurige vectoren genereren en de bovenstaande eigenschappen testen met NumPy.

### Python code voor verifiëren

```python
import numpy as np

# Willekeurige vectoren
a = np.random.rand(3)
b = np.random.rand(3)
c = np.random.rand(3)

# Commutativiteit
commutative_check = np.allclose(np.dot(a, b), np.dot(b, a))

# Lineariteit in de tweede component
c1 = 2
c2 = 3
linear_check = np.allclose(np.dot(a, c1*b + c2*c), c1*np.dot(a, b) + c2*np.dot(a, c))

# Resultaten
print("Commutativiteit (a . b == b . a):", commutative_check)
print("Lineariteit in de tweede component (a . (c1*b + c2*c) == c1*(a . b) + c2*(a . c)):", linear_check)
```

### Wat de code doet

1. **Commutativiteit**: We berekenen het inwendig product van \( \mathbf{a} \) en \( \mathbf{b} \), en van \( \mathbf{b} \) en \( \mathbf{a} \), en verifiëren of deze gelijk zijn.
2. **Lineariteit in de tweede component**: We controleren of \( \mathbf{a} \cdot (c_1 \mathbf{b} + c_2 \mathbf{c}) \) gelijk is aan \( c_1 (\mathbf{a} \cdot \mathbf{b}) + c_2 (\mathbf{a} \cdot \mathbf{c}) \).

### Verwachte output

Als alles klopt, zou de output `True` moeten zijn voor beide eigenschappen.

---

## 7. Veronderstelling: Orthogonale vectoren \( \mathbf{u} \) en \( \mathbf{v} \) in \( \mathbb{R}^n \) met lengte 1

We moeten aantonen dat als \( \mathbf{u} \) en \( \mathbf{v} \) orthogonaal zijn en beide lengte 1 hebben, dan de vectoren \( \mathbf{u} + \mathbf{v} \) en \( \mathbf{u} - \mathbf{v} \) orthogonaal zijn en hun lengte \( \sqrt{2} \) is.

### Stap 1: Orthogonaliteit van \( \mathbf{u} \) en \( \mathbf{v} \)

Twee vectoren zijn orthogonaal als hun inwendig product \( \mathbf{u} \cdot \mathbf{v} = 0 \).

### Stap 2: Bewijs dat \( (\mathbf{u} + \mathbf{v}) \cdot (\mathbf{u} - \mathbf{v}) = 0 \)

We berekenen het inwendig product van \( \mathbf{u} + \mathbf{v} \) en \( \mathbf{u} - \mathbf{v} \):

\[
(\mathbf{u} + \mathbf{v}) \cdot (\mathbf{u} - \mathbf{v}) = \mathbf{u} \cdot \mathbf{u} - \mathbf{u} \cdot \mathbf{v} + \mathbf{v} \cdot \mathbf{u} - \mathbf{v} \cdot \mathbf{v}
\]

Aangezien \( \mathbf{u} \cdot \mathbf{v} = 0 \) (orthogonaliteit) en \( \mathbf{u} \cdot \mathbf{u} = 1 \) en \( \mathbf{v} \cdot \mathbf{v} = 1 \) (omdat beide vectoren lengte 1 hebben), krijgen we:

\[
(\mathbf{u} + \mathbf{v}) \cdot (\mathbf{u} - \mathbf{v}) = 1 - 0 + 0 - 1 = 0
\]

Dus, \( \mathbf{u} + \mathbf{v} \) en \( \mathbf{u} - \mathbf{v} \) zijn orthogonaal.

### Stap 3: Bereken de lengtes van \( \mathbf{u} + \mathbf{v} \) en \( \mathbf{u} - \mathbf{v} \)

De lengte van \( \mathbf{u} + \mathbf{v} \) is:

\[
\|\mathbf{u} + \mathbf{v}\|^2 = (\mathbf{u} + \mathbf{v}) \cdot (\mathbf{u} + \mathbf{v}) = \mathbf{u} \cdot \mathbf{u} + 2 \mathbf{u} \cdot \mathbf{v} + \mathbf{v} \cdot \mathbf{v}
\]

Omdat \( \mathbf{u} \cdot \mathbf{v} = 0 \), krijgen we:

\[
\|\mathbf{u} + \mathbf{v}\|^2 = 1 + 0 + 1 = 2
\]

Dus \( \|\mathbf{u} + \mathbf{v}\| = \sqrt{2} \).

De lengte van \( \mathbf{u} - \mathbf{v} \) is gelijk:

$$
\|\mathbf{u} - \mathbf{v}\|^2 = (\mathbf{u} - \mathbf{v}) \cdot (\mathbf{u} - \mathbf{v}) = \mathbf{u} \cdot \mathbf{u} - 2 \mathbf{u} \cdot \mathbf{v} + \mathbf{v} \cdot \mathbf{v}
$$

Opnieuw, omdat \( \mathbf{u} \cdot \mathbf{v} = 0 \), krijgen we:
$$
\[
\|\mathbf{u} - \mathbf{v}\|^2 = 1 - 0 + 1 = 2
\]
$$
Dus  \( \|\mathbf{u} - \mathbf{v}\| = \sqrt{2} \).

### Conclusie voor probleem 7

- $ \( \mathbf{u} + \mathbf{v} \) en \( \mathbf{u} - \mathbf{v} \) $ zijn orthogonaal.
- De lengtes van \( \mathbf{u} + \mathbf{v} \) en \( \mathbf{u} - \mathbf{v} \) zijn beide \( \sqrt{2} \).

---
