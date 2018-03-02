function [u, A, b, freenodes] = fem_for_poisson_1d_ex3(c4n, n4e, ...
    n4db, n4nb, ind4e, M_R, S_R, f, u_D, u_N)
%fem_for_poisson_1d_ex3    FEM solver for Poisson problem in 1D
%   fem_for_poisson_1d_ex3(c4n,n4e,n4db,n4nb,ind4e,M_R,S_R,f,u_D,u_N) 
%   solves the Poisson problem. In order to use this code, mesh information
%   (c4n, n4e, n4db, ind4e), matrices (M_R, S_R), the source f, and the 
%   boundary condition u_D. Then the results of this code are the numerical
%   solution u, the global stiffness matrix A, the global load vector b and
%   the freenodes.
%
%   Parameters:
%     - c4n : coordinates for All nodes.
%     - n4e : nodes for elements.
%     - n4db : nodes for Dirichlet boundary.
%     - n4nb : nodes for Neumann boundary.
%     - ind4e : index for elements
%     - M_R : Mass matrix on the reference interval
%     - S_R : Stiffness matrix on the reference interval
%     - f : RHS in the Poisson problem
%     - u_D : Dirichlet boundary condition for the solution u
%     - u_N : Neumann boundary condition for the solution u
%
%   Returns:
%     - u : numerical solution
%     - A : Global stiffness matrix
%     - b : Global right-hand side
%     - freenodes : free nodes

number_of_nodes = size(c4n,1);
A = sparse(number_of_nodes, number_of_nodes);
b = zeros(number_of_nodes, 1);
u = b;
for j = 1:size(n4e,1)
    J = (c4n(n4e(j,2)) - c4n(n4e(j,1)))/2;
    A(ind4e(j,:), ind4e(j,:)) = A(ind4e(j,:), ind4e(j,:)) + S_R/J;
    b(ind4e(j,:)) = b(ind4e(j,:)) + J*M_R*f(c4n(ind4e(j,:)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: Add a few lines to treat Neumann boundary condition.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freenodes = setdiff(1:number_of_nodes, n4db);
u(n4db) = u_D(c4n(n4db));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: Add a few lines to treat non-homogeneous Dirichlet boundary
% condition. If you finished Exercise 2, the following lines can be copied
% from fem_for_poisson_1d_ex2.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

u(freenodes) = A(freenodes,freenodes)\b(freenodes);
end