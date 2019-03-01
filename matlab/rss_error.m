function e = rss_error(y, y_estimated)
% RSS calculate the Residual Sum of Squares (RSS)
% based on y value and the y_estimated, both vector-column
% of length N.
% REF: https://www.mathworks.com/help/matlab/ref/sum.html
    e = sum((y - y_estimated).^2, 1);
end
