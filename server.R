library(shiny)
data(mtcars)
cars <- mtcars
cars$cyl <- factor(cars$cyl)
cars$gear <- factor(cars$gear)
cars$am <- factor(cars$am)
namesList <- list(
    'cyl'='Cylinders',
    'gear'='Gears',
    'am'='Transmission',
    'mpg'='Miles per gallon',
    'disp'='Displacement (cu. in.)',
    'hp'='Horsepower',
    'wt'='Weight',
    'drat'='Rear axel ratio',
    'qsec'='1/4 mile time (sec.)',
    'vs'='V-engine vs. straight',
    'carb'='# of carburetors'
)
displayShapes <- list(
    'cyl'=list(
        'col'=c("black", "red", "blue"),
        'pch'=c(16, 17, 18)
    ),
    'gear'=list(
        'col'=c("black", "red", "blue"),
        'pch'=c(16, 17, 18)
    ),
    'am'=list(
        'col'=c("black", "red"),
        'pch'=c(16, 17)
    )
)
shinyServer(function(input, output) {
    output$plot <- renderPlot({
        frm <- as.formula(paste(input$y, "~", input$x))
        myColors <- c("black", "red", "blue")
        palette(myColors)
        plot(frm,
             xlab=namesList[[input$x]],
             ylab=namesList[[input$y]],
             col = as.numeric(cars[[input$fact]]),
             pch = as.numeric(cars[[input$fact]]) + 15,
             data=cars)
        legend("topright",
               col = displayShapes[[input$fact]][['col']],
               legend = levels(cars[[input$fact]]),
               pch = displayShapes[[input$fact]][['pch']],
               title = namesList[[input$fact]])
        if (input$lines) {
            for (f in levels(cars[[input$fact]])) {
                tmp <- cars[cars[[input$fact]] == f,]
                fit <- lm(frm, tmp)
                if (input$fact == 'am') {
                    abline(fit, col = as.numeric(f) + 1)
                } else {
                    abline(fit, col = f)
                }
            }
        }
    })
  
})
