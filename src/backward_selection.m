function vars = backward_selection(X, y)
% BACKWARD_SELECTION implements a algorithm for variable
% selection to the task of multiple linear regression in the
% following:
%
% ALGORITHM:
%
% 1. Start with all variables in the model
% 2. Remove the variable with the largest p-value - that is, the
% variable is the least statistically significant
% 3. The new (p - 1)-variable model is fit, and the variable with
% the largest p-value is removed.
% 4. Continue until all remaining variables have a p-value above 
% 0.05, a fixed significance threshold
%
% VARIABLES:
%
%     X: a table in M x N form, where M, N > 1
%     Y: a column-vector with N elements
%     VARS: table of variables by column choosed
end
