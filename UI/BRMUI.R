#Brand Related Marketing UI
# 
# BRMSidebarPanel <- sidebarPanel()
# 
# BRMMainPanel <-  mainPanel (
#   tabsetPanel(
#     #tabPanel("Visual", shiny::dataTableOutput("playerImages")), 
#     tabPanel("Visual", shiny::dataTableOutput("playerImages")), 
#     tabPanel("Details",  DT::dataTableOutput("popularitytable"))
#     #tabPanel("Table", tableOutput("table"))
#   )
# )

#Brand related marketing UI consists of 2 tabpanels: compare players and compare teams

#loan and sell
BRMPlayerPanel <- tabPanel("Compare Players",
                        fluidPage(
                          fluidRow(
                            #LEFT SIDE PLAYER 1
                            column(6,style = "background-color:#e8ebef;",
                                   column(3),
                                   column(6,
                                          selectInput("BRMPlayer1",label=h3("Select player"),
                                                      choices = c(),selected=NULL)
                                          ),
                                   column(3)
                                   
                                   ),
                          
                            
                            #RIGHT SIDE PLAYER 2
                            column(6, style = "background-color:#e8ebef;",
                                   column(3),
                                   column(6,
                                   selectInput("BRMPlayer2",label=h3("Select player"),
                                              choices = c(),selected=NULL)
                                   ),
                                   column(3)
                                   )
                          ),
                          fluidRow(
                            column(12,
                                   tabsetPanel(type = "tabs",
                                        tabPanel("Social Media", 
                                                 #FACEBOOK
                                                 fluidRow(
                                                   column(12,
                                                          fluidRow(
                                                            column(6,
                                                                   column(3),
                                                                   column(6,style = "background-color:#e8ebef;",
                                                                          tags$div(class="header", checked=NA,
                                                                                      tags$h4("Followers:"))),
                                                                   column(3)),
                                                            column(6, 
                                                                   column(3),
                                                                   column(6,
                                                                          style = "background-color:#e8ebef;",
                                                                          tags$div(class="header", checked=NA,
                                                                                      tags$h4("Followers:"))),
                                                                   column(3)),
                                                            
                                                            hr()
                                                            ),
                                                        
                                                          
                                                          
                                                          fluidRow(
                                                            #PLAYER 1
                                                            column(6,
                                                                   column(3),
                                                                   column(6,style = "background-color:#edffea;",
                                                                          fluidRow(
                                                                          column(2),
                                                                          column(2,
                                                                                 icon("facebook-square","fa-3x")),
                                                                          column(6,
                                                                                 verbatimTextOutput("facebookFollowersP1" )),
                                                                          column(2)
                                                                          ),
                                                                          fluidRow(
                                                                            column(2),
                                                                            column(2,
                                                                                   icon("twitter-square","fa-3x")),
                                                                            column(6,
                                                                                   verbatimTextOutput("twitterFollowersP1" )),
                                                                            column(2)
                                                                          ),
                                                                          fluidRow(
                                                                            column(2),
                                                                            column(2,
                                                                                   icon("instagram","fa-3x")),
                                                                            column(6,
                                                                                   verbatimTextOutput("instagramFollowersP1" )),
                                                                            column(2)
                                                                          )
                                                                          
                                                                          
                                                                          
                                                                          ),
                                                                   column(3)
                                                                   ),
                                                                    
                                                                  
                                                            #PLAYER 2
                                                            column(6,
                                                                   column(3),
                                                                   column(6,style = "background-color:#edffea;",
                                                                          fluidRow(
                                                                            column(2),
                                                                            column(2,
                                                                                   icon("facebook-square","fa-3x")),
                                                                            column(6,
                                                                                   verbatimTextOutput("facebookFollowersP2" )),
                                                                            column(2)
                                                                          ),
                                                                          fluidRow(
                                                                            column(2),
                                                                            column(2,
                                                                                   icon("twitter-square","fa-3x")),
                                                                            column(6,
                                                                                   verbatimTextOutput("twitterFollowersP2" )),
                                                                            column(2)
                                                                          ),
                                                                          fluidRow(
                                                                            column(2),
                                                                            column(2,
                                                                                   icon("instagram","fa-3x")),
                                                                            column(6,
                                                                                   verbatimTextOutput("instagramFollowersP2" )),
                                                                            column(2)
                                                                          )
                                                                         
                                                                          
                                                                   ),
                                                                   column(3)
                                                            )
                                                          ),
                                                          fluidRow(
                                                            column(6,
                                                                   column(3),
                                                                   column(6,style = "background-color:#e8ebef;",
                                                                          tags$div(class="header", checked=NA,
                                                                                   tags$h4("Worth:"))),
                                                                   column(3)),
                                                            column(6, 
                                                                   column(3),
                                                                   column(6,
                                                                          style = "background-color:#e8ebef;",
                                                                          tags$div(class="header", checked=NA,
                                                                                   tags$h4("Worth:"))),
                                                                   column(3)),
                                                            
                                                            hr()
                                                          ),
                                                          fluidRow(
                                                            
                                                            #PLAYER 1
                                                            column(6,
                                                                   column(3),
                                                                   column(6,style = "background-color:#edffea;",
                                                                         
                                                                          fluidRow(
                                                                            column(2),
                                                                            column(2,
                                                                                   icon("eur","fa-3x")),
                                                                            column(6,
                                                                                   verbatimTextOutput("followerWorthP1" )),
                                                                            column(2)
                                                                          )
                                                                   ),
                                                                   column(3)
                                                            ),
                                                            
                                                            
                                                            #PLAYER 2
                                                            column(6,
                                                                   column(3),
                                                                   column(6,style = "background-color:#edffea;",
                                                                        
                                                                          fluidRow(
                                                                            column(2),
                                                                            column(2,
                                                                                   icon("eur","fa-3x")),
                                                                            column(6,
                                                                                   verbatimTextOutput("followerWorthP2" )),
                                                                            column(2)
                                                                          )
                                                                          
                                                                   ),
                                                                   column(3)
                                                            )
                                                          )
                                                          
                                     
                                                   )
                                                 )
                                        ),
                                        tabPanel("Value", fluidRow())
                                        
                              )
                            )
                          )
                        )
)
                          

BRMTeamPanel <- tabPanel("Compare Teams",
                      fluidPage(
                        fluidRow()
                        )
                      
)



