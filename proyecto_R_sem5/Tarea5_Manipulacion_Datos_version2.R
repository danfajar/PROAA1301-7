# ==============================================================================
# SCRIPT: OPERACIONES AVANZADAS E INTEGRACIÓN DE DATOS
# ASIGNATURA: PROGRAMACIÓN AVANZADA PARA EL ANÁLISIS DE DATOS
# VERSION 2.0
# ==============================================================================

# 1. CARGA DE LIBRERÍAS
library(dplyr)

# 2. CARGA DE DATASETS (Clínicos y Demográficos)
datos_clinicos <- read.csv("datos_farmaceuticos.csv", stringsAsFactors = FALSE)
datos_demograficos <- read.csv("pacientes_info.csv", stringsAsFactors = FALSE)

# Limpieza preventiva (conversión de tipos y eliminación de NA)
datos_clinicos$resultado_eficacia <- as.numeric(datos_clinicos$resultado_eficacia)
datos_clinicos <- na.omit(datos_clinicos)

# 3. OPERACIÓN DE UNIÓN (JOIN)
# Combinamos ambos datasets usando 'id_paciente' como clave única.
datos_completos <- inner_join(datos_clinicos, datos_demograficos, by = "id_paciente")

# 4. OPERACIÓN DE SELECCIÓN
# Nos quedamos solo con las variables relevantes para el reporte.
datos_seleccionados <- datos_completos %>% 
  select(id_paciente, medicamento, resultado_eficacia, edad, ciudad, grupo_riesgo)

# 5. OPERACIÓN DE FILTRADO
# Analizamos solo pacientes de la ciudad de 'Santiago' con eficacia > 60.
datos_filtrados <- datos_seleccionados %>% 
  filter(ciudad == "Santiago" & resultado_eficacia > 60)

# 6. OPERACIÓN DE TRANSFORMACIÓN (MUTATE)
# Creamos una nueva variable categórica para clasificar la eficacia.
datos_transformados <- datos_filtrados %>% 
  mutate(clasificacion_exito = ifelse(resultado_eficacia >= 85, "Alto", "Moderado"))

# 7. OPERACIÓN DE AGREGACIÓN
# Resumimos los resultados por 'medicamento' y 'clasificacion_exito'.
reporte_final <- datos_transformados %>% 
  group_by(medicamento, clasificacion_exito) %>% 
  summarise(
    total_pacientes = n(),
    promedio_edad = round(mean(edad), 1),
    promedio_eficacia = round(mean(resultado_eficacia), 1)
  )

# 8. VISUALIZACIÓN
cat("\n--- REPORTE INTEGRADO: SANTIAGO ---\n")
print(reporte_final)