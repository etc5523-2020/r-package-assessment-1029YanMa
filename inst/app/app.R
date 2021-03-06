library(shiny)
library(shinythemes)
library(dplyr)
library(tidyverse)
library(DT)
library(lubridate)
library(ggplot2)
library(plotly)
library(zoo)





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



#--------------------ui---------------------
ui <- fluidPage(

    theme = shinytheme("cerulean"),

    h1("COVID-19 Data Explore -- Chile and Bolivia"),
    br(),

    h3("About"),
    p("We know that Chile and Bolivia are neighbors, does it mean that COVID-19 is spreading in similar trends in both countries? Are there any differences in recovery rates and death rates between the two countries? We can explore the data to find out the answer."),

    h3("Daily Cases Data of Your Selected Country"),
    br(),
    p("You can check the daily data of COVID-19 of Chile and Bolivia in the following table. By clicking the 'Please Select a Country', you can swicth the country to see the data of that country. And by typing a date in the search box, you can see the data of that day."),
    p("This table provides the data of (1) newly confirmed, recovered and dead cases; (2) the cumulative cases; (3) the ratio of recovery and death."),
    selectInput(inputId = "select_country",
                label = "Please Select a Country",
                choices = country_name,
                selected = "Chile"),
    dataTableOutput("selected_country"),
    br(),

    h3("Compare the Trends of New Confirmed Cases of Chile and Bolivia by Your Input Date Range"),
    br(),
    p("By selecting the start and end date, you can see the trend of newly confirmed cases in the two countries on each day in this time period. And you can also check the number of new cases of each day by pointing at the line of the plot."),
    dateRangeInput(
        inputId = "daterange",
        label = "Please Select the Start and End Date",
        start = min(coronavirus$date),
        end = max(coronavirus$date)
    ),
    plotlyOutput("range_plot"),
    br()
    )


#--------------------server---------------------
server <- function(input, output, session) {

    output$selected_country <- DT::renderDataTable({

        ratios <- ratios %>%
            filter(country == input$select_country) %>%
            arrange(desc(date))

        DT::datatable(ratios, options = list(pageLengh = 15),
                      extensions = 'Responsive')

    })

    output$range_plot <- renderPlotly({

        ratios_range <- ratios %>%
            filter(country == c("Chile", "Bolivia")) %>%
            filter(date >= as.Date(input$daterange[1]) & date <= as.Date(input$daterange[2]))

        plot_range <- ratios_range %>%
            ggplot() +
            geom_line(aes(x = date, y = confirmed, color = country))

        ggplotly(plot_range)
    })


}



shinyApp(ui, server)
