function vars = forward_selection(X, y)
% BACKWARD_SELECTION implements a algorithm for variable
% selection to the task of multiple linear regression in the
% following:
%
% ALGORITHM:
%
% 1. Begin with the null model - a model that contains an intercept
% but no predictors
% 2. Fit p simple linear regressions and add to the null model
% the variable that results in the lowest RSS.
% 3. Add to that model the variable that results in the lowest
% RSS amongst all two-variables models.
% 4. Continue until when all remaining variables have a p-value
% above 0.05.
%
% VARIABLES:
%
%     X: a table in M x N form, where M, N > 1
%     Y: a column-vector with N elements
%     VARS: table of variables by column choosed



end
