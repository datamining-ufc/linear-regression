function p = p_value(x, y)
% P_VALUE calculate the p-value between the vectors X and Y using
% the built-in ttest (Test of T-distribution).
% REF: https://www.mathworks.com/help/stats/ttest.html
    [~, p] = ttest2(x, y);
end
