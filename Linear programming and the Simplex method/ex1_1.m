% Coefficients of the objective function (minimize 4x + y)
c = [4, 1];

% Define the inequality constraint matrix and vector
A = [1, 2; -1, -1; -2, -3];
b = [40; -30; -72];

% Define lower bounds for variables (x >= 0, y >= 0)
lowerBounds = [0; 0];

% Solve the linear programming problem
options = optimoptions('linprog', 'Display', 'off');
[x, fval, exitflag] = linprog(c, A, b, [], [], lowerBounds, [], options);

% Display the optimal solution
disp('Optimal Solution:');
disp(['x = ', num2str(x(1))]);
disp(['y = ', num2str(x(2))]);
disp(['Optimal Objective Value: ', num2str(fval)]);

% Plot the feasible region
figure;
hold on;

% Plot the inequalities (constraints)
fimplicit(@(x, y) x + 2*y - 40, 'r', 'LineWidth', 2);  % x + 2y ≤ 40
fimplicit(@(x, y) x + y - 30, 'g', 'LineWidth', 2);   % x + y ≥ 30
fimplicit(@(x, y) 2*x + 3*y - 72, 'b', 'LineWidth', 2); % 2x + 3y ≥ 72

% Highlight the feasible region
x_vals = linspace(0, 36, 100);
y1_vals = (40 - x_vals) / 2; % From x + 2y ≤ 40
y2_vals = max(0, 30 - x_vals); % From x + y ≥ 30
y3_vals = max((72 - 2*x_vals) / 3, 0); % From 2x + 3y ≥ 72

% Determine the points for filling the feasible region
x_fill = [x(1), x_vals(100), x_vals(100), x(1)];
y_fill = [x(2), y1_vals(100), max(y2_vals(100), y3_vals(100)), x(2)];

% Fill the feasible region with color
fill(x_fill, y_fill, 'c', 'FaceAlpha', 0.3);

% Plot the optimal solution as a red dot
plot(x(1), x(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);

% --- Plot Interception Points ---
% Intersection with the X-axis for both constraints (y = 0)
x_intercept_1 = 40;  % For x + 2y = 40
x_intercept_2 = 30;  % For x + y = 30
x_intercept_3 = 36;  % For 2x + 3y = 72
plot(x_intercept_1, 0, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % x-intercept of x + 2y = 40
plot(x_intercept_2, 0, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % x-intercept of x + y = 30
plot(x_intercept_3, 0, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % x-intercept of 2x + 3y = 72

% Intersection with the Y-axis for both constraints (x = 0)
y_intercept_1 = 20;  % For x + 2y = 40
y_intercept_2 = 30;  % For x + y = 30
y_intercept_3 = 24;  % For 2x + 3y = 72
plot(0, y_intercept_1, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % y-intercept of x + 2y = 40
plot(0, y_intercept_2, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % y-intercept of x + y = 30
plot(0, y_intercept_3, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % y-intercept of 2x + 3y = 72

% Title and labels
title('Feasible Region and Optimal Solution');
xlabel('Number of x');
ylabel('Number of y');
legend('x + 2y = 40', 'x + y = 30', '2x + 3y = 72', 'Feasible Region', 'Optimal Solution', 'Intercepts', 'Location', 'Best');

% Show grid
grid on;
hold off;
