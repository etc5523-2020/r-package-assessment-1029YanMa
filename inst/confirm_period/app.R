library(shiny)
library(shinythemes)
library(dplyr)
library(tidyverse)
devtools::install_github("RamiKrispin/coronavirus")
library(coronavirus)
update_dataset()
library(DT)
library(lubridate)
library(ggplot2)
library(plotly)
library(zoo)
data(coronavirus)




#-------------------Data Cleaning-------------------------

corona_country <- coronavirus %>%
  group_by(country, date, type) %>%
  summarise(cases = sum(cases)) %>%
  ungroup()

corona_wide <- corona_country %>%
  pivot_wider(names_from = type, values_from = cases)

ratios <- corona_wide %>%
  mutate(recover_cum = cumsum(recovered),
         confirm_cum = cumsum(confirmed),
         death_cum = cumsum(death))

ratios <- ratios %>%
  mutate(recover_ratio = round(recover_cum / confirm_cum, 2),
         death_ratio = round(death_cum / confirm_cum, 2))

ratios %>%
  select(country, date, confirmed, confirm_cum,
         recovered, recover_cum, recover_ratio,
         death, death_cum, death_ratio)

country_name <- c("Chile", "Bolivia")

#-------------------ui---------------------------
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(dateRangeInput(inputId = "daterange",
                                label = "Please Select the Start and End Date",
                                start = min(coronavirus$date),
                                end = max(coronavirus$date))),
    mainPanel(plotlyOutput("range_plot"))))


#-------------------server------------------------
server <- function(input, output, session) {
  output$range_plot <- renderPlotly({

    ratios_range <- ratios %>%
      filter(country == c("Chile", "Bolivia")) %>%
      filter(date >= as.Date(input$daterange[1]) & date <= as.Date(input$daterange[2]))

    plot_range <- ratios_range %>%
      ggplot() +
      geom_line(aes(x = date, y = confirmed, color = country))

    ggplotly(plot_range)})}


shinyApp(ui, server)
