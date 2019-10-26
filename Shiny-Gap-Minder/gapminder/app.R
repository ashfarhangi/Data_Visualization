
library(shiny)
library(ggplot2)
library(dplyr)
gapminder <- read.csv('GitHub/Data_Visualization/data/gapminder.csv')

plotFinal <-function(indata,trans = FALSE,x=gpd,y=life){
  x <- ensym(x)
  y <- ensym(y)
  continent_colours <-c(Africa = "green", Americas = "red", Asia = "blue", 
                        Europe = "brown", Oceania = "white")
  
  constraint <- list(
    life = c(20, 88),
    gpd = c(250, 60000))
  label <- list(
    life = "life expency",
    gpd = "average income per year $")
  
  
  plotYear <- min(indata$year)
  
  
  
  
  dfPlot <- ggplot(data = indata) +
    coord_cartesian(xlim = constraint[[toString(x)]],
                    ylim = constraint[[toString(y)]])
  
  if(toString(x) == "gpd"){
    dfPlot <- dfPlot +
      scale_x_log10(breaks = 5*10**(2:4)) 
  }
  if(toString(y) == "gpd"){
    dfPlot <- dfPlot +
      scale_y_log10(breaks = 5*10**(2:4)) 
  }
  if (nrow(indata) == 0){
    return(dfPlot)
  }
  if (trans) {
    pointAlpha <- 0.3
  } else {
    pointAlpha <- 1
  }
  
  
  dfPlot <- dfPlot +  
    geom_point(aes(x = !!x,
                   y = !!y,
                   colour = continent,
                   size = population),
               alpha = pointAlpha)+
    labs(title = plotYear,
         x = label[[toString(x)]],
         y = label[[toString(y)]],
         colour = "Continent")+
    scale_colour_manual(values = continent_colours) +
    scale_alpha_manual() +
    guides(size = FALSE) 
  
  return(dfPlot)
}
axis <- function(g, axis) {
  
  
  return(rlang:::get_expr(g$layers[[1]]$mapping[[axis]]))
  
} 
history <- function(inplot, indata, activeYear = NULL){
  
  
  if (is.null(activeYear)) {
    activeYear = max(indata$year)  
  }  
  
  xdata = axis(inplot, "x")
  ydata = axis(inplot, "y")
  
  outplot <- inplot + geom_path(data = indata,
                                aes(x = !!xdata,
                                    y = !!ydata,
                                    colour = continent),
                                show.legend = FALSE) +
    geom_point(data = indata[indata$year == activeYear,],
               aes(x = !!xdata,
                   y = !!ydata,
                   colour = continent,
                   size = population),
               show.legend = FALSE)
  
  return(outplot)
  
}  

ui <- fluidPage(
  
  titlePanel("Income vs life expectancy."),
  fluidRow(
    column(10,
           plotOutput("dfPlot", click="plotClick"),
           tableOutput("graphData"),
           verbatimTextOutput("clickData")
    )
  ),
  fluidRow(
    column(6,
           sliderInput("year",
                       "Select year",
                       min = min(gapminder$year),
                       max = max(gapminder$year),
                       value = min(gapminder$year),
                       sep="", 
                       step=1, 
                       animate = animationOptions(interval = 1250)
           )
    ),
    column(6,
           checkboxGroupInput("continent",
                              "Select continents",
                              choices = levels(gapminder$continent),
                              selected = levels(gapminder$continent))
    )
  )
)

server <- function(input, output) {
  activeCountry <- reactiveVal()
  
  historicData <- reactive({
    gapminder %>% 
      filter(year <= input$year) %>% 
      filter(country == activeCountry()) 
  })
  
  observeEvent(input$plotClick, 
               {
                 nearCountry <- nearPoints(plotData(), input$plotClick, maxpoints = 1)
                 activeCountry(as.character(nearCountry$country))
               })
  
  plotData <- reactive({
    gapminder %>% 
      filter(year == input$year) %>% 
      filter(continent %in% input$continent)
  })
  
  
  output$dfPlot <- renderPlot({
    if (length(activeCountry()) == 0) { 
      plotData() %>% 
        plotFinal() 
    } else {
      plotData() %>% 
        plotFinal(trans = TRUE) %>% 
        history(historicData())
    }
    
  })
  output$clickData <- renderPrint(({
    activeCountry()
  }))
}

shinyApp(ui = ui, server = server)




