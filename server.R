library(shiny)

N<-round(runif(1,3,30),0)
A<-sample(c(1:N),round(runif(1,0,N-1),0),replace=FALSE)
B<-sample(c(1:N),round(runif(1,0,N-1),0),replace=FALSE)
lA<-length(A)
lB<-length(B)
lAandB<-length(intersect(A,B))
lAorB<-length(union(A,B))

## I just initiated the reactive values outside of the shiny server before the write_question 
## because I believe it makes use of the reactive values
v <- reactiveValues(cor_inc = "", 
                    N = N,
                    A = A,
                    B = B,
                    correct = 0,
                    incorrect = 0,
                    question_count = 0,
                    test_area = 0)

write_question <- function(N,A,B) {
  preamble<-paste("You know the following about events A and B:")
  pofA<-paste("P(A)=",length(A),"/",length(N),",")
  pofB<-paste("P(B)=",length(B),"/",length(N),",")
  pofAandB<-paste("P(A and B)=",length(union(v$A,v$B)),"/",length(N),".")
  question<-paste("What is P(A or B)?")
  
  ## Here I have commented out mtext, I think it is used in combination with plots,
  ## for renderText(), we would need text, so I just returned the concatenated question
  ##mtext(paste(preamble,"\n",pofA,"\n",pofB,"\n",pofAandB,"\n",question),3)
  return(paste(preamble,"\n",pofA,"\n",pofB,"\n",pofAandB,"\n",question))
}

shinyServer(function(input, output, session){
  observeEvent(input$action, {
    v$cor_inc <- ""
    v$N<-round(runif(1,3,30),0)
    v$A<-sample(c(1:v$N),round(runif(1,0,v$N-1),0),replace=FALSE)
    v$B<-sample(c(1:v$N),round(runif(1,0,v$N-1),0),replace=FALSE)
  })
  
  observeEvent(input$answer, {
    correct_answer <- length(union(v$A,v$B))/v$N
    if (correct_answer >= input$Prob - 0.01 & correct_answer <= input$Prob + 0.01){
      v$cor_inc <- "Correct!"
        v$correct <- v$correct + 1
    }
    else{
      v$cor_inc <- "Incorrect! Please try again"
        v$incorrect <- v$incorrect + 1
    }
 })
  
  output$Question <- renderText(write_question(v$N,v$A,v$B))
  output$ci <- renderText(v$cor_inc)
  output$cor <- renderText(paste("Correct: ", v$correct))
  output$incor <- renderText(paste("Incorrect: ", v$incorrect))
})

