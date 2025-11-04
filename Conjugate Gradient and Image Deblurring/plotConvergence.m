% Load the test sets
load('test_data/A_test.mat', 'A_test');
load('test_data/b_test.mat', 'b_test');

[m, n] = size(A_test);
x0 = zeros(n, 1);
max_itr = 200;
tol = 1e-4;

% Solving using my Conjugate Gradient method
[x, rvec] = myCG(A_test, b_test, x0, max_itr, tol);

% Plot the convergence
figure;
plot(rvec);
xlabel('Iterations');
ylabel('Residual Values');
set(gca, 'YScale', 'log');
title('Conjugate Gradient Method Convergence');