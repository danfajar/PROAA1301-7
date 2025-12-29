import matplotlib.pyplot as plt

def visualizar_satisfaccion(datos):
    """
    Función que recibe un diccionario de datos (Fecha: Calificación)
    y genera un gráfico de líneas para mostrar la evolución temporal.
    """
    # Separación de datos en ejes X e Y
    fechas = list(datos.keys())
    calificaciones = list(datos.values())

    # Configuración de la figura
    plt.figure(figsize=(10, 6))

    # Creación del gráfico de líneas
    # Se utiliza marker='o' para resaltar los puntos de datos específicos
    plt.plot(fechas, calificaciones, marker='o', linestyle='-', color='#1f77b4', label='Satisfacción Promedio')

    # Personalización (Títulos y Etiquetas)
    plt.title('Evolución de la Satisfacción del Cliente (XYZ)', fontsize=14)
    plt.xlabel('Periodo', fontsize=12)
    plt.ylabel('Calificación (Escala 1-10)', fontsize=12)
    
    # Ajustes visuales: límites y cuadrícula
    plt.ylim(0, 11) 
    plt.grid(True, linestyle='--', alpha=0.6)
    plt.legend()

    # Despliegue del gráfico
    plt.show()

# --- Bloque Principal ---

# Datos simulados de satisfacción (Diccionario Mes: Calificación)
datos_clientes = {
    'Ene-24': 6.5,
    'Feb-24': 6.8, 
    'Mar-24': 7.0, 
    'Abr-24': 7.2,
    'May-24': 6.9, 
    'Jun-24': 7.5, 
    'Jul-24': 7.8, 
    'Ago-24': 8.1,
    'Sep-24': 8.0, 
    'Oct-24': 8.5, 
    'Nov-24': 8.9, 
    'Dic-24': 9.2
}

# Ejecución de la visualización
if __name__ == "__main__":
    visualizar_satisfaccion(datos_clientes)