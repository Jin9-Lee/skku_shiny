# Load packages ----

library(shiny)
library(tidyverse)

# Load source

load("data/porject.Rdata")
education = c("무학(만7세이상)",
              "초등학교",
              "중학교",
              "고등학교",
              "전문대학",
              "대학교",
              "대학원(석사)",
              "대학원(박사)")

# User interface ----

ui <- fluidPage(
  titlePanel('학력에 따른 근로 형태'),
  
  sidebarPanel(
    selectInput('status', '학력', education, selected = "대학교")
  ),
  
  plotOutput("react_plot")
)

# Server logic ----

server <- function(input, output) {
  
  eduInput <- reactive({
    education[education == input$status]
  })
  
  output$react_plot <- renderPlot({
    income_edu[income_edu$edulevel == eduInput(), ] %>% 
      ggplot(aes(work_status, fill = factor(work_status))) + geom_bar() + 
      ggtitle(eduInput()) + 
      condition +
      theme(plot.title = element_text(
        size = rel(1.5), lineheight = .9,
        family = "Times", face = "bold.italic"))
  })
  
}

# Run app ----
shinyApp(ui, server)