# Demystifying Functions For Statistics

This is Sean's working PsyTeachR-style mini-book for teaching R functions and statistics together.

## Render

From this folder, run:

```r
install.packages(c("bookdown", "webexercises"))
bookdown::render_book("index.Rmd", "bookdown::bs4_book")
```

The rendered HTML will be written to `docs/`.

## Structure

- `01-functions.Rmd`: functions as input-process-output machines.
- `02-equations.Rmd`: translating equations, summation, and variance into R.
- `03-standard-error.Rmd`: building small generic statistic functions from reusable pieces.
- `04-t-statistic.Rmd`: connecting summary functions to a t-statistic and the NHST simulation app.
- `05-correlation.Rmd`: paired deviations, covariance, correlation, and the correlation t-test.
- `apps/correlation/embed.html`: browser widget embedded in Chapter 5; no Shiny server required.
- `apps/mean-variance`: small Shiny widget for visualising how the mean and standard deviation change a distribution.

## Style

The book uses local copies of the PsyTeachR include files in `include/`, matching the Data Skills and Analysis books: `psyteachr.css`, `webex.css`, `style.css`, `header.html`, `webex.js`, and `script.js`.

## Interactive Widgets

To run the mean and variance widget from this folder:

```r
install.packages(c("shiny", "ggplot2"))
shiny::runApp("apps/mean-variance")
```

To run the NHST simulation app from this folder:

```r
shiny::runApp("../nhst-simulation")
```

Do not edit `../../psytr/` while developing this book; use those folders only as style and curriculum references.
