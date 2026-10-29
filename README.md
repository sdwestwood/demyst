# Demystifying Functions For Statistics

This is Sean's working PsyTeachR-style mini-book for teaching R functions and statistics together.

## Render

From this folder, run:

```r
install.packages(c("bookdown", "webexercises", "tidyverse", "pwr"))
bookdown::render_book("index.Rmd", "bookdown::bs4_book")
```

The rendered HTML will be written to `docs/`.

## Structure

The book has two core parts, followed by two later parts that are still being written. The chapter order is set in `_bookdown.yml`. Files are named by part and position: `1a` to `1i` are Part I, `2a` and `2b` are Part II, and so on. A new chapter takes the next letter in its part, and the order in `_bookdown.yml` decides where it appears. Chapter numbers in the rendered book run straight through (1, 2, 3, ...). Chapters refer to each other with bookdown cross-references (`\@ref(id)`), so the numbers update themselves.

Part I: Building Test Statistics

- `1a-functions.Rmd` (`#functions`): what functions are: input, process, output.
- `1b-equations.Rmd` (`#equations`): from equations to code; `my_mean()` and `my_var()`; the `my_functions.R` toolbox.
- `1c-standard-error.Rmd` (`#standard-error`): standard deviation, standard error, `my_summary()`, and z-scores; the sampling widget.
- `1d-t-statistic.Rmd` (`#t-statistic`): a one-sample t-statistic built from earlier functions.
- `1e-two-sample-t.Rmd` (`#two-sample-t`): paired and independent t-tests (description only so far).
- `1f-correlation.Rmd` (`#correlation`): covariance and correlation, turned into a t-value.
- `1g-one-way-anova.Rmd` (`#one-way-anova`), `1h-factorial-anova.Rmd` (`#factorial-anova`), `1i-chi-square.Rmd` (`#chi-square`): description only so far.

Part II: Testing by Simulation

- `2a-null-distributions.Rmd` (`#null-distributions`): a null world of heights ("are people called Steve taller than average?"), simulated null distributions of means and t-values, cutoffs by sorting, choosing alpha, and why a rare result is not enough on its own. Descriptive only: no probabilities yet.
- `2b-p-values.Rmd` (`#p-values`): from shares to probabilities, alpha and Type I error, simulated and exact p-values, real data; bonus correlation section.
- `2c-effects-power.Rmd` (`#effects-power`): two worlds in heights (Steves really are 5 cm taller), counting what passes the cutoffs, Type II error and power, then `my_effect_t()`, `my_power()` and `my_cohens_d()`. APES, a priori and sensitivity power, one-sided tests, real data and the correlation bonus are parked in `parked/effects-power-extras.Rmd`.

Later parts (description only so far):

- Part III, The General Linear Model: `3a-lm-mean.Rmd` (`#lm-mean`), `3b-lm-correlation.Rmd` (`#lm-correlation`), `3c-lm-t-test.Rmd` (`#lm-t-test`), `3d-lm-one-way-anova.Rmd` (`#lm-one-way-anova`).
- Part IV, Non-Parametric Tests: `4a-wilcoxon-signed-rank.Rmd`, `4b-mann-whitney.Rmd`, `4c-spearman.Rmd`, `4d-kruskal-wallis.Rmd`, `4e-friedman.Rmd`.

`parked/` holds chapter descriptions that are not in the book at the moment (generalised linear models, multilevel models, checking assumptions, and multiple predictors). They are not listed in `_bookdown.yml`, so they are not rendered. `parked/README.md` says why.

Supporting files:

- `exercises/`: one exercise file per chapter (from "From Equations to Code"), plus the `my_functions.R` template, organised under the same chapter headings. Copied into `docs/exercises/` on render.
- `R/functions.R`: reference versions of every function students build, under the same headings. Chapters from "Spread and Standard Error" onwards load it.
- `_common.R`: shared setup for every chapter; also copies the exercises and widgets into `docs/`.

## Widgets

Each widget is a self-contained HTML file with no server needed, embedded with an `<iframe>`. Edit the files in `apps/`, not the copies in `docs/apps/`.

- `apps/mean-variance/embed.html`: mean and variance of a normal distribution. `app.R` in the same folder is an older Shiny version.
- `apps/sampling/embed.html`: building a distribution of sample means one sample at a time. `?style=steve&mean=175&sd=7&n=10&xmin=150&xmax=200&unit=cm&xlabel=Height%20(cm)` gives the three-panel heights version used in Null Distributions.
- `apps/t-steps/embed.html`: one group, one t-value, worked out step by step, with the t-values added to a histogram (Null Distributions).
- `apps/rareness/embed.html`: 1000 null t-values with the rarest chosen share highlighted in orange (Null Distributions).
- `apps/nhst/embed.html`: samples to t-values to null and true-effect t distributions, with cutoffs, counts, and power (Part II). `?mode=null` shows the null-only version. `null`, `sd` and `unit` set the null population, for example `?mode=null&n=10&null=175&sd=7&unit=cm` for the heights in p-values; without them it uses the 0 to 100 score scale.
- `apps/correlation/embed.html`: covariance and correlation.
- `apps/regression/embed.html`: find the line with the smallest sum of squared errors, then compare it with the least-squares line; residual squares, an error-by-slope panel, and gradient descent (for Correlation as a Linear Model; not embedded yet). `?challenge=0` unlocks everything for lectures.

## Style

The book uses local copies of the PsyTeachR include files in `include/`, matching the Data Skills and Analysis books: `psyteachr.css`, `webex.css`, `style.css`, `header.html`, `webex.js`, and `script.js`.

## Shiny Versions

The book uses the browser widgets above. The older Shiny versions can still be run from this folder:

```r
install.packages(c("shiny", "ggplot2"))
shiny::runApp("apps/mean-variance")
shiny::runApp("../nhst-simulation")
```

Do not edit `../../psytr/` while developing this book; use those folders only as style and curriculum references.
