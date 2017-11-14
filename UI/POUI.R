#Player Overview UI

POSidebarPanel <-  sidebarPanel(
  #  helpText("Select a club"),
  selectInput("POsearchfunction",label=h3("Search by"),
              choices = list("Player Name"=1,"Club"=2,"Attribute"=3)),
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
                               sliderInput("attributepace",label="Pace",min=0,max=100,value=c(0,100)),
                              
                               sliderInput("attributeshooting",label="Shooting",min=0,max=100,value=c(0,100)),
                               sliderInput("attributepassing",label="Passing",min=0,max=100,value=c(0,100)),
                               sliderInput("attributeagility",label="Dribbling",min=0,max=100,value=c(0,100)),
                               sliderInput("attributedefending",label="Defending",min=0,max=100,value=c(0,100)),
                               sliderInput("attributephysicality",label="Physicality",min=0,max=100,value=c(0,100)),
                               sliderInput("attributeoverallrating",label="Overall Rating",min=0,max=100,value=c(0,100)),
                               sliderInput("attributepotential",label="Potential",min=0,max=100,value=c(0,100)),
                              sliderInput("attributeprice",label="Price (in k)",min=0,max=500,value=c(0,500)))
  
              
)

POMainPanel <-  mainPanel(
  DT::dataTableOutput("playerstatstable")
 # tableOutput("values")
)