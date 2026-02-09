# Respuesta 2
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Instalación individual de librerías
install.packages("readxl")
install.packages("tidyverse")
install.packages("caret")

# Carga de librerías
library(readxl)
library(tidyverse)
library(caret)

--------------------------------------------------------
#Respuesta 3
# 1. Importación del conjunto de datos desde Excel

library(readxl)
datos_travel <- read_excel("ventas_traveltrends.xlsx")

# 2. Exploración inicial de la estructura
# Permite entender la distribución y características claves
str(datos_travel)
summary(datos_travel)

# 3. Limpieza y Transformación
# Convertir la columna Categoria a factor para el modelado
datos_travel$Categoría <- as.factor(datos_travel$Categoría)
str(datos_travel)

# 4. Visualización para identificar patrones
library(ggplot2)
ggplot(datos_travel, aes(x = Mes, y = Ventas, fill = Categoría)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Tendencia de Ventas por Destino - TravelTrends")

# Respuesta 4
------------------------------------------------------
# 1. División de los datos (Ajustado para muestra pequeña de 12 filas)
# Se asignan 10 registros para entrenar y 2 para probar
entrenamiento <- datos_travel[1:10, ]
prueba <- datos_travel[11:12, ]

# 2. Construcción y Entrenamiento del modelo
# Se utiliza Regresión Lineal (lm) para predecir las Ventas en base al Mes y Categoría
library(caret)
set.seed(123) # Para reproducibilidad
modelo_viajes <- train(Ventas ~ ., data = entrenamiento, method = "lm")

# 3. Revisión de los resultados del entrenamiento
print(modelo_viajes)
summary(modelo_viajes)

# 4. Predicción con los datos de prueba
# Se generan las predicciones de ventas para validar el modelo
predicciones <- predict(modelo_viajes, newdata = prueba)

# Mostrar las predicciones estimadas vs los datos reales de prueba
resultados <- data.frame(Real = prueba$Ventas, Predicción = predicciones)
print(resultados)

