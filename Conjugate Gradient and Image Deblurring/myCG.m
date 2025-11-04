function [x, rvec] = myCG(A, b, x0, max_itr, tol)
    rvec = []; % Store the residual norms at each iteration, used to compare with tolerance
    x = x0; % Initial solution guess
    r = b - A * x; % Initial residual (how close x is to the solution) 
    d = r; % Search direction
    p_old = dot(r, r); % Previous residual norm

    % Conjugate Gradient iteration
    for itr = 1:max_itr
        % Compute matrix-vector product
        s = A * d;

        % Update solution
        alpha = p_old / dot(d, s); % The step size, to minimize the error along the search direction
        x = x + alpha * d;

        % Update residual
        r = r - alpha * s;

        % Update squared residual norm
        p_new = dot(r, r);

        % Update conjugate direction
        beta = p_new / p_old;
        d = r + beta * d;

        % Update previous squared residual norm
        p_old = p_new;

        % Store squared residual norms for analysis
        rvec = [rvec, p_new];

        % Check convergence
        if sqrt(p_new) <= tol
            disp('Converged');
            break;
        end
    end
end