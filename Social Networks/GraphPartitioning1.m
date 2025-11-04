A = dlmread('karate.adj');

x = randperm(34);
group1 = x(1:16);
group2 = x(17:end);

p_group1 = 0.5;
p_group2 = 0.4;
p_between = 0.1;

A(group1, group1) = rand(16,16) < p_group1;
A(group2, group2) = rand(18,18) < p_group2;
A(group1, group2) = rand(16, 18) < p_between;

disp('Group 1 nodes:');
disp(group1);
disp('Group 2 nodes:');
disp(group2);

spy(A);

A = triu(A,1);
A = A + A';
deg = sum(A);
L = diag(deg)-A;
[V, D] = eigs(L, 2, 'SA');
D(2,2)

plot(V(:,2), '.-');
plot(sort(V(:,2)), '.-');
[ignore p] = sort(V(:,2));
spy(A(p,p));