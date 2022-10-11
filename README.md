# GraphTheoryMatrices
Graph Theory Matrices.

**Language: R**

**Start: 2019**

## Why
A collection of matrices that can be used to represent a graph. Useful while studying [Graph theory](https://en.wikipedia.org/wiki/Graph_theory).

## Example

Given this graph:

![Example](/images/example.jpg)

[Adjacency matrix](https://en.wikipedia.org/wiki/Adjacency_matrix):

```r
     [,1] [,2] [,3] [,4] [,5] [,6]
[1,]    0    1    1    1    1    0
[2,]    1    0    1    0    0    0
[3,]    1    1    0    0    0    0
[4,]    1    0    0    0    1    1
[5,]    1    0    0    1    0    0
[6,]    0    0    0    1    0    0
```

[Laplacian matrix](https://en.wikipedia.org/wiki/Laplacian_matrix):

```r
     [,1] [,2] [,3] [,4] [,5] [,6]
[1,]    4   -1   -1   -1   -1    0
[2,]   -1    2   -1    0    0    0
[3,]   -1   -1    2    0    0    0
[4,]   -1    0    0    3   -1   -1
[5,]   -1    0    0   -1    2    0
[6,]    0    0    0   -1    0    1
```

The _graph\_theory\_matrix.R_ contains many more matrices.