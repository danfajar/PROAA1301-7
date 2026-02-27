# Cargar librerías necesarias
library(shiny)
library(plotly)
library(dplyr)

# Definir el conjunto de datos proporcionado
Mes <- rep(c("Enero", "Febrero", "Marzo", "Abril"), each = 3)
Producto <- rep(c("GestReservas", "GestItinerarios", "ServCliente"), times = 4)
Ventas <- c(15000, 10000, 20000, 18000, 12000, 22000, 17000, 11000, 21000, 16000, 11500, 19500)
datos_ventas <- data.frame(Mes = Mes, Producto = Producto, Ventas = Ventas)

# Ordenar los meses de forma cronológica para el gráfico
datos_ventas$Mes <- factor(datos_ventas$Mes, levels = c("Enero", "Febrero", "Marzo", "Abril"))

# 1. Definir la interfaz de usuario (UI)
ui <- fluidPage(
  titlePanel("Dashboard de Ventas - TravelTech Solutions"),
  sidebarLayout(
    sidebarPanel(
      selectInput("mes_seleccionado", 
                  "Seleccionar Mes a visualizar:", 
                  choices = c("Todos los meses", levels(datos_ventas$Mes))),
      hr(),
      helpText("Utilice este panel para filtrar las ventas mensuales según los distintos servicios ofrecidos.")
    ),
    mainPanel(
      plotlyOutput("grafico_ventas")
    )
  )
)

# 2. Definir la lógica del servidor (Server)
server <- function(input, output) {
  output$grafico_ventas <- renderPlotly({
    
    # Aplicar filtro según la selección del usuario
    if (input$mes_seleccionado == "Todos los meses") {
      datos_filtrados <- datos_ventas
    } else {
      datos_filtrados <- datos_ventas %>% filter(Mes == input$mes_seleccionado)
    }
    
    # Generar el gráfico interactivo con Plotly
    grafico <- plot_ly(datos_filtrados, x = ~Mes, y = ~Ventas, color = ~Producto, type = 'bar') %>%
      layout(title = "Comportamiento de Ventas por Mes y Servicio",
             xaxis = list(title = "Meses del Trimestre"),
             yaxis = list(title = "Cantidad de Ventas"),
             barmode = 'group')
    
    return(grafico)
  })
}

# 3. Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)