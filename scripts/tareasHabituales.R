
# -----------------------------------------------------------------
# Acceso a la ayuda
# -----------------------------------------------------------------
help('source')
vignette('grid')
demo('image')

# -----------------------------------------------------------------
# Ruta de trabajo
# -----------------------------------------------------------------
getwd()
rutaPrevia <- getwd()

setwd('../data')
getwd()

# Trabajar con los datos y después restablecer la ruta previa
setwd(rutaPrevia)


# -----------------------------------------------------------------
# Guardar y recuperar objetos R
# -----------------------------------------------------------------
rutaPrevia
save(rutaPrevia, file = 'ruta.RData')

rm(rutaPrevia)
rutaPrevia

load('ruta.RData')
rutaPrevia


# -----------------------------------------------------------------
# Cargar e instalar paquetes
# -----------------------------------------------------------------
library(utils)  # El paquete está disponible, no hay problema

library(openxlsx)  # El paquete no está disponible
require(openxlsx) 

# Función para verificar si un paquete está instalado o no
is.installed <- function(paquete) is.element(
  paquete, installed.packages())

# Comprobamos la disponibilidad de un paquete
is.installed('XLConnect')

# Antes de intentar cargar un paquete comprobamos si está disponible y, si es preciso, lo instalamos
if(!is.installed('sos'))  
  install.packages("sos")
library("sos")

findFn("excel")  # Buscar paquetes en los que aparezca la cadena 'excel'


