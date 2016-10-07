library(shiny)

## I just rearranged the UI a little bit

shinyUI(fluidPage(
  h3("Unlimited Test Bank - Probabilities"),
  hr(),
  h4("Enter your answer below and click Answer to check it"),
  h4("or click Next Problem for a new question"),
  hr(),
  h4("Question:"),
  textOutput("Question"),
  hr(),
  numericInput("Prob", label = "Your Answer: ", value = 0.5, min = 0, max = 1, step = 0.05,
               width = NULL),
  actionButton("answer", label = "Answer"),
  actionButton("action", label = "Next Problem"),
  hr(),
  mainPanel(
    h4(textOutput("ci")),
    h5(textOutput("cor")),
    h5(textOutput("incor"))
  )
))