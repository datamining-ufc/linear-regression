function [B, b0] = linear_regression(X, y)
% LINEAR_REGRESSION calculates the B estimator vector
% for multiple linear regression which minimizes the error `e`
% in the equation `y ~ x*B + e`.
%
% VARIABLES:
%
%     X: a matrix in M x N form, where M, N > 1
%     Y: a column-vector with N elements
%     B: a column-vector with N elements
%     b0: the intercept-Y value
%
    [m, n] = size(X);
    X1 = X(:, :); % copy vector
    X1(:, n+1) = ones(m, 1); % add one-vector for y-intercept
    B = inv(X1'*X1)*X1'*y; % least-squares minimization error
    b0 = B(n+1);
    B = B(1:n);
end
