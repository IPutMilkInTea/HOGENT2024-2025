# Mathematics for Machine Learning (MML)

## Table of Contents

1. **Linear Algebra**  
    - Vectors  
    - Matrices  
    - Systems of Linear Equations  
    - Orthogonal Matrices  
    - Singular Value Decomposition  
2. **Analysis**  
    - Real Functions of One Variable  
    - Real Functions of Multiple Variables  

---

## 1. Vectors

### Introduction to Vectors

Vectors can be viewed from different perspectives:  

- **Physics**: Vectors are arrows in space with a magnitude and direction.  
- **Computer Science**: Vectors are ordered lists of numbers or one-dimensional arrays.  
- **Mathematics**: Vectors are objects that can be added together and scaled by numbers.

**Example**:
A vector in physics might represent force or velocity, while in computer science, it could represent features of a data point.

### Vector Addition

The sum of two vectors is obtained by adding their corresponding components.

**Definition**:  
If \( v = \begin{bmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{bmatrix} \) and \( w = \begin{bmatrix} w_1 \\ w_2 \\ \vdots \\ w_n \end{bmatrix} \), then:  
\[
v + w = \begin{bmatrix} v_1 + w_1 \\ v_2 + w_2 \\ \vdots \\ v_n + w_n \end{bmatrix}  
\]

**Example**:  
\[
\begin{bmatrix} 1 \\ 2 \end{bmatrix} + \begin{bmatrix} 3 \\ -1 \end{bmatrix} = \begin{bmatrix} 4 \\ 1 \end{bmatrix}  
\]

### Scalar Multiplication

Multiplying a vector by a scalar scales each component by that scalar.

**Definition**:  
For \( \alpha \in \mathbb{R} \) and \( v = \begin{bmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{bmatrix} \),  
\[
\alpha v = \begin{bmatrix} \alpha v_1 \\ \alpha v_2 \\ \vdots \\ \alpha v_n \end{bmatrix}  
\]

**Example**:  
\[
2 \begin{bmatrix} 1 \\ -3 \end{bmatrix} = \begin{bmatrix} 2 \\ -6 \end{bmatrix}  
\]

### Linear Combinations

A vector can be expressed as a linear combination of other vectors.

**Example**:  
\[
3 \begin{bmatrix} 1 \\ 0 \end{bmatrix} + (-2) \begin{bmatrix} 0 \\ 1 \end{bmatrix} = \begin{bmatrix} 3 \\ -2 \end{bmatrix}  
\]

This means that the basis vectors \( i = \begin{bmatrix} 1 \\ 0 \end{bmatrix} \) and \( j = \begin{bmatrix} 0 \\ 1 \end{bmatrix} \) span the plane.

### Linear Independence and Span

- **Span**: The set of all linear combinations of a set of vectors.  
- **Linear Independence**: A set of vectors is linearly independent if the only solution to the equation \( \alpha_1 v_1 + \alpha_2 v_2 + \dots + \alpha_m v_m = 0 \) is \( \alpha_1 = \alpha_2 = \dots = \alpha_m = 0 \).

**Example**:  
Vectors \( v_1 = \begin{bmatrix} 1 \\ 2 \end{bmatrix} \) and \( v_2 = \begin{bmatrix} 3 \\ -1 \end{bmatrix} \) can span \( \mathbb{R}^2 \), but vectors \( a = \begin{bmatrix} 1 \\ 2 \end{bmatrix} \) and \( b = \begin{bmatrix} -2 \\ -4 \end{bmatrix} \) are linearly dependent.

### Subspaces

A **linear subspace** is a set of vectors closed under addition and scalar multiplication.

**Example**:  
The set of vectors \( \begin{bmatrix} \alpha \\ 2\alpha \end{bmatrix} \) for \( \alpha \in \mathbb{R} \) forms a subspace of \( \mathbb{R}^2 \).

---

## 2. Length of a Vector

The length (or norm) of a vector is defined as:
\[
\|v\| = \sqrt{v_1^2 + v_2^2 + \dots + v_n^2}  
\]

**Example**:  
\[
\| \begin{bmatrix} 3 \\ 4 \end{bmatrix} \| = \sqrt{3^2 + 4^2} = 5  
\]

---

## 3. Orthogonal Vectors

Vectors are orthogonal if their dot product is zero:
\[
v \cdot w = v_1 w_1 + v_2 w_2 + \dots + v_n w_n = 0  
\]

**Example**:  
\[
\begin{bmatrix} 1 \\ 2 \end{bmatrix} \cdot \begin{bmatrix} -2 \\ 1 \end{bmatrix} = 1(-2) + 2(1) = 0  
\]

---

## 4. Inner Product

The dot product (inner product) can also be expressed using the cosine of the angle between two vectors:
\[
v \cdot w = \|v\| \|w\| \cos(\theta)  
\]

---

## 5. Projection onto a Vector

The projection of \( b \) onto \( a \) is given by:
\[
proj_a(b) = \frac{a \cdot b}{a \cdot a} a  
\]

**Example**:  
\[
proj_{\begin{bmatrix} 1 \\ 0 \end{bmatrix}} \begin{bmatrix} 3 \\ 4 \end{bmatrix} = \begin{bmatrix} 3 \\ 0 \end{bmatrix}  
\]

---

## 6. Exercises

1. Identify linearly independent sets of vectors.  
2. Calculate projections of vectors.  
3. Implement cosine similarity in Python using NumPy.

**Python Example**:

```python
import numpy as np

def cosine_similarity(v, w):
    return np.dot(v, w) / (np.linalg.norm(v) * np.linalg.norm(w))

v = np.array([1, 2])
w = np.array([3, -1])
print(cosine_similarity(v, w))
```

