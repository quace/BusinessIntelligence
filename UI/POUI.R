#Player Overview UI

POtabPanel <- tabPanel("Player Overview",
         fluidPage(
  fluidRow(style = "background-color:#e8ebef;",column(3, 
                  #  helpText("Select a club"),
                  selectInput("POsearchfunction",label=h3("Search by"),
                              choices = list("Player Name"=1,"Club"=2,"Advanced"=3)),
                  conditionalPanel(condition="input.POsearchfunction == 1",
                                   #textInput("playername",label="",placeholder="Enter player name...")
                                   selectInput("playername", NULL,choices = c(),selected=NULL)
                                   
                                   #,actionButton("searchPlayerName",label="Enter")
                  ),
                  conditionalPanel(condition="input.POsearchfunction == 2",
                                   #textInput("clubname",label="",placeholder="Enter club name...")
                                   selectInput("clubname", NULL,choices = c(),selected=NULL)
                                   
                                   #,actionButton("searchClubName",label="Enter")
                  ),
                  conditionalPanel(condition="input.POsearchfunction == 3",
                                   hr(),
                                   selectInput("league", NULL,choices = c(),selected=NULL),
                                   selectInput("country", NULL,choices = c(),selected=NULL),
                                   selectInput("position", NULL,choices = c(),selected=NULL),
                                   selectInput("preferredfoot", NULL,choices = c("Preferred Foot","Left","Right"),selected=NULL)
                                  
                                   
                                   )
              ),
           column(9, 
                  conditionalPanel(condition="input.POsearchfunction == 3",
                  fluidRow(
                    br(),
                    materialSwitch(inputId = "simplify", 
                                          label = "Simplify", value = TRUE, 
                                          status = "success")),
                  fluidRow(
             column(4,
                    #SIMPLIFIED
                    conditionalPanel(condition="input.simplify",
                                     
                                     sliderInput("attributepace",label="Pace",min=0,max=100,value=c(0,100)),
                                     
                                     sliderInput("attributeshooting",label="Shooting",min=0,max=100,value=c(0,100)),
                                     sliderInput("attributepassing",label="Passing",min=0,max=100,value=c(0,100))),
                    #NOT SIMPLIFIED
                    conditionalPanel(condition="!input.simplify",
                                     #PACE
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXAcceleration",label="Acceleration",min=0,max=100,value=c(0,100))
                                                     ),
                                              column(6,
                                                     sliderInput("attributeEXSpeed",label="Speed",min=0,max=100,value=c(0,100))
                                                     )),
                                     hr(),
                                     #SHOOTING
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXAttackingPos",label="Attacking Position",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXFinishing",label="Finishing",min=0,max=100,value=c(0,100))
                                     )),
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXShotPower",label="Shot Power",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXLongShots",label="Long Shots",min=0,max=100,value=c(0,100))
                                     )),
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXVolleys",label="Volleys",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXPenalties",label="Penalties",min=0,max=100,value=c(0,100))
                                     )),
                                     hr(),
                                     
                                     #PASSING
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXVision",label="Vision",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXCrossing",label="Crossing",min=0,max=100,value=c(0,100))
                                     )),
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXFKAccuracy",label="Freekick Accuracy",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXShortPass",label="Short Pass",min=0,max=100,value=c(0,100))
                                     )),
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXLongPass",label="Long Pass",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXCurve",label="Curve",min=0,max=100,value=c(0,100))
                                     ))
                    ) 
                                    
                    
             ),
             column(4, 
                    #SIMPLIFIED
                    conditionalPanel(condition="input.simplify",
                                     
                                     sliderInput("attributeagility",label="Dribbling",min=0,max=100,value=c(0,100)),
                                     sliderInput("attributedefending",label="Defending",min=0,max=100,value=c(0,100)),
                                     sliderInput("attributephysicality",label="Physicality",min=0,max=100,value=c(0,100))
                                     
                    ),
                    #NOT SIMPLIFIED
                    conditionalPanel(condition="!input.simplify",
                                     #DRIBBLING
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXAgility",label="Agility",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXBalance",label="Balance",min=0,max=100,value=c(0,100))
                                     )), 
                                     fluidRow(column(6,
                                                         sliderInput("attributeEXReactions",label="Reactions",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXBallControl",label="Ball Control",min=0,max=100,value=c(0,100))
                                     )),
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXDribbling",label="Dribbling",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXComposure",label="Composure",min=0,max=100,value=c(0,100))
                                     )),
                                     hr(),
                                     
                                     #Defending
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXInterceptions",label="Interceptions",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXHeading",label="Heading Accuracy",min=0,max=100,value=c(0,100))
                                     )),
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXMarking",label="Marking",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXStandingTackle",label="Standing Tackle",min=0,max=100,value=c(0,100))
                                     )),
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXSlidingTackle",label="Sliding Tackle",min=0,max=100,value=c(0,100))
                                     )
                                     ),
                                     hr(),
                                     
                                     #PHYSICALITY
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXJumping",label="Jumping",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXStamina",label="Stamina",min=0,max=100,value=c(0,100))
                                     )),
                                     fluidRow(column(6,
                                                     sliderInput("attributeEXStrength",label="Strength",min=0,max=100,value=c(0,100))
                                     ),
                                     column(6,
                                            sliderInput("attributeEXAggression",label="Aggression",min=0,max=100,value=c(0,100))
                                     ))
                                     
                                     
                    ) 
             )
             ,
             column(4,
                    
                                     
                                     sliderInput("attributeoverallrating",label="Overall Rating",min=0,max=100,value=c(0,100)),
                                     sliderInput("attributepotential",label="Potential",min=0,max=100,value=c(0,100)),
                                     sliderInput("attributeage",label="Age",min=15,max=50,value=c(15,50)),
                                     sliderInput("attributeprice",label="Price (in k)",min=0,max=500,value=c(0,500)))
                  
                    
             
             
           ))
           
                  
            )),
      
  hr(),
  fluidRow(
    column(12, 
           DT::dataTableOutput("playerstatstable"))
  )
))




POMainPanel <-  mainPanel(
  DT::dataTableOutput("playerstatstable")
 # tableOutput("values")
)