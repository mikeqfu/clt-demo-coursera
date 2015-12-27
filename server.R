library(shiny)

# Simulate averages of exponential samples
means <- function(noSim, n, lambda) {
    mes <- NULL
    if (lambda > 0 & (n %% 1 == 0) & n > 0) {
        for (i in 1:noSim) mes <- c(mes, mean(rexp(n, lambda)))
        return(mes)
    } else if (lambda <= 0 & (n %% 1 == 0) & n > 0) {
        stop("'lambda must be greater than zero!")
    } else {
        stop("The 'sample size' must be a positive integer.")
    }
}


set.seed(123)

shinyServer(
    function(input, output) {
        mes <- reactive(means(as.numeric(input$noSim), 
                               as.numeric(input$n),
                               as.numeric(input$lambda)))
        # Explanation
        output$text <- renderText({
            paste("With the specified parameters, 
                  the simulation has been repeated", 
                  input$noSim, "times. Namely, there are", 
                  input$noSim, "samples, each of which includes", 
                  input$n, "exponentials being randomly generated.")
        })
        
        # Plot
        output$mHist <- renderPlot({
            cellNumber <- input$cellNumber
            # Draw an empirical distribution based on the simulated data
            hist(x = mes(), 
                 breaks = cellNumber, 
                 probability = TRUE, 
                 main = paste0("Probability density of ", 
                               as.numeric(input$n), 
                               " exponentials (lambda = ", 
                               as.numeric(input$lambda), 
                               ")"),
                 xlab = paste("Mean of", as.numeric(input$n), "exponentials"), 
                 ylab = "Probability density", 
                 col = rgb(0.1, 0.1, 0.1, alpha = 0.05))
            
            # Draw a line for the theoretical mean, given the lambda
            theoretical_mean <- 1 / as.numeric(input$lambda)
            abline(v = theoretical_mean, col = "blue", lty = 1, lwd = 4)
            # Draw a line for the sample mean
            abline(v = mean(mes()), col = "red", lty = 3, lwd = 2)
            
            
            # Given the theorectical mean in this case, 
            # draw the theoretical probability density of normal distribution
            x_axis <- seq(min(mes()), max(mes()), length = 88)
            vmes <- round(var(mes()), 3)
            y_axis <- dnorm(x_axis, mean = theoretical_mean, sd = sqrt(vmes))
            lines(x_axis, y_axis, col = "magenta", lty = 2, lwd = 2)
            
            # Draw the probability density of the simulated sample means
            lines(density(mes()), col = "cyan", lwd = 2)
            
            if (input$showLegend) {
                legend(x = 'topright', 
                       c("Empirical distribution of the simulated sample means", 
                         "Theoretical mean, given lambda", 
                         "Sample mean based on simulation",
                         paste("Probability density of", 
                               "the theoretical normal distribution"),
                         paste("Probability density distribution of", 
                               "the simulated sample means")),
                       col = c(rgb(0.1, 0.1, 0.1, alpha = 0.05), 
                               "blue", "red", "magenta", "cyan"),
                       lty = c(1, 1, 3, 2, 1), lwd = c(12, 4, 2, 2, 1))
            }
        })
    }
)