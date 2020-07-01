library(shiny)
library(DBI)
library(RMariaDB)
library(pool)

drv <- dbDriver("MariaDB")
con <- dbPool(drv, username="root", password="", dbname ="jdbc", host="localhost")


ui <- fluidPage(
  numericInput("nrows", "Enter the number of rows to display:", 5),
  tableOutput("tbl")
)

server <- function(input, output, session) {
  output$tbl <- renderTable({
    dbGetQuery(con, paste0(
      "SELECT * FROM employee LIMIT ", input$nrows, ";"))
  })
}

shinyApp(ui,server)