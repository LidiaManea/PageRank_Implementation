  PageRank is an algorithm used to rank web pages depending on their importance. It is based on links from the certain page to other sites, "neighboring nodes".
  The algorithm will be implemented in two ways:
1) iterative
2) algebraic

 The iterative method:
  It is based on the recurrence relation between previous-step PR and current-step PR. The information is proccessed after it is loaded: the adjacency matrix is made, keeping in mind the links from one page towards itself. Initially, at the moment(step) 0, PR is a vector which contains only 1/(number of nodes). From the recurrence relation, the vectors will be learned and at every step, the error is also calculated; the algorithm stops when norm of PR(t + 1) - PR(t) is lower than epsilon, where epsilon is given (by the user).

 The algebrain methos:
  It is based on the mathematical properties of adjaency matrix. Because the relations between the number of nodes and the number of pages are independent, the problem can be reduced at solving a system Ax = x, where A is the adjaency matrix and x is the vector of solutions PR. One of the eigenvalues of A is 1 because it is column-stochastic (the demonstration is based on the idea that A and transpose(A) have the same eigenvalues). So for solving the system, there will exist a value m which balances the A matrix and the matrix full of ones. Usually, m is 0.15 . The equation x = (1 - m)Ax + ms will be solved, where 1 - m = d is a column-vector full of ones and x is PR.
  For solving the equation, B = I - dA is orthonormalized using Gram-Schmidt and it will be calculated its inverse with a triunghiular superior system. The x vector, PR, becomes inv(B) * ((1 - d) / N) * e, there e is the column-vector full of ones.
