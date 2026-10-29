# Correlation as a Linear Model {#lm-correlation}

*This chapter has not been written yet.*

A straight line through the practice and score data from Chapter \@ref(correlation). You extend `my_sse()` to `my_sse(intercept, slope)`, the error for any line, and take on the regression widget's challenge: find the line with the smallest error you can, submit it, and compare it with the best line. The bottom of the error curve matches the conversion equations, slope = `my_covariance(x, y) / my_var(x)` and intercept = `mean(y) - slope * mean(x)`, checked against `lm()`. The slope's t-value equals the correlation t from Chapter \@ref(correlation), and R-squared is r squared. A bonus section walks down the error curve with gradient descent, written as a short loop, and with `optim()`, and checks both against `lm()`.
