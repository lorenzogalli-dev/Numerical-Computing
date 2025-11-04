% Define the range for x1
x1 = linspace(0, 5, 100); % x1 values from 0 to 5

% Define the equations for each constraint
x2_1 = (12 - 4*x1) / 3; % From 4x1 + 3x2 <= 12
x2_2 = 8 - 4*x1;        % From 4x1 + x2 <= 8
x2_3 = (8 - 4*x1) / 2;  % From 4x1 + 2x2 <= 8

% Plot the constraints
figure;
hold on;
plot(x1, x2_1, 'r', 'LineWidth', 2); % Plot first constraint (4x1 + 3x2 <= 12)
plot(x1, x2_2, 'g', 'LineWidth', 2); % Plot second constraint (4x1 + x2 <= 8)
plot(x1, x2_3, 'b', 'LineWidth', 2); % Plot third constraint (4x1 + 2x2 <= 8)

% Fill the feasible region under the blue line (area under 4x1 + 2x2 <= 8)
fill([x1, fliplr(x1)], [x2_3, zeros(size(x1))], [0.678, 0.847, 0.902], 'FaceAlpha', 0.5);  

% Plot the black dots for (2,0) and (0,4)
plot(2, 0, 'ko', 'MarkerFaceColor', 'k'); % Point (2,0)
plot(0, 4, 'ko', 'MarkerFaceColor', 'k'); % Point (0,4)

% Add labels to the points (2,0) and (0,4)
text(2, 0, '  (2,0)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 12);
text(0, 4, '  (0,4)', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'FontSize', 12);

% Add labels and legends
xlabel('x_1');
ylabel('x_2');
legend('4x_1 + 3x_2 \leq 12', '4x_1 + x_2 \leq 8', '4x_1 + 2x_2 \leq 8', 'Location', 'Best');

% Set axis limits to make sure all constraints are visible
axis([0 5 0 5]);
grid on;
hold off;