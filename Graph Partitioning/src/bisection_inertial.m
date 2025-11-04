function [part1,part2] = bisection_inertial(A,xy,picture)
% bisection_inertial: Inertial partition of a graph.
%
% [part1,part2] = bisection_inertial(A,xy,picture) returns a list of the vertices on one side of a partition
%     obtained by bisection with a line or plane normal to a moment of inertia
%     of the vertices, considered as points in Euclidean space.
%     Input A is the adjacency matrix of the mesh (used only for the picture!);
%     each row of xy is the coordinates of a point in d-space.
%
% bisection_inertial(A,xy,1) also draws a picture.



disp(' ');
disp(' Numerical Computing @ USI Lugano:   ');
disp(' Implement inertial bisection');
disp(' ');


% Steps

% 1. Calculate the center of mass (baricentro).
center_of_mass = mean(xy);


% 2. Construct the matrix M.
Mxx = 0;
Mxy = 0;
Myy = 0;
for i = 1 : length(xy)
    Mxx = Mxx + (xy(i,1) - center_of_mass(1))^2;
    Mxy = Mxy + (xy(i,1) - center_of_mass(1)) * (xy(i,2) - center_of_mass(2));
    Myy = Myy + (xy(i,2) - center_of_mass(2))^2;
end
M = [Mxx, Mxy; Mxy, Myy];


% 3. Calculate the smallest eigenvector of M.  
[eigenvector, eigenvalue] = eigs(M, 1, 'SA');


% 4. Find the line L on which the center of mass lies.
a = eigenvector(1);
b = eigenvector(2);
L = [-b, a];


% 5. Partition the points around the line L.
[part1, part2] = partition(xy, L);


if picture == 1
    gplotpart(A,xy,part1);
    title('Inertial bisection using the Fiedler Eigenvector');
end

end
