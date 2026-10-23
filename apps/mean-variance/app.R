library(shiny)
library(ggplot2)

plot_x_limits <- c(-15, 15)
plot_y_limits <- c(-0.35, 0.9)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body { color: #243447; }
      .well { background-color: #eef5fb; border-color: #d8e4ef; }
      .btn { background-color: #467AAC; color: white; border: 0; }
    "))
  ),
  titlePanel("Mean And Variance In A Normal Distribution"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("mean", "Mean", min = -5, max = 5, value = 0, step = 0.1),
      sliderInput("variance", "Variance", min = 0.25, max = 9, value = 1, step = 0.25),
      sliderInput("n", "Sample size", min = 10, max = 300, value = 80, step = 10),
      checkboxGroupInput(
        "layers",
        "Show",
        choices = c(
          "Sample dots" = "dots",
          "Lines to the mean" = "lines",
          "Bell curve" = "curve"
        ),
        selected = c("dots", "lines", "curve")
      ),
      numericInput("seed", "Seed", value = 123, min = 1, step = 1),
      actionButton("new_sample", "Draw new sample"),
      tags$hr(),
      tags$p("Standard deviation is the square root of variance."),
      verbatimTextOutput("sd_text")
    ),
    mainPanel(
      plotOutput("distribution_plot", height = "520px"),
      tableOutput("summary_table")
    )
  )
)

server <- function(input, output, session) {
  sample_values <- reactiveVal(NULL)

  selected_sd <- reactive({
    sqrt(input$variance)
  })

  draw_sample <- function() {
    set.seed(input$seed + input$new_sample)
    sample_values(rnorm(input$n, mean = input$mean, sd = selected_sd()))
  }

  observeEvent(input$new_sample, {
    draw_sample()
  })

  observeEvent(list(input$mean, input$variance, input$n, input$seed), {
    draw_sample()
  }, ignoreInit = FALSE)

  output$sd_text <- renderText({
    paste0("SD = sqrt(", input$variance, ") = ", round(selected_sd(), 3))
  })

  output$distribution_plot <- renderPlot({
    sd <- selected_sd()
    x_min <- plot_x_limits[1]
    x_max <- plot_x_limits[2]
    x <- seq(x_min, x_max, length.out = 500)

    density_data <- data.frame(
      value = x,
      density = dnorm(x, mean = input$mean, sd = sd)
    )

    max_density <- max(density_data$density)
    values <- sample_values()

    sample_data <- NULL
    if (!is.null(values)) {
      set.seed(input$seed + input$new_sample + 10000)
      sample_data <- data.frame(
        value = values,
        dot_y = -runif(
          length(values),
          min = 0.05,
          max = 0.3
        )
      )
    }

    show_dots <- "dots" %in% input$layers
    show_lines <- "lines" %in% input$layers
    show_curve <- "curve" %in% input$layers

    y_min <- if (show_dots || show_lines) plot_y_limits[1] else 0
    y_max <- plot_y_limits[2]

    p <- ggplot() +
      geom_hline(yintercept = 0, colour = "grey75") +
      geom_vline(xintercept = input$mean, colour = "#D55E00", linewidth = 1.1) +
      labs(
        x = "Value",
        y = NULL,
        title = "Mean and variance as layers",
        subtitle = paste0(
          "Orange line = mean; variance = ",
          input$variance,
          "; SD = ",
          round(sd, 3)
        )
      ) +
      scale_y_continuous(NULL, breaks = NULL) +
      scale_x_continuous(breaks = seq(plot_x_limits[1], plot_x_limits[2], by = 5)) +
      coord_cartesian(xlim = c(x_min, x_max), ylim = c(y_min, y_max)) +
      theme_minimal(base_size = 14)

    if (show_curve) {
      p <- p +
        geom_area(
          data = density_data,
          aes(x = value, y = density),
          fill = "#467AAC",
          alpha = 0.22
        ) +
        geom_line(
          data = density_data,
          aes(x = value, y = density),
          colour = "#467AAC",
          linewidth = 1.1
        )
    }

    if (!is.null(sample_data) && show_lines) {
      p <- p +
        geom_segment(
          data = sample_data,
          aes(
            x = input$mean,
            xend = value,
            y = dot_y,
            yend = dot_y
          ),
          colour = "#D55E00",
          alpha = 0.35
        )
    }

    if (!is.null(sample_data) && show_dots) {
      p <- p +
        geom_point(
          data = sample_data,
          aes(x = value, y = dot_y),
          alpha = 0.7,
          size = 2,
          colour = "#467AAC"
        )
    }

    p
  })

  output$summary_table <- renderTable({
    values <- sample_values()

    if (is.null(values)) {
      return(data.frame(Message = "No sample yet."))
    }

    data.frame(
      Quantity = c(
        "Target mean",
        "Sample mean",
        "Target variance",
        "Target SD",
        "Sample variance",
        "Sample SD"
      ),
      Value = round(c(
        input$mean,
        mean(values),
        input$variance,
        selected_sd(),
        var(values),
        sd(values)
      ), 3)
    )
  })
}

shinyApp(ui = ui, server = server)
