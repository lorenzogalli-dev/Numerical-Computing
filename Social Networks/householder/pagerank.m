function [x, iterations] = pagerank(name, G, p)
% PAGERANK1 Google's PageRank using the Power Method
% pagerank1(U,G,p) uses the URLs and adjacency matrix produced by SURFER,
% together with a damping factor p (default is .85), to compute and plot
% a bar graph of page rank, and print the dominant URLs in page rank order.
% x = pagerank1(U,G,p) returns the page ranks using the Power Method.
% See also SURFER, SPY.
if (nargin < 3)
    p = .85;
end

if ischar(name)
    name = cellstr(name);
end

% c = out-degree, r = in-degree
[~,n] = size(G);
c = sum(G,1);
r = sum(G,2);

% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);

% Transforms the raw adjacency matrix into a stochastic matrix that
% represents the probability of moving from one page to another when
% following a random link.
G = p * G * D;

% Initialize the PageRank vector e, let's use a vector of all ones
e = ones(n,1);
x = e/n;

% z accounts for dangling nodes (columns in G with no outgoing links)
% the z expression, for non-dangling nodes (pages with outgoing links), it ensures that they contribute a factor of (1 − p) to the teleportation step.
% For dangling nodes (pages with no outgoing links), it ensures that their PageRank contribution is redistributed evenly through all pages in the network.
% The whole expression is divided by n to spread the contribution evenly among all pages.
z = ((1-p)*(c~=0) + (c==0))/n;

% Set tolerance for convergence
% The number 1e−6 is a good choice that helps to ensure convergence of the PageRank algorithm with a good balance of accuracy and efficiency. This value allows the iterative method to stop once the changes in the PageRank vector become sufficiently small. 
tol = 1e-6;

% ---------------------------------- POWER METHOD -------------------------

disp('Using the Power Method implementation for PageRank calculation');

% Initialize the previous PageRank vector for comparison
previous_x = zeros(n,1);
iterations = 0;

% While loop for the power method iteration
while norm(x - previous_x, 2) > tol
    previous_x = x;  % Update the old vector
    x = G * x + e * (z * previous_x);  % Power iteration update
    iterations = iterations + 1;
end

fprintf('Number of iterations: %d\n', iterations);

% Normalize so that sum(x) == 1.
x = x / sum(x);

% Sort the PageRank values in descending order
[sortedRank, order] = sort(x, 'descend');

% Bar graph of page rank.
figure;
bar(sortedRank);
title('Page Rank of Authors');
xlabel('Authors');
ylabel('Page Rank');
xticks(1:n);
xticklabels(name(order));  % Label x-ticks with sorted author names
xtickangle(45);  % Rotate x-tick labels for better visibility

% Output the sorted ranks and their corresponding authors
disp('Authors ranked by PageRank:');
for i = 1:length(sortedRank)
    fprintf('%s: %f\n', name{order(i)}, sortedRank(i));  % Ensure U is treated as a cell array
end
end

