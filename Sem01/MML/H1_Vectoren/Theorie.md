# Vector Perspectives

Vectors can be understood from three distinct viewpoints:

1. **Physical Perspective**: Vectors are arrows in space with **length and direction**[1]. For example, a displacement vector representing movement from one point to another.

2. **Computer Science Perspective**: Vectors are **ordered lists of numbers or one-dimensional arrays**[1]. An example would be a vector representing sensor readings: [23.5, 45.2, 67.1].

3. **Mathematical Perspective**: Vectors are **objects that can be added together and multiplied by scalars**[1]. For instance, you can scale a vector [2, 3] by 2 to get [4, 6].

## Key Vector Operations

### Vector Addition

- Defined by adding corresponding components[1]
- Example: $$[1, 2] + [3, -1] = [4, 1]$$
- Visualized as consecutive movements in a coordinate system

### Vector Scaling

- Multiplying a vector by a scalar changes its length and potentially direction[1]
- Examples:
  - 2 * $$[1, 2]$$ = $$[2, 4]$$
  - -1/3 * $$[1, 2]$$ = $$[-1/3, -2/3]$$

## Linear Concepts

### Linear Combinations

- A way to create new vectors by scaling and adding base vectors[1]
- Example: $$ 3[1, 0] + (-2) [0, 1] = [3, -2] $$
- Helps understand how vectors can span different spaces

### Linear Independence

- A set of vectors is linearly independent if the only way to get a zero vector is by setting all coefficients to zero[1]
- Example: Vectors [1, 1] and [2, 2] are **not** linearly independent, while [1, 1] and [1, 2] are

### Linear Subspaces

- A subset of vectors closed under vector addition and scalar multiplication[1]
- Examples:
  - The zero vector space
  - The entire $$\mathbb{R}^n$$ space
  - Subspaces defined by specific vector constraints

## Vector Properties

### Vector Length

- Calculated as the square root of the sum of squared components[1]
- $$\|[v_1, v_2, ..., v_n]\| = \sqrt{v_1^2 + v_2^2 + ... + v_n^2}$$

### Inner Product

- A way to compute the dot product of vectors[1]
- Defined as $$v \cdot w = v_1w_1 + v_2w_2 + ... + v_nw_n$$
- Reveals relationships between vectors like orthogonality

### Projection

- Finding the component of one vector along another[1]
- Useful in understanding vector relationships
- Calculated as $$\frac{a \cdot b}{a \cdot a}a$$

The document provides numerous mathematical insights and practical examples of working with vectors across different domains.
