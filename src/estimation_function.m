function f = estimation_function(X, y)
% ESTIMATION_FUNCTION Generate a function that estimates y given X.
% It works by calcuating the B coefficient using LINEAR_REGRESSION
    B = linear_regression(X, y);
    f = @(x) x*B;
end

