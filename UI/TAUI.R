#transfer advice UI consists of 2 tabpanels: loan and sel; acquire

#loan and sell
LAStabPanel <- tabPanel("Loan and Sell",
                       fluidPage(
                         fluidRow(
                                  #OPTIONS
                                  column(3,style = "background-color:#e8ebef;" ,
                                  selectInput("TALASClub",label=h3("Select club"),
                                              choices = c(),selected=NULL)
                                  ),
                                  
                                  
                                  #OUTPUT
                                  column(9, 
                                         #test
                                         tags$span(icon('circle'), style = "display: none;") ,
                                         
                                         shiny::dataTableOutput("loanandselltable")))
                                         #plotOutput("testplot")))
                       )
)

AtabPanel <- tabPanel("Acquire",
                       fluidPage(
                         fluidRow(
                           #OPTIONS
                           column(3,style = "background-color:#e8ebef;" ,
                                  selectInput("TAAClub",label=h3("Select club"),
                                              choices = c(),selected=NULL)
                           ),
                           
                           
                           #OUTPUT
                           column(9, 
                                  #test
                                  tags$span(icon('circle'), style = "display: none;"))) 
                                  
                                #  shiny::dataTableOutput("acquiretable")))
                       )
)
                                                                             
                                                                             
                                                                             
                                                                            