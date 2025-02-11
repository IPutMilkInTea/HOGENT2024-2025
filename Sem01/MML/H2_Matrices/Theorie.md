# Matrices and Linear Transformations

Matrices represent linear transformations, which preserve straight lines and scaling properties. Examples include:

- Rotation by 90° counterclockwise: R = [0 -1; 1 0]
- Shear transformation: S = [1 1; 0 1]

## Matrix Operations

### Matrix-Vector Product

Represents applying a linear transformation to a vector:
[a b; c d] [x; y] = [ax + by; cx + dy]

### Matrix Multiplication

Represents the composition of linear transformations:
[a b; c d] [e f; g h] = [ae+bg af+bh; ce+dg cf+dh]

### Transpose

Swaps rows and columns of a matrix. Symmetric matrices remain unchanged when transposed:
A = [5 1; 1 2] is symmetric because A^T = A

### Inner Product as Matrix Product

Can be expressed as: a · b = a^T b

## Matrix Properties

### Inverse Matrix

For a 2x2 matrix A = [a b; c d], its inverse (if it exists) is:
A^(-1) = 1/(ad-bc) [d -b; -c a]

### Orthogonal Projection

The projection matrix for projecting onto the subspace spanned by columns of A is:
P = A(A^T A)^(-1)A^T

### Matrix Rank

Determines invertibility of square matrices. A square matrix is invertible if and only if its rank equals its dimension.

## Additional Concepts

- Identity matrix
- Associative and distributive properties of matrix operations
- Interaction between matrix multiplication and transposition
