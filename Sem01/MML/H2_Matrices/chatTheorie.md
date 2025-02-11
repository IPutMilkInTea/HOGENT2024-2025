# Mathematics for Machine Learning (MML) - Matrices and Transformations

## Table of Contents

1. **Matrices**
   - Linear Transformations and Matrix Product
   - Matrix-Vector Product
   - Composition of Linear Transformations
   - Matrix Multiplication
   - Matrix Transposition
   - Inner Product as Matrix Product
   - Matrix Operations and Properties
   - Inverse of a Matrix
   - Orthogonal Projection onto a Subspace
   - Exercises

---

## 1. Matrices

### Linear Transformations

- A transformation is a function that maps input vectors to output vectors.  
- In linear algebra, a transformation maps vectors to other vectors.  
- Example: A transformation \( L \) maps \( \begin{bmatrix} 5 \\ 7 \end{bmatrix} \) to \( \begin{bmatrix} 2 \\ 3 \end{bmatrix} \):  
  \[ L \left( \begin{bmatrix} 5 \\ 7 \end{bmatrix} \right) = \begin{bmatrix} 2 \\ 3 \end{bmatrix} \]  

**Linear Transformation Properties**:  

- \( L(v + w) = L(v) + L(w) \)  
- \( L(\alpha v) = \alpha L(v) \)  

### Example of Linear Combination under Transformation

If \( v = 5i + 7j \), the transformation of \( v \) can be computed as:  
\[ L(v) = 5L(i) + 7L(j) \]  
If \( L(i) = \begin{bmatrix} 1 \\ -2 \end{bmatrix} \) and \( L(j) = \begin{bmatrix} 3 \\ 0 \end{bmatrix} \), then:  
\[ L(v) = 5 \begin{bmatrix} 1 \\ -2 \end{bmatrix} + 7 \begin{bmatrix} 3 \\ 0 \end{bmatrix} = \begin{bmatrix} 26 \\ -10 \end{bmatrix} \]

---

## 2. Matrix-Vector Product

- The images of the basis vectors under \( L \) form the columns of a matrix.  
- For example:  
  \[ A = \begin{bmatrix} 1 & 3 \\ -2 & 0 \end{bmatrix} \]  
- The transformation of \( \begin{bmatrix} x \\ y \end{bmatrix} \) is:  
  \[ A \begin{bmatrix} x \\ y \end{bmatrix} = x \begin{bmatrix} 1 \\ -2 \end{bmatrix} + y \begin{bmatrix} 3 \\ 0 \end{bmatrix} = \begin{bmatrix} x + 3y \\ -2x \end{bmatrix} \]  

---

## 3. Composition of Linear Transformations

- Composition involves applying multiple transformations sequentially.  
- Example: Rotate by 90° and then shear:  
  \[ R = \begin{bmatrix} 0 & -1 \\ 1 & 0 \end{bmatrix}, \quad S = \begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix} \]  
- Applying rotation first:  
  \[ R \begin{bmatrix} x \\ y \end{bmatrix} = \begin{bmatrix} -y \\ x \end{bmatrix} \]  
- Then applying shear:  
  \[ S \begin{bmatrix} -y \\ x \end{bmatrix} = \begin{bmatrix} x - y \\ x \end{bmatrix} \]  

---

## 4. Matrix Multiplication

- Matrix multiplication represents composition of linear transformations.  
- If \( M_1 \) and \( M_2 \) are matrices representing transformations:  
  \[ M_2 M_1 \begin{bmatrix} x \\ y \end{bmatrix} = M_2 \left( M_1 \begin{bmatrix} x \\ y \end{bmatrix} \right) \]  
- Example:  
  \[ M_1 = \begin{bmatrix} 1 & -2 \\ 1 & 0 \end{bmatrix}, \quad M_2 = \begin{bmatrix} 0 & 2 \\ 1 & 0 \end{bmatrix} \]  
  \[ M_2 M_1 = \begin{bmatrix} -4 & 0 \\ 1 & 2 \end{bmatrix} \]  

---

## 5. Matrix Transposition

- The transpose of matrix \( A \) is denoted by \( A^T \).  
- Example:  

 $$
  \[ A = \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}, \quad A^T = \begin{bmatrix} 1 & 3 \\ 2 & 4 \end{bmatrix} \]  
 $$
---

## 6. Inner Product as Matrix Product

- Vectors can be written as single-column matrices.  
- Inner product:  
  \[ a \cdot b = a^T b \]  
  Example:  
  \[ a = \begin{bmatrix} 1 \\ 0 \\ 1 \end{bmatrix}, \quad b = \begin{bmatrix} 2 \\ -1 \\ 1 \end{bmatrix} \]  
  \[ a^T b = [1 \ 0 \ 1] \begin{bmatrix} 2 \\ -1 \\ 1 \end{bmatrix} = 3 \]  

---

## 7. Inverse of a Matrix

- A matrix \( A \) is invertible if there exists \( B \) such that \( AB = I \).  
- Example (2x2 matrix):  
  \[ A = \begin{bmatrix} a & b \\ c & d \end{bmatrix}, \quad A^{-1} = \frac{1}{ad - bc} \begin{bmatrix} d & -b \\ -c & a \end{bmatrix} \]  

---

## 8. Orthogonal Projection

- Project vector \( b \) onto the span of \( a_1, a_2, \dots, a_m \):  
  \[ P = A (A^T A)^{-1} A^T \]  
- Example: Project onto span of \( \begin{bmatrix} 1 \\ 2 \end{bmatrix}, \begin{bmatrix} 1 \\ 1 \end{bmatrix} \).

---

## 9. Exercises

- Compute matrix products.  
- Implement projections and inverses using NumPy.  
- Verify properties like associativity and distributivity.
