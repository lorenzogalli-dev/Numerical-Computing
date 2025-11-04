A = dlmread('karate.adj');

% Laplacian matrix
deg = sum(A);
L = diag(deg) - A;

% Eigenvalues and eigenvectors
[V, D] = eigs(L, 2, 'SA');  % Two smallest eigenvalues

% Fiedler vector (second eigenvector)
fiedler_vector = V(:, 2);

[~, indices] = sort(fiedler_vector);

group1 = indices(1:18);
group2 = indices(19:34);

disp('Group 1 nodes:');
disp(group1);
disp('Group 2 nodes:');
disp(group2);

% Fiedler vector partitioning
figure;
plot(fiedler_vector, '.-');
title('Fiedler Vector');
xlabel('Node Index');
ylabel('Fiedler Vector Value');
grid on;

% Adjacency matrix with the sorted order of nodes
[~, p] = sort(fiedler_vector);
spy(A(p, p));
title('Adjacency Matrix after Spectral Bisection');
