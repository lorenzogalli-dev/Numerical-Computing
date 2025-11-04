function [part1,part2] = bisection_spectral(A,xy,picture)
% bisection_spectral: Spectral partition of a graph.
%
% [part1,part2] = bisection_spectral(A) returns a partition of the n vertices
%                 of A into two lists part1 and part2 according to the
%                 spectral bisection algorithm of Simon et al:  
%                 Label the vertices with the components of the Fiedler vector
%                 (the second eigenvector of the Laplacian matrix) and partition
%                 them around the median value or 0.
% 
% bisection_spectral(A,xy,1) also draws a picture.


disp(' ');
disp(' Numerical Computing @ USI Lugano:   ');
disp(' Implement inertial bisection');
disp(' ');


% Steps

% 1. Construct the Laplacian matrix L = D - A.
G = graph(A,'omitselfloops');
L = laplacian(G);
    
% 2. Calculate the second smallest eigenvalue of L.
[V, ~] = eigs(L, 2, 'SM'); 
    
% 3. Label the vertices with the components of the Fiedler vector.
fiedler_vector = V(:,2);

% 4. Partition them around their median value, or 0 (sign).
median_value = median(fiedler_vector);    
part1 = find(fiedler_vector < median_value);
part2 = find(fiedler_vector >= median_value);

if picture == 1
    gplotpart(A,xy,part1);
    title('Spectral bisection using the Fiedler Eigenvector');
end

end
