# ==============================================================================
# SCRIPT: MANIPULACIÓN DE DATOS - DEPARTAMENTO DE I+D FARMACÉUTICA
# ASIGNATURA: PROGRAMACIÓN AVANZADA PARA EL ANÁLISIS DE DATOS
# OBJETIVO: PROCESAR DATOS DE ENSAYOS CLÍNICOS PARA ASEGURAR CALIDAD Y EFICACIA
# ==============================================================================

# 1. CARGA DE DEPENDENCIAS
# Se utiliza la librería 'dplyr' para optimizar el flujo de trabajo de datos.
library(dplyr)

# 2. IMPORTACIÓN DEL CONJUNTO DE DATOS (DATASET)
# Nota: El archivo fuente debe estar ubicado en el directorio raíz del proyecto.
datos_rd <- read.csv("datos_farmaceuticos.csv", stringsAsFactors = FALSE)

# 3. LIMPIEZA: ELIMINACIÓN DE REGISTROS DUPLICADOS
# Se remueven redundancias para evitar sesgos estadísticos en los resultados.
datos_unicos <- datos_rd %>% 
  distinct()

# 4. PROCESAMIENTO: FILTRADO POR CRITERIO DE ÉXITO
# Seleccionamos únicamente los casos con eficacia superior al 80% para análisis crítico.
datos_filtrados <- datos_unicos %>% 
  filter(resultado_eficacia > 80)

# 5. ESTRUCTURACIÓN: ORDENAMIENTO POR GRUPOS DE EDAD
# Organización de la data de forma descendente para inspeccionar pacientes de mayor edad.
datos_ordenados <- datos_filtrados %>% 
  arrange(desc(edad))

# 6. ANÁLISIS DE AGREGACIÓN: RESUMEN POR MEDICAMENTO
# Agrupamos por fármaco para calcular indicadores clave de rendimiento (KPIs).
resumen_final <- datos_ordenados %>%
  group_by(medicamento) %>%
  summarise(
    n_pacientes = n(),
    eficacia_media = round(mean(resultado_eficacia), 2)
  )

# 7. VISUALIZACIÓN DE RESULTADOS EN CONSOLA
cat("\n--- INFORME RESUMIDO DE EFICACIA FARMACÉUTICA ---\n")
print(resumen_final)