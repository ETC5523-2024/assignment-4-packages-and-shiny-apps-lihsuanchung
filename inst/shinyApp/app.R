library(shiny)
library(ggplot2)
library(dplyr)
library(shinydashboard)

data("life_expectancy_clean")

ui <- dashboardPage(
  dashboardHeader(title = "Life Expectancy Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      sliderInput("year", "Select Year:", min = 1950, max = 2021, value = 2021),
      selectInput("country", "Select Country:", choices = unique(life_expectancy_clean$Entity))
    )
  ),
  dashboardBody(
    fluidRow(
      box(title = "Life Expectancy Over Time", status = "primary", solidHeader = TRUE, width = 12,
          plotOutput("lifePlot")
      ),
      box(title = "Description", status = "info", solidHeader = TRUE, width = 12,
          helpText("This graph shows the life expectancy trend for the selected country and year range."),
          helpText("Use the slider to adjust the year range and select a country from the dropdown menu to view the life expectancy trends.")
      )
    )
  )
)

server <- function(input, output) {
  output$lifePlot <- renderPlot({

    filtered_data <- life_expectancy_clean %>%
      filter(Year <= input$year & Entity == input$country)

    ggplot(filtered_data, aes(x = Year, y = LifeExpectancy)) +
      geom_line(color = "steelblue", size = 1.2) +
      geom_point(color = "darkblue", size = 3) +
      labs(title = paste("Life Expectancy Trend in", input$country),
           x = "Year",
           y = "Life Expectancy (Years)") +
      theme_light(base_size = 15) +
      theme(
        plot.title = element_text(face = "bold", hjust = 0.5, size = 18),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        plot.margin = unit(c(0.5, 0.5, 0.1, 0.5), "cm")
      )
  })
}

shinyApp(ui = ui, server = server)
