function DegreeCentrality(A)

    load('housegraph.mat');

    c = sum(A, 1);
    r = sum(A, 2);

    x = diag(A);

    degc = c' + r - x;

    [sortedDegc, sortedIdx] = sort(full(degc), 'descend');

    nAuthors = 5;
    disp('Top 5 Authors by Degree Centrality:');
    
    for i = 1:nAuthors
        authorIndex = sortedIdx(i);
        authorCentrality = sortedDegc(i);
        
        coauthorIndex = find(A(authorIndex, :) > 0);
        
        fprintf('Author %d (Centrality: %d) Coauthors: ', authorIndex, authorCentrality);
        fprintf('%d ', full(coauthorIndex));
        fprintf('\n');
    end
end

