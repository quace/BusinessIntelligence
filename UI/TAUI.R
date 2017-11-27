#transfer advice UI consists of 2 tabpanels: loan and sel; acquire

#loan and sell
LAStabPanel <- tabPanel("Loan and Sell",
                       fluidPage(
                         fluidRow(
                                  #OPTIONS
                                  column(3,style = "background-color:#e8ebef;" ,
                                  selectInput("TALASClub",label=h3("Select club"),
                                              choices = c(),selected=NULL),
                                  fluidRow(column(12,
                                                  tags$div(class="header", checked=NA,
                                                           tags$h4("Reason to Loan:")),
                                                  verbatimTextOutput("reasonLoan" ),
                                                  hr(),
                                                  tags$div(class="header", checked=NA,
                                                           tags$h4("Reasons to Sell:")),
                                                  icon("bullseye"),
                                                  verbatimTextOutput("reasonAttackingPos" ),
                                                  icon("credit-card"),
                                                  verbatimTextOutput("reasonWage"),
                                                  icon("money"),
                                                  verbatimTextOutput("reasonValue"),
                                                  icon("ban"),
                                                  verbatimTextOutput("reasonContract"),
                                                  icon("graduation-cap"),
                                                  verbatimTextOutput("reasonAge"),
                                                  hr()))
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
                                                                             
                                                                             
                                                                             
                                                                            