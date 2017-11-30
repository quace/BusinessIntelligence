#Player performance conists of X tabpanels: General/Potential, Attributes and Superstar comparisson

### General/Potential

GPtabPanel <- tabPanel("General/Potential", 
                       sidebarLayout( 
                         sidebarPanel(selectInput("playernameperf", label = "Select player:",choices = c(),selected=NULL),
                                      selectInput("compareplayerperf", label = "compare with: ", choices = c(), selected = NULL),
                                      selectInput("performanceSel", label = "Select performance indicator:",choices = c("overall_rating","potential"),selected=NULL), 
                                      sliderInput("zoomPlayerPerf",label="Y-axis zoom: ",min=0,max=100,value=c(0,100))#,
                                      #sliderInput("zoomPlayerPerfX", label = "X-axis zoom (%):", min=0,max=100,value=c(0,100))
                                      ), 
                         
                         mainPanel(
                           fluidPage(
                             fluidRow(
                               column(12,
                                      plotOutput("personalperformance")
                               )),
                             fluidRow(
                               column(6,
                                      plotOutput("homeMatchesByPlayer")),
                               column(6,
                                      plotOutput("awayMatchesByPlayer"))
                               
                             )
                           )
                           
                         )
                         
                         
                        
              )
)

### Attributes

AttrtabPanel <-  tabPanel("Attributes",
                          sidebarLayout(
                            sidebarPanel(selectInput("playernameAttr", label = "Select player:",choices = c(),selected=NULL),
                                        selectInput("compareplayerAttr", label = "compare with: ", choices = c(), selected = NULL),
                                        selectInput("attribute", label = "Select an attribute:",choices = c("crossing","finishing","heading_accuracy", "short_passing","volleys","dribbling","curve","free_kick_accuracy","long_passing","ball_control","acceleration","sprint_speed","agility","reactions","balance","shot_power","jumping","stamina","strength","long_shots","aggression", "interceptions","positioning","vision","penalties","marking","standing_tackle","sliding_tackle","gk_diving","gk_handling","gk_kicking","gk_positioning","gk_reflexes"), selected = NULL), 
                                        sliderInput("zoomPlayerAttr",label="Y-axis zoom: ",min=0,max=100,value=c(0,100))),
                             mainPanel(plotOutput("attributePP"))
                          )
)

### Compare with a starplayer

# StartabPanel <- tabPanel("Compare with a starplayer",
#                          sidebarLayout(
#                            sidebarPanel(selectInput("playernameStar", label = "Select player:",choices = c(),selected=NULL),
#                                         p("Comparing with: Eden Hazard"),
#                                         img(src = "Hazard.png", height = 250, width = 250),
#                                         br(),
#                                         br(),
#                                         selectInput("attributeStar", label = "Select an attribute:",choices = c("overall_rating","potential","crossing","finishing","heading_accuracy", "short_passing","volleys","dribbling","curve","free_kick_accuracy","long_passing","ball_control","acceleration","sprint_speed","agility","reactions","balance","shot_power","jumping","stamina","strength","long_shots","aggression", "interceptions","positioning","vision","penalties","marking","standing_tackle","sliding_tackle","gk_diving","gk_handling","gk_kicking","gk_positioning","gk_reflexes"), selected = NULL)), 
#                            mainPanel(plotOutput("starPP"))
#                          )
# )



