#-------------------------------PREGUNTA 1----------------------------
# 1. Cargar el conjunto de datos
datos <- read.csv("datos_clientes.csv")

# 2. Visualizar las primeras filas para entender la estructura
head(datos)

# 3. Obtener un resumen descriptivo general
# Muestra mínimos, máximos, cuartiles y tipo de datos de cada columna
summary(datos)

# 4. Ver la estructura interna de los datos (opcional pero recomendado)
str(datos)



# ------------------------------PREGUNTA 2-----------------------------
# --- CÁLCULO DE MEDIDAS ESTADÍSTICAS (TENDENCIA CENTRAL Y DISPERSIÓN) ---

# 1. Cargar datos
# Se asume que el archivo "datos_clientes.csv" está en el directorio de trabajo
datos <- read.csv("datos_clientes.csv")

# 2. Definir función personalizada para la MODA
moda <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# 3. Análisis de Variable: Monto de Compra
cat("=== ESTADÍSTICAS: MONTO DE COMPRA ===\n")
# Tendencia Central
cat("Media:", mean(datos$Monto_compra), "\n")
cat("Mediana:", median(datos$Monto_compra), "\n")
cat("Moda (calculada):", moda(datos$Monto_compra), "\n")
# Dispersión
cat("Desviación Estándar:", sd(datos$Monto_compra), "\n")
cat("Rango Intercuartílico (IQR):", IQR(datos$Monto_compra), "\n\n")

# 4. Análisis de Variable: Edad del Cliente
cat("=== ESTADÍSTICAS: EDAD DEL CLIENTE ===\n")
# Tendencia Central
cat("Media:", mean(datos$Edad), "\n")
cat("Mediana:", median(datos$Edad), "\n")
cat("Moda (calculada):", moda(datos$Edad), "\n")
# Dispersión
cat("Desviación Estándar:", sd(datos$Edad), "\n")
cat("Rango Intercuartílico (IQR):", IQR(datos$Edad), "\n")

#------------------------PREGUNTA 3--------------------------------------
# --- ANÁLISIS EXPLORATORIO DE DATOS (EDA) Y VISUALIZACIÓN ---

# 1. Cargar librerías y datos
library(ggplot2)
datos <- read.csv("datos_clientes.csv")

# 2. Histograma: Distribución de la Edad de los clientes
# Ayuda a identificar el perfil demográfico principal
grafico1 <- ggplot(datos, aes(x = Edad)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "white") +
  labs(title = "Distribución de Edad de los Clientes",
       x = "Edad", y = "Frecuencia") +
  theme_minimal()

# 3. Gráfico de Barras: Preferencias por Categoría de Producto
# Permite ver qué categorías son las más vendidas
grafico2 <- ggplot(datos, aes(x = Categoria_producto)) +
  geom_bar(fill = "darkgreen") +
  labs(title = "Cantidad de Transacciones por Categoría",
       x = "Categoría", y = "Total Ventas") +
  theme_minimal()

# 4. Gráfico de Dispersión: Relación Ingresos vs. Monto de Compra
# Busca patrones o correlaciones entre poder adquisitivo y gasto
grafico3 <- ggplot(datos, aes(x = Nivel_ingresos, y = Monto_compra)) +
  geom_point(color = "darkred", alpha = 0.6) +
  labs(title = "Relación: Nivel de Ingresos vs Monto Compra",
       x = "Nivel de Ingresos", y = "Monto de Compra") +
  theme_minimal()

# 5. Visualizar los gráficos
print(grafico1)
print(grafico2)
print(grafico3)