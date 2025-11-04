% Testing ex2c, which calls the function A_construct(n) with n=10
% and compare the number of non-zero calculated both with matlab function
% and manually with the formula 5n-6.

n = 10;
[A, nz] = A_construct(n);

disp('The matrix A is:');
disp(A);

fprintf('Number of non-zero elements: %d\n', nz);

expected_nz = 5*n - 6;
fprintf('Expected number of non-zero elements: %d\n', expected_nz);

% Compare the results
if nz == expected_nz
    fprintf('The result matches the expected value.\n');
else
    fprintf('The result does not match the expected value.\n');
end

% Perform Cholesky factorization on A
R = chol(A);

figure;
subplot(1, 2, 1);
spy(A);
title('Sparsity Pattern of Matrix A');

subplot(1, 2, 2);
spy(R);
title('Sparsity Pattern of Cholesky Factor R');

fprintf('Number of non-zero elements in A: %d\n', nz);
fprintf('Number of non-zero elements in Cholesky factor R: %d\n', nnz(R));