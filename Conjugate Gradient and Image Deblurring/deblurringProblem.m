% Load and vectorize blurred image (B --> b)
load('blur_data/B.mat', 'B');
img = B;
n = size(img, 1);
b = B(:);

% Load transformation matrix A and initialize parameters
load('blur_data/A.mat', 'A');
initGuess = ones(size(b));
max_itr = 200;
tol = 1e-6;
alpha = 0.01;

% Incomplete Cholesky preconditioner options
options.type = 'nofill';
options.diagcomp = alpha;

% Normal equations and incomplete Cholesky preconditioner
tilde_A = transpose(A) * A;
tilde_B = transpose(A) * b;
L = ichol(tilde_A, options);
P = transpose(L) * L;

% Solving the linear system using custom CG
[x_myCG, rvec_myCG] = myCG(A, b, initGuess, max_itr, tol);

% Solving the preconditioned linear system using in-built PCG
[x_pcg, ~, ~, iter, rvec_pcg] = pcg(tilde_A, tilde_B, tol, max_itr);

% Display the original blurred image
figure;
imagesc(reshape(img, [n, n]));
colormap gray;
title('Original Blurred Image');
axis image;

% Display the deblurred image using custom CG
figure;
imagesc(reshape(x_myCG, [n, n]));
colormap gray;
title('Deblurred Image using Custom CG');
axis image;

% Display the deblurred image using in-built PCG
figure;
imagesc(reshape(x_pcg, [n, n]));
colormap gray;
title('Deblurred Image using In-built PCG');
axis image;

% Display the convergence plot for custom CG
figure;
semilogy(rvec_myCG);
title('Custom CG Convergence Test');
xlabel('Iterations');
ylabel('Residual');

% Display the convergence plot for in-built PCG
figure;
semilogy(rvec_pcg);
title('In-built PCG Convergence Test');
xlabel('Iterations');
ylabel('Residual');