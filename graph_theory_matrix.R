library(igraph)
library(expm)
library(matrixcalc)

getAk <- function(A, D, k) {
  I = diag(nrow(D))
  Q = D - diag(nrow(D))
  A2 = A %*% A
  if (k == 1) {
    A
  } else if (k == 2) {
    A2 - (Q + I)
  } else {
    Ak_1 = A2 - (Q + I)
    Ak_2 = A
    i = 2
    Ai = NULL
    while (i < k) {
      Ai = Ak_1 %*% A - Ak_2 %*% Q
      i = i + 1
      Ak_2 = Ak_1
      Ak_1 = Ai
    }
    Ai
  }
}

# https://www.sci.unich.it/~francesc/teaching/network/eigenvector.html
eigenvector.centrality = function(g, t) {
  A = get.adjacency(g);
  n = vcount(g);
  x0 = rep(0, n);
  x1 = rep(1/n, n);
  eps = 1/10^t;
  iter = 0;
  while (sum(abs(x0 - x1)) > eps) {
    x0 = x1;
    x1 = as.vector(x1 %*% A);
    m = x1[which.max(abs(x1))];
    x1 = x1 / m;
    iter = iter + 1;
  } 
  return(list(vector = x1, value = m, iter = iter))
} 

#g1 <- graph( edges=c(1,2, 2,3), n=3, directed=F )                         # /\
#g1 <- graph( edges=c(1,2, 2,3, 3,1), n=3, directed=F )                    # triangle
#g1 <- graph( edges=c(1,2, 2,3, 3,1, 1,4), n=4, directed=F )               # triangle + line
#g1 <- graph( edges=c(1,2, 2,3, 3,1, 1,4, 1,5), n=5, directed=F )          # traingle + /\
#g1 <- graph( edges=c(1,2, 2,3, 3,1, 1,4, 1,5, 4,5), n=5, directed=F ) 
g1 <- graph( edges=c(1,2, 2,3, 3,1, 1,4, 1,5, 4,5, 4,6), n=6, directed=F ) 
plot(g1)

eigenvector.centrality(g1, 5)
A = as.matrix(as_adjacency_matrix(g1)) # Adjacency matrix
C = A %*% t(A) # cocitation matrix (directed graph)
B = t(A) %*% A # bibliographic coupling matrix (directed graph) - c_ij = # of vertices with edges pointing to both nodes i and j
L = as.matrix(laplacian_matrix(g1)) # Laplacian matrix
M = as.matrix(as_incidence_matrix(g1, )) # Incidence matrix
D = L + A # Degree matrix
Lrw = solve(D) %*% L # https://en.wikipedia.org/wiki/Laplacian_matrix#Random_walk_normalized_Laplacian
Lsym = (D %^% (-0.5)) %*% L %*% (D %^% (-0.5)) # https://en.wikipedia.org/wiki/Laplacian_matrix#Symmetrically_normalized_Laplacian
I = diag(nrow(D))
J = matrix(1, nrow(D), nrow(D))
Q = D - I
Q_2 = D + A # definition from "Spectra of graphs": signless Laplace matrix
S = J - I - 2 * A # Siegel adjacency matrix
Lsn = (D %^% 0.5) %*% L %*% (D %^% 0.5)
Lrn = matrix.power(D, -1) %*% L
A2 = A %^% 2
A3 = A %^% 3
A4 = A %^% 4

# getAk does not include backtracking, it allows to pass through the same vertex and edge more than once!
# Therefore, it counts paths e not just simple-paths
# (Zeta Functions of Finite Graphs and Coverings - Stark and Terras, 1996)
getAk(A, D, 2)
getAk(A, D, 4)

plot(graph_from_adjacency_matrix (kronecker(A, A)))
