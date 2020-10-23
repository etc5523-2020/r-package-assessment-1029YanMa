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


#--------------------------ui-----------------------------
ui <- fluidPage(
  sidebarLayout(sidebarPanel(selectInput(inputId = "select_country",
                                         label = "Please Select a Country",
                                         choices = country_name,
                                         selected = "Chile")),
                mainPanel(dataTableOutput("selected_country")))
)


#--------------------------server----------------------------
server <- function(input, output, session) {

  output$selected_country <- DT::renderDataTable({

    ratios <- ratios %>%
      filter(country == input$select_country) %>%
      arrange(desc(date))

    DT::datatable(ratios, options = list(pageLengh = 15),
                  extensions = 'Responsive')

  })
}

shinyApp(ui, server)
