eigenvalues = eig(A_test);

minEig = min(abs(eigenvalues));
maxEig = max(abs(eigenvalues));
conditionNum = maxEig / minEig;

figure;
bar(1:length(eigenvalues), abs(eigenvalues));
set(gca, 'YScale', 'log');
xlabel('Index');
ylabel('EigenValues');
title('EigenValues of A-test matrix');

annotation('textbox', [0.15, 0.6, 0.1, 0.3], 'String', sprintf('Min Eigenvalue: %.4e\nMax Eigenvalue: %.4e\nCondition Number: %.4e', minEig, maxEig, conditionNum), 'FitBoxToText', 'on', 'EdgeColor', 'none');