# Two-Sample t-Tests {#two-sample-t}

*This chapter has not been written yet.*

Two kinds of two-sample t-test, built from the functions you already have. The paired t-test, where each person is measured twice, turns out to be a one-sample t-test on the differences, so `my_t_value()` does the work. The independent t-test compares two separate groups, using the pooled standard deviation, with Welch's version as a variation for unequal variances. Real data: the two sleeping drugs in `sleep` (paired), and two species in `iris` (independent).
