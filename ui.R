library(shiny)

shinyUI(
    fluidPage(
        titlePanel(strong("Demonstration of Central Limit Theorem")),
        sidebarLayout(
            sidebarPanel(
                h4("Developing Data Products - Assignment - part 1"),
                p("This simple Shiny app is created for the first part 
                  of the course project of Developing Data Products, and 
                  deployed on the RStudio's server."), 
                tags$hr(),
                h3("Set parameters:"),
                p('(Note that a seed number is set to be "123" in this app.)'),
                textInput(
                    inputId = "lambda", 
                    label = "Rate parameter for the exponential distribution:", 
                    value = 0.2),
                textInput(
                    inputId = "noSim", 
                    label = "Nmber of simulations:", 
                    value = 1000),
                textInput(
                    inputId = "n", 
                    label = "Sample size for each simulation:", 
                    value = 40),
                sliderInput(
                    inputId = "cellNumber", 
                    label = "Number of cells for the empirical distribution:",
                    min = 5, 
                    max = 500, 
                    value = 25, 
                    step = 5), 
                checkboxInput(
                    inputId = "showLegend", 
                    label = "Show Legend", 
                    value = TRUE)
            ),
            mainPanel(
                h4('This simple Shiny application is based on the
                   "simulation exercise" of another Coursera course,', 
                   strong("Statistical Inference.")),
                p("In this app, we may play with the",
                  a(href="https://en.wikipedia.org/wiki/Exponential_distribution", 
                    "exponential distribution"),
                  "; then compare it with, and demonstrate, the", 
                  a(href="https://en.wikipedia.org/wiki/Central_limit_theorem", 
                    "central limit theorem"), ".",
                  "Through simulation, we may view the basic properties of
                  the distribution of the mean of a specified 
                  number of exponentials. Some relevant parameters have been 
                  already given with the launch of this app (see the textboxes 
                  and slider on the left-hand side of this page). 
                  We could simply alter those values manually and view the
                  changes of the distribution shown in the figure below"), 
                tags$hr(),
                textOutput(outputId = "text"), 
                plotOutput(outputId = "mHist")
            )
        )
        
    )
)
