function B = linear_regression(X, y)
% LINEAR_REGRESSION calculates the B estimator vector
% for multiple linear regression which minimizes the error `e`
% in the equation `y ~ B*x + e`.
%
% VARIABLES:
%
%     X: a matrix in M x N form, where M, N > 1
%     Y: a column-vector with N elements
%     B: a column-vector with N elements
%
    B = inv(X'*X)*X'*y;
end
