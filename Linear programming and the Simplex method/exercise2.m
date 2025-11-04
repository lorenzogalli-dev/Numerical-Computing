type = 'max';

% Right-hand side of constraints
h = [18; 32; 25; 17; 11830; 22552; 11209; 5870; 16; 32; 40; 28];

% Prices
prices = [135, 200, 410, 520];

% Objective coefficients modified by the factors
c = [];
factors = [1, 1.1, 1.2, 1.3];
for i=1:length(factors)
    c = [c; factors(1, i) * prices];
end
c = reshape(c, [], 1);
c = c';

% Constraints coefficients inizialization
A = zeros(12, 16);

% Compartment Weight Constraints
CWC = kron([1, 1, 1, 1], eye(4));
A(1:4, :) = CWC;

% Compartment Volume Constraints
CVC = kron([320 500 630 125], eye(4));
A(5:8, :) = CVC;

% Cargo Weight Constraints
A(9, 1:4) = 1;    % x11 + x21 + x31 + x41 <= 16
A(10, 5:8) = 1;   % x12 + x22 + x32 + x42 <= 32
A(11, 9:12) = 1;  % x13 + x23 + x33 + x43 <= 40
A(12, 13:16) = 1; % x14 + x24 + x34 + x44 <= 28

% If populated manually, the matrix A would be like this:

% A = [

     % Compartment Weight Constraints
%    1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0;  % x11 + x12 + x13 + x14 <= 18
%    0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0;  % x21 + x22 + x23 + x24 <= 32
%    0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0;  % x31 + x32 + x33 + x34 <= 25
%    0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1;  % x41 + x42 + x43 + x44 <= 17

     % Compartment Volume Constraints
%    320 500 630 125 0 0 0 0 0 0 0 0 0 0 0 0;  % 320x11 + 500x12 + 630x13 + 125x14 <= 11830
%    0 0 0 0 320 500 630 125 0 0 0 0 0 0 0 0;  % 320x21 + 500x22 + 630x23 + 125x24 <= 22552
%    0 0 0 0 0 0 0 0 320 500 630 125 0 0 0 0;  % 320x31 + 500x32 + 630x33 + 125x34 <= 11209
%    0 0 0 0 0 0 0 0 0 0 0 0 320 500 630 125;  % 320x41 + 500x42 + 630x43 + 125x44 <= 5870

     % Cargo Weight Constraints
%    1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0;  % x11 + x21 + x31 + x41 <= 16
%    0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0;  % x12 + x22 + x32 + x42 <= 32
%    0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0;  % x13 + x23 + x33 + x43 <= 40
%    0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1;  % x14 + x24 + x34 + x44 <= 28
% ];

% (Notice that in the matrix the element x11 correspond to x1, x21 to x2,
% x12 to x5, x13 to x9 and so on...)

% Indicates the direction of the inequalities in the constraints
% (the value -1 indicates that the constraints are of the form Ax <= b)
sign = -1 * ones(1, 12);

[z, x_B, index_B] = simplex(type, A, h, c, sign);