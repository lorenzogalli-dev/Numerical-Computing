function [cut_recursive,cut_kway] = Bench_metis(picture)
% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.
%
% D.P & O.S for Numerical Computing at USI


% Add necessary paths
addpaths_GP;

% Graphs in question
% load 'helicopter.mat' ;
% load 'skirt.mat';

% Steps

% 1. Initialize the cases
helicopter = load('helicopter.mat') ;
skirt = load('skirt.mat') ;

helicopter_adj = helicopter.Problem.A;
helicopter_coord = helicopter.Problem.aux.coord;

skirt_adj = skirt.Problem.A;
skirt_coord = skirt.Problem.aux.coord;



% 2.a Call metismex to Recursively partition the graphs in 16 and 32 subsets.

% Helicopter
[helicopter_rec_16, helicopter_rec_cut_16] = metismex('PartGraphRecursive', helicopter_adj, 16);
[helicopter_rec_32, helicopter_rec_cut_32] = metismex('PartGraphRecursive', helicopter_adj, 32);

% Skirt
[skirt_rec_16, skirt_rec_cut_16] = metismex('PartGraphRecursive', skirt_adj, 16);
[skirt_rec_32, skirt_rec_cut_32] = metismex('PartGraphRecursive', skirt_adj, 32);



% 2.b Call metismex to Perform direct k-way partitioning of the graphs in 16 and 32 subsets.

% Helicopter
[helicopter_kway_16, helicopter_kway_cut_16] = metismex('PartGraphKWay', helicopter_adj, 16);
[helicopter_kway_32, helicopter_kway_cut_32] = metismex('PartGraphKWay', helicopter_adj, 32);

% Skirt
[skirt_kway_16, skirt_kway_cut_16] = metismex('PartGraphKWay', skirt_adj, 16);
[skirt_kway_32, skirt_kway_cut_32] = metismex('PartGraphKWay', skirt_adj, 32);



% 3. Visualize the results for 32 partitions

% Recursive
disp('Helicopter Recursive p = 16 ...');
gplotmap(helicopter_adj, helicopter_coord, helicopter_rec_16);
title('Helicopter Recursive p = 16');
rotate3d on;
pause;

disp('Helicopter Recursive p = 32 ...');
gplotmap(helicopter_adj, helicopter_coord, helicopter_rec_32);
title('Helicopter Recursive p = 32');
rotate3d on;
pause;

disp('Skirt Recursive p = 16 ...');
gplotmap(skirt_adj, skirt_coord, skirt_rec_16);
title('Skirt Recursive p = 16');
rotate3d on;
pause;

disp('Skirt Recursive p = 32 ...');
gplotmap(skirt_adj, skirt_coord, skirt_rec_32);
title('Skirt Recursive p = 32');
rotate3d on;
pause;

% k-way
disp('Helicopter k-way p = 16 ...');
gplotmap(helicopter_adj, helicopter_coord, helicopter_kway_16);
title('Helicopter k-way p = 16');
rotate3d on;
pause;

disp('Helicopter k-way p = 32 ...');
gplotmap(helicopter_adj, helicopter_coord, helicopter_kway_32);
title('Helicopter k-way p = 32');
rotate3d on;
pause;

disp('Skirt k-way p = 16 ...');
gplotmap(skirt_adj, skirt_coord, skirt_kway_16);
title('Skirt k-way p = 16');
rotate3d on;
pause;

disp('Skirt k-way p = 32 ...');
gplotmap(skirt_adj, skirt_coord, skirt_kway_32);
title('Skirt k-way p = 32');
rotate3d on;
pause;

end
