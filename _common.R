options(width = 80)

suppressPackageStartupMessages({
  library(tidyverse)
})

knitr::opts_chunk$set(
  results = "hold",
  message = FALSE,
  warning = FALSE
)

set.seed(123)

if (requireNamespace("webexercises", quietly = TRUE)) {
  library(webexercises)

  knitr::knit_hooks$set(webex.hide = function(before, options, envir) {
    if (before) {
      if (is.character(options$webex.hide)) {
        hide(options$webex.hide)
      } else {
        hide()
      }
    } else {
      unhide()
    }
  })
} else {
  fitb <- function(answer, width = "10em", ...) {
    paste0(
      "<input type=\"text\" disabled=\"disabled\" ",
      "placeholder=\"answer\" style=\"width:", width, ";\">"
    )
  }

  mcq <- function(answer, ...) {
    choices <- as.character(answer)
    options <- paste0("<option>", choices, "</option>", collapse = "")
    paste0("<select disabled=\"disabled\"><option></option>", options, "</select>")
  }

  hide <- function(button_text = "Solution") {
    paste0("<details><summary>", button_text, "</summary>")
  }

  unhide <- function() {
    "</details>"
  }
}

demo_scores <- tibble(
  participant = 1:8,
  condition = c("practice", "practice", "practice", "practice",
                "test", "test", "test", "test"),
  score = c(48, 51, 49, 54, 52, 50, 53, 51)
)

score_values <- pull(demo_scores, score)

dir.create(file.path("docs", "exercises"), recursive = TRUE, showWarnings = FALSE)
file.copy(
  list.files("exercises", full.names = TRUE),
  file.path("docs", "exercises"),
  overwrite = TRUE
)

widgets <- c("mean-variance", "sampling", "nhst", "correlation", "regression",
             "t-steps", "rareness")
for (widget in widgets) {
  widget_dir <- file.path("apps", widget)
  output_dir <- file.path("docs", widget_dir)
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  file.copy(
    file.path(widget_dir, "embed.html"),
    file.path(output_dir, "embed.html"),
    overwrite = TRUE
  )
}
