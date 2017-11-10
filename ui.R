library(shiny)

data("mtcars")
cars <- mtcars
cars$cyl <- factor(cars$cyl)
cars$gear <- factor(cars$gear)
cars$am <- factor(cars$am)
namesList <- list(
    '1/4 mile time (sec.)'='qsec',
    '# of carburetors'='carb',
    'Cylinders'='cyl',
    'Displacement (cu. in.)'='disp',
    'Gears'='gear',
    'Horsepower'='hp',
    'Miles per gallon'='mpg',
    'Rear axel ratio'='drat',
    'Transmission'='am',
    'V-engine vs. straight'='vs',
    'Weight'='wt'
)
factorList <- list(
    Cylinders='cyl',
    Gears='gear',
    'Transmission (auto/manual)'='am'
)

shinyUI(fluidPage(
  titlePanel("Exploratory Data Analysis of mtcars"),
  sidebarLayout(
    sidebarPanel(
        selectInput(inputId="x",
                    label="Select an x variable:",
                    selected = 'wt',
                    choices=namesList),
        selectInput(inputId="y",
                    label="Select a y variable:",
                    selected = 'mpg',
                    choices=namesList),
        checkboxInput(inputId="lines",
                      label="Regression lines",
                      value=TRUE,
                      width = '100%'),
        selectInput(inputId="fact",
                    label="Select a factor to examine:",
                    selected='am',
                    choices=factorList)
    ),
    mainPanel(
       plotOutput("plot"),
       h3('This application allows the user to explore the Motor Trend cars dataset.'),
       h5('Based on user input, the server calculates regression lines for each level of the selected factor.  For example, in the default view, we explore the effect of transmission type (manual or automatic) and weight on miles per gallon.'),
       p('Choose an x variable, choose an y variable, and then select',
        'a factor variable to examine.  By clicking the Regression lines',
        'checkbox, you can turn the regression lines on and off.')
    )
  )
))
