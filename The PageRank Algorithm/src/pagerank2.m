function [x, iterations] = pagerank2(U, G, p)
% PAGERANK2 Google's PageRank using Inverse Iteration
% pagerank2(U,G,p) uses the URLs and adjacency matrix produced by SURFER,
% together with a damping factor p (default is .85), to compute and plot
% a bar graph of page rank, and print the dominant URLs in page rank order.
% x = pagerank2(U,G,p) returns the page ranks using Inverse Iteration.
% See also SURFER, SPY.
if nargin < 3, p = .85; end

% Eliminate any self-referential links
%G = G - diag(diag(G));

% c = out-degree, r = in-degree
[~,n] = size(G);
c = sum(G,1);
r = sum(G,2);


% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);

z = ((1-p)*(c~=0) + (c==0))/n;

% Initialize the PageRank vector e and x, and the matrix A
e = ones(n,1);
x = e/n;

A = p*G*D + e*z;

% Define alpha as the inverse of the damping factor
alpha = 0.99;
I = speye(n,n);

% Set tolerance for convergence
tol = 1e-6;
max_iter = 1000;

% ---------------------------------- INVERSE ITERATION --------------------

disp('Using Inverse Iteration implementation for PageRank calculation');

% Initial settings
previous_x = zeros(n,1);
iterations = 0;

while norm(x - previous_x, 2) > tol && iterations < max_iter
    % Update the old vector
    previous_x = x;                     
    % Solve the linear system
    x = (alpha * I - A) \ previous_x;
    % Normalize the PageRank vector
    x = abs((x/norm(x,1)));
    iterations = iterations + 1;
end

fprintf('Number of iterations: %d\n', iterations);

% -------------------------------------------------------------------------

% Normalize so that sum(x) == 1.
x = x/sum(x);

% Bar graph of page rank.
shg
bar(x)
title('Page Rank')

% Print URLs in page rank order.
if nargout < 1
    [~, q] = sort(-x);
    disp('     page-rank  in  out  url')
    k = 1;
    maxN = length(U);
    while (k <= maxN) && (x(q(k)) >= .005)
        disp(k)
        j = q(k);
        temp1 = r(j);
        temp2 = c(j);
        fprintf(' %3.0f %8.4f %4.0f %4.0f  %s\n', j, x(j), full(temp1), full(temp2), U{j});
        k = k + 1;
    end
end