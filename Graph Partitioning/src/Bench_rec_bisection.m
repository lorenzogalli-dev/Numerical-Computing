% Benchmark for recursively partitioning meshes, based on various
% bisection approaches
%
% D.P & O.S for Numerical Computing at USI

% add necessary paths
addpaths_GP;
nlevels_a = 3;
nlevels_b = 4;

fprintf('       *********************************************\n')
fprintf('       ***  Recursive graph bisection benchmark  ***\n');
fprintf('       *********************************************\n')

% load cases
cases = {
     'mesh1e1.mat',
     'bodyy4.mat',
     'de2010.mat',
     'biplane-9.mat',
     'L-9.mat',
    };

nc = length(cases);
maxlen = 0;
for c = 1:nc
    if length(cases{c}) > maxlen
        maxlen = length(cases{c});
    end
end

for c = 1:nc
    fprintf('.');
    sparse_matrices(c) = load(cases{c});
end


fprintf('\n\n Report Cases         Nodes     Edges\n');
fprintf(repmat('-', 1, 40));
fprintf('\n');
for c = 1:nc
    spacers  = repmat('.', 1, maxlen+3-length(cases{c}));
    [params] = Initialize_case(sparse_matrices(c));
    fprintf('%s %s %10d %10d\n', cases{c}, spacers,params.numberOfVertices,params.numberOfEdges);
end

%% Create results table
fprintf('\n%7s %16s %20s %16s %16s\n','Bisection','Spectral','Metis 5.0.2','Coordinate','Inertial');
fprintf('%10s %10d %6d %10d %6d %10d %6d %10d %6d\n','Partitions',8,16,8,16,8,16,8,16);
fprintf(repmat('-', 1, 100));
fprintf('\n');


for c = 1:nc
    spacers = repmat('.', 1, maxlen+3-length(cases{c}));
    fprintf('%s %s', cases{c}, spacers);
    sparse_matrix = load(cases{c});
    

    % Recursively bisect the loaded graphs in 8 and 16 subgraphs.
    % Steps
    % 1. Initialize the problem
    [params] = Initialize_case(sparse_matrices(c));
    W      = params.Adj;
    coords = params.coords;

    % 2. Recursive routines

    % i. Spectral, p = 8
    [map_spectral8, sepij1, sepA1] = rec_bisection(@bisection_spectral, nlevels_a, W, coords, 1);
    % i. Spectral, p = 16
    [map_spectral16, sepij2, sepA2] = rec_bisection(@bisection_spectral, nlevels_b, W, coords, 1);

    % ii. Metis, p = 8
    [map_metis8, sepij3, sepA3] = rec_bisection(@bisection_metis, nlevels_a, W, coords, 1);
    % ii. Metis, p = 16
    [map_metis16, sepij4, sepA4] = rec_bisection(@bisection_metis, nlevels_b, W, coords, 1);

    % iii. Coordinate, p = 8
    [map_coordinate8, sepij5, sepA5] = rec_bisection(@bisection_coordinate, nlevels_a, W, coords, 1);
    % iii. Coordinate, p = 16
    [map_coordinate16, sepij6, sepA6] = rec_bisection(@bisection_coordinate, nlevels_b, W, coords, 1);

    % iv. Inertial, p = 8
    [map_inertial8, sepij7, sepA7] = rec_bisection(@bisection_inertial, nlevels_a, W, coords, 1);
    % iv. Inertial, p = 8
    [map_inertial16, sepij8, sepA8] = rec_bisection(@bisection_inertial, nlevels_b, W, coords, 1);


    % 3. Calculate number of cut edges

    % p = 8
    [spectral8, ~]   =  cutsize(W, map_spectral8);
    [metis8, ~]      =  cutsize(W, map_metis8);
    [coordinate8, ~] =  cutsize(W, map_coordinate8);
    [inertial8, ~]   =  cutsize(W, map_inertial8);

    % p = 16
    [spectral16, ~]   = cutsize(W, map_spectral16);
    [metis16, ~]      = cutsize(W, map_metis16);
    [coordinate16, ~] = cutsize(W, map_coordinate16);
    [inertial16, ~]   = cutsize(W, map_inertial16);

    % 4. Visualize the partitioning result
    
    disp('Coordinate bisection with p = 8:');
    gplotmap(W, coords, map_coordinate8);
    title('Coordinate bisection p = 8');
    pause;
    
    disp('Coordinate bisection with p = 16:');
    gplotmap(W, coords, map_coordinate16);
    title('Coordinate bisection p = 16');
    pause;
    
    disp('Metis bisection with p = 8:');
    gplotmap(W, coords, map_metis8);
    title('Metis bisection p = 8');
    pause;
    
    disp('Metis bisection with p = 16:');
    gplotmap(W, coords, map_metis16);
    title('Metis bisection p = 16');
    pause;
    
    disp('Spectral bisection with p = 8:');
    gplotmap(W, coords, map_spectral8);
    title('Spectral bisection p = 8');
    pause;

    disp('Spectral bisection with p = 16:');
    gplotmap(W, coords, map_spectral16);
    title('Spectral bisection p = 16');
    pause;

    disp('Inertial bisection with p = 8:');
    gplotmap(W, coords, map_inertial8);
    title('Inertial bisection p = 8');
    pause;
    
    disp('Inertial bisection with p = 16:');
    gplotmap(W, coords, map_inertial16);
    title('Inertial bisection p = 16');
    pause;
    
    %fprintf('%6d %6d %10d %6d %10d %6d %10d %6d\n', spectral8, spectral16, ...
    %metis8, metis16, coordinate8, coordinate16, inertial8, inertial16);
    
end