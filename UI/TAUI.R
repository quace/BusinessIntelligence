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

AtabPanel <- tabPanel("Buy",
                       fluidPage(
                         fluidRow(
                           #OPTIONS
                           column(3,style = "background-color:#e8ebef;" ,
                                  selectInput("TAAClub",label=h3("Select club"),
                                              choices = c(),selected=NULL),
                                  conditionalPanel(condition="input.TAAClub",
                                                  selectInput("TAAPosition", label=h4("Select Position"), choices = c(), selected=NULL),
                                                  sliderInput("TAAPricerange",label=h4("Select price range (in k)"),min=0,max=100000,value=c(0,100000)),
                                                  fluidRow(column(12,
                                                                  
                                                                  hr(),         
                                                                  tags$div(class="header", checked=NA,
                                                                           tags$h4("Reasons to Buy:")),
                                                                  icon("bullseye"),
                                                                  verbatimTextOutput("reasonAttackingPos2" ),
                                                                  icon("credit-card"),
                                                                  verbatimTextOutput("reasonWage2"),
                                                                  icon("money"),
                                                                  verbatimTextOutput("reasonValue2"),
                                                                  icon("ban"),
                                                                  verbatimTextOutput("reasonContract2"),
                                                                  icon("graduation-cap"),
                                                                  verbatimTextOutput("reasonAge2"),
                                                                  hr()))
                                  
                                  )
                               
                           ),
                           
                           
                           #OUTPUT
                           column(9, 
                                  
                                  shiny::dataTableOutput("acquiretable")))
                       )
)
                                                                             
                                                                             
                                                                             
                                                                            