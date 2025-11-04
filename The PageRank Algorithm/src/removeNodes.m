load('WIKI450_ISO.mat')

n = [3, 10, 7, 12, 5];

for i = 1:length(n)
    G(n(i), :) = 0;  % Remove all outgoing edges from node n(i)
    G(:, n(i)) = 0;  % Remove all incoming edges to node n(i)
end

spy(G);