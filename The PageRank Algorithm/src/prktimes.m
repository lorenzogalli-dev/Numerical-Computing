U = cell(1500, 1);

% Initialize arrays for benchmark sizes, time and iterations for each method
benchmarks = 250:250:1500;  % The benchmark sizes
pagerank_times = zeros(1, length(benchmarks));
pagerank1_times = zeros(1, length(benchmarks));
pagerank2_times = zeros(1, length(benchmarks));
pagerank_iters = zeros(1, length(benchmarks));
pagerank1_iters = zeros(1, length(benchmarks));
pagerank2_iters = zeros(1, length(benchmarks));

% Loading files
for i = 1:length(benchmarks)
    benchmark_filename = sprintf('./benchmark/Benchmark_%d.mat', benchmarks(i));
    load(benchmark_filename);

    % Backslash Division Method
    tic;
    [x, iterations] = pagerank(U, R);
    pagerank_times(i) = toc;
    pagerank_iters(i) = iterations;

    % Power Method
    tic;
    [x, iterations] = pagerank1(U, R);  
    pagerank1_times(i) = toc;
    pagerank1_iters(i) = iterations;

    % Inverse Iteration Method
    tic;
    [x, iterations] = pagerank2(U, R);
    pagerank2_times(i) = toc;
    pagerank2_iters(i) = iterations;
end

% Plotting Time Performance on Linear and Logarithmic Scales
figure;

% Linear Scale
subplot(1, 2, 1);
plot(benchmarks, pagerank_times, '-o', 'DisplayName', 'Backslash Division');
hold on;
plot(benchmarks, pagerank1_times, '-o', 'DisplayName', 'Power Method');
plot(benchmarks, pagerank2_times, '-o', 'DisplayName', 'Inverse Iteration');
xlabel('Benchmarks');
ylabel('Time (seconds)');
title('Time Performance (Linear Scale)');
legend show;
grid on;

% Logarithmic Scale
subplot(1, 2, 2);
semilogy(benchmarks, pagerank_times, '-o', 'DisplayName', 'Backslash Division');
hold on;
semilogy(benchmarks, pagerank1_times, '-o', 'DisplayName', 'Power Method');
semilogy(benchmarks, pagerank2_times, '-o', 'DisplayName', 'Inverse Iteration');
xlabel('Benchmarks');
ylabel('Time (seconds)');
title('Time Performance (Logarithmic Scale)');
legend show;
grid on;

% Number of Iterations for each method
figure;
plot(benchmarks, pagerank_iters, '-o', 'DisplayName', 'Backslash Division');
hold on;
plot(benchmarks, pagerank1_iters, '-o', 'DisplayName', 'Power Method Iterations');
plot(benchmarks, pagerank2_iters, '-o', 'DisplayName', 'Inverse Iteration Iterations');
xlabel('Benchmarks');
ylabel('Number of Iterations');
title('Convergence Iterations');
legend show;
grid on;

