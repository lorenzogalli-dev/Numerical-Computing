% Coefficients of the objective function (maximize 60x + 70y)
Z = [-60, -70];  % Note: linprog minimizes, so we use the negative coefficients

% Matrices for inequality constraints (25x + 40y <= 7000)
A_0 = [25, 40];  % Coefficients for the constraint 25x + 40y <= 7000
b_0 = 7000;       % Right-hand side for the constraint

% Matrices for equality constraint (x + y = 265)
A_1 = [1, 1];   % Coefficients for the constraint x + y = 265
b_1 = 265;      % Right-hand side for the equality

% Non-negativity constraints (x >= 0 and y >= 0)
lower_bound = [0, 0];    % x >= 0 and y >= 0

% Solve the linear programming problem using linprog
[x, fval, exitflag] = linprog(Z, A_0, b_0, A_1, b_1, lower_bound);

% Display the results
disp('Optimal Solution:');
disp(['x = ', num2str(x(1))]);
disp(['y = ', num2str(x(2))]);
disp(['Optimal Objective Value: ', num2str(-fval)]);

% --- Plotting Section ---
figure;
hold on;

% Plot the constraint 25x + 40y = 7000 (inequality as equality using fimplicit)
fimplicit(@(x, y) 25*x + 40*y - 7000, 'r', 'LineWidth', 2);

% Plot the constraint x + y = 265
fimplicit(@(x, y) x + y - 265, 'b', 'LineWidth', 2);

% Define the range for x values (from 0 to 265)
x_vals = linspace(0, 265, 265);

% Calculate the corresponding y values for both constraints
y1_vals = (7000 - 25 * x_vals) / 40;  % From the first constraint 25x + 40y = 7000
y2_vals = 265 - x_vals;  % From the second constraint x + y = 265

% Calculate the minimum y values to determine the feasible region
y_fill = zeros(size(x_vals));
for i = 1:length(x_vals)
    y_fill(i) = min(y1_vals(i), y2_vals(i));  % Take the min of both constraints at each x
end

% Fill the feasible region using the minimum y values
fill([x_vals, 0, 0], [y_fill, 0, 0], 'c', 'FaceAlpha', 0.3);

% Plot the optimal solution as a red dot
plot(x(1), x(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);

% --- Plot Interception Points ---
% Intersection with the X-axis for both constraints (y = 0)
x_intercept_1 = 7000 / 25;  % For 25x + 40y = 7000
x_intercept_2 = 265;        % For x + y = 265
plot(x_intercept_1, 0, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % Blue for x-intercept of 25x + 40y = 7000
plot(x_intercept_2, 0, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % Blue for x-intercept of x + y = 265

% Intersection with the Y-axis for both constraints (x = 0)
y_intercept_1 = 7000 / 40;  % For 25x + 40y = 7000
y_intercept_2 = 265;        % For x + y = 265
plot(0, y_intercept_1, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % Blue for y-intercept of 25x + 40y = 7000
plot(0, y_intercept_2, 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % Blue for y-intercept of x + y = 265

% Title and labels
title('Feasible Region and Optimal Solution');
xlabel('Number of type 1 trousers (x)');
ylabel('Number of type 2 trousers (y)');
legend('25x + 40y = 7000', 'x + y = 265', 'Feasible Region', 'Optimal Solution', 'Intercepts', 'Location', 'Best');

% Show grid
grid on;
hold off;