library(shiny)
library(ggplot2)
library(dplyr)
library(readr)

df <- read_csv("cleaned_accident_data.csv")

df_years <- df %>% 
  filter(grepl("^\\d{4}", `Year / Period`) | grepl("2023|2024|2025", `Year / Period`))

ui <- fluidPage(
  titlePanel("USA Vehicle Accident Dashboard - 2023"),
  sidebarLayout(
    sidebarPanel(
      selectInput("year", "Select Year / Period:",
                  choices = unique(df_years$`Year / Period`),
                  selected = "2023")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Fatalities Trend", plotOutput("fatalitiesPlot")),
        tabPanel("Crashes Trend", plotOutput("crashesPlot")),
        tabPanel("Comparison (2022 vs 2023)", plotOutput("comparePlot")),
        tabPanel("Dataset View", tableOutput("dataTable"))
      )
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    df_years %>% filter(`Year / Period` == input$year)
  })
  
  output$fatalitiesPlot <- renderPlot({
    ggplot(df_years, aes(x = `Year / Period`, y = Fatalities, fill = `Year / Period`)) +
      geom_col() +
      theme_minimal() +
      labs(title = "Fatalities by Year / Period", x = "Year / Period", y = "Fatalities")
  })
  
  output$crashesPlot <- renderPlot({
    ggplot(df_years, aes(x = `Year / Period`, y = `Crashes (approx.)`, fill = `Year / Period`)) +
      geom_col() +
      theme_minimal() +
      labs(title = "Crashes by Year / Period", x = "Year / Period", y = "Crashes")
  })
  
  output$comparePlot <- renderPlot({
    df_compare <- df_years %>%
      filter(`Year / Period` %in% c("2022", "2023")) %>%
      select(`Year / Period`, Fatalities, `Crashes (approx.)`) %>%
      tidyr::pivot_longer(cols = c(Fatalities, `Crashes (approx.)`), 
                          names_to = "Metric", values_to = "Value")
    
    ggplot(df_compare, aes(x = `Year / Period`, y = Value, fill = `Year / Period`)) +
      geom_col(position = "dodge") +
      facet_wrap(~Metric, scales = "free_y") +
      theme_minimal() +
      labs(title = "Comparison of Crashes & Fatalities (2022 vs 2023)")
  })
  
  output$dataTable <- renderTable({
    filtered_data()
  })
}

shinyApp(ui, server)
