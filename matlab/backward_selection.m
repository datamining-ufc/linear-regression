function vars = backward_selection(T, y)
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
% 4. Continue until all remaining variables have a p-value below
% 0.05, a fixed significance threshold
%
% VARIABLES:
%
%     X: a table in M x N form, where M, N > 1
%     Y: a column-vector with N elements
%     VARS: table of variables by column choosed

    p_value_threshold = 0.05;
    stack_vars = T.Properties.VariableNames(:); % vector of variable names
    
    while max_p_value(T{:, stack_vars}, y) > p_value_threshold
       n = length(stack_vars);
       worst_var = 1;
       p_value_max = -inf;
       for i = 1:n
           var_name = stack_vars(i);
           p = p_value(T{:, var_name}, y);
           if p > p_value_max
              p_value_max = p;
              worst_var = i;
           end
       end
       
       stack_vars(worst_var) = []; % remove worst_var
    end
    
    vars = T(:, stack_vars);
end

function p = max_p_value(X, y)
    [~, n] = size(X);
    p_values = ones(n);
    for i = 1:n
        p_values = p_value(X(:, i), y);
    end
    p = max(p_values);
end
