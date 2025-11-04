
load('housegraph.mat');

pairs = {'Golub', 'Moler'; 'Golub', 'Saunders'; 'TChan', 'Demmel'};

if ischar(name)
    name = cellstr(name);
end

for i = 1:size(pairs, 1)
    
    author1 = pairs{i, 1};
    author2 = pairs{i, 2};

    author1_idx = find(strcmp(name, author1));
    author2_idx = find(strcmp(name, author2));

    coauthor_v1 = A(author1_idx, :);
    coauthor_v2 = A(author2_idx, :);

    common_coauthors = coauthor_v1 .* coauthor_v2;
    common_coauthor_idx = find(common_coauthors);

    if isempty(common_coauthor_idx)
        fprintf('No common coauthors between %s and %s.\n', author1, author2);
    else
        fprintf('Common coauthors of %s and %s: ', author1, author2);
        disp(name(common_coauthor_idx)');
    end
end
