# (PART) The General Linear Model {-}

# The Mean as a Model {#lm-mean}

*This chapter has not been written yet.*

The tests in Parts I and II are all versions of one model: the general linear model. This part rebuilds them with `lm()`, starting with the simplest model there is: one number for everyone. You write `my_sse()`, the sum of squared errors around a proposed centre, and plot it for a range of centres. The lowest point is at the mean, which links back to the squared distances in Chapter \@ref(equations). `lm(y ~ 1)` fits this model: its intercept is the mean, and its t-value is the one-sample t from Chapter \@ref(t-statistic).
