% Degree centrality of karate.adj

A = dlmread('karate.adj');

r = sum(A, 2);
c = sum(A, 1);

x = diag(A);

degc = (c' + r - x) / 2;  % Divided by 2 because it's an undirected graph

[sortedDegC, sortedIdx] = sort(degc, 'descend');

disp('Node    Degree Centrality');
for i = 1:length(sortedDegC)
    fprintf('   %d          %d\n', sortedIdx(i), sortedDegC(i));
end

% Eigenvector centrality

[eigenVectors, eigenValues] = eig(A);

% Find the largest eigenvalue
eigenValues = diag(eigenValues); 
[~, maxIndex] = max(eigenValues); 

% Corresponding eigenvector
centrVec = eigenVectors(:, maxIndex);
normCentrality = centrVec / sum(centrVec);

% Step 5: Rank the nodes based on eigenvector centrality
[sortedCentrality, sortedIdx] = sort(normCentrality, 'descend');

% Display the top five nodes with their eigenvector centrality
disp('Top five nodes with largest eigenvector centrality:');
disp('Node   Eigenvector Centrality');
for i = 1:5
    fprintf('%d        %.4f\n', sortedIdx(i), sortedCentrality(i));
end


