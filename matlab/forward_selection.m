function vars = forward_selection(T, y)
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
%     T: a table in M x N form, where M, N > 1
%     Y: a column-vector with N elements
%     VARS: table of variables by column choosed
    
    p_value_max = 0.05;
    stack_vars = T.Properties.VariableNames(:); % vector of variable names
    selected_vars = {}; % vector of cells
    selected_idx = 1;
    rss_min = +inf;
    
    while (length(stack_vars)) > 0
       n = length(stack_vars);
       best_var = 1;
       rss_min_iter = rss_min; % rss_min of the iteration
       for i = 1:n
           vars = selected_vars(:);
           vars_length = length(vars);
           vars(vars_length+1) = stack_vars(i);
           X_model = T{:, vars};
           rss_value = rss_model(X_model, y);
           if (rss_value < rss_min_iter)
                rss_min_iter = rss_value;
                best_var = i;
           end
       end
       
       % if p_value of the min_rss value selected is less than 0.05
       % add to the selected_vars
       var_name = stack_vars(best_var);
       if (p_value(T{:, var_name}, y) <= p_value_max) && (rss_min_iter < rss_min)
            selected_vars(selected_idx) = var_name;
            selected_idx = selected_idx + 1;
            rss_min = rss_min_iter;
       end
       % remove variable from stack 
       stack_vars(best_var) = []; 
    end
    
    vars = T(:, selected_vars);
end
