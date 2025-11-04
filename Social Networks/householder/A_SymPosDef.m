load ('A_SymPosDef.mat')

%spy(A_SymPosDef)

format short
sparsity = nnz(A_SymPosDef)/prod(size(A_SymPosDef))

%drawit;
%snapnow

r = symrcm(A_SymPosDef(2:end,2:end));
prcm = [1 r+1];

%spy(A_SymPosDef(prcm,prcm))

%drawitrcm;
%snapnow

% Compute the Cholesky factor of the original matrix
L = chol(A_SymPosDef, 'lower');
spy(L);

% Compute the Cholesky factor of the permuted matrix
L_permuted = chol(A_SymPosDef(prcm, prcm), 'lower');
spy(L_permuted);

% Calculate and display the sparsity of Cholesky factors
sparsity_L = nnz(L) / prod(size(L))
sparsity_L_permuted = nnz(L_permuted) / prod(size(L_permuted))