function DegreeCentrality(G)

c = sum(G,1);
r = sum(G,2);

% Finding the self loops
x = diag(G);

% c' (the transpose of c) converts the row vector c into a column vector so that it can be added to r.
degc = c' + r - x;

% Sort the degree centrality in descending order
[sortedDegc, sortedIdx] = sort(degc, 'descend');

% Display the sorted degree centralities and corresponding node indices
disp('Sorted degree centralities:');
disp(sortedDegc);
disp('Corresponding node indices:');
disp(sortedIdx);