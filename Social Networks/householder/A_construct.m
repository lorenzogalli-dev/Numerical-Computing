function [A, nz] = A_construct(n)
    % Construct matrix A for any given n
    A = zeros(n, n);

    % Fill the diagonal entries
    for i = 1:n
        A(i,i) = n + i - 1;
    end

    % Fill the off-diagonal entries
    for i = 1:n
        for j = 1:n
            if i ~= j && (i == 1 || i == n || j == 1 || j == n)
                A(i,j) = 1;
            end
        end
    end

    % Calculate the number of non-zero elements
    nz = 5*n - 6;

    % Display the matrix and number of non-zero elements
    disp(A);
    fprintf('Number of non-zero elements (nz): %d\n', nz);
end
