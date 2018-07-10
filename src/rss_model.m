function e = rss_model(X, y)
% RSS_MODEL calculate the RSS error value of the linear regression model
    f = estimation_function(X, y);
    e = rss_error(y, f(X));
end