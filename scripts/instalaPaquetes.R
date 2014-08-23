# -----------------------------------------------------------------
# Instalación de paquetes necesarios para el curso
# -----------------------------------------------------------------

# Función para verificar si un paquete está instalado o no
is.installed <- function(paquete) is.element(
  paquete, installed.packages())

if(!is.installed('sos'))  
  install.packages("sos")

if(!is.installed('XLConnect'))
  install.packages('XLConnect')

if(!is.installed('xlsx'))
  install.packages('xlsx')

if(!is.installed('foreign'))
  install.packages('foreign')

if(!is.installed('RWeka'))
  install.packages('RWeka')

if(!is.installed('RCurl'))
  install.packages('RCurl')

if(!is.installed('Hmisc'))
  install.packages('Hmisc')

if(!is.installed('ellipse'))
  install.packages('ellipse')

if(!is.installed('animation'))
  install.packages('animation')

if(!is.installed('ggplot2'))
  install.packages('ggplot2')

if(!is.installed('circlize'))
  install.packages('circlize')

if(!is.installed('fmsb'))
  install.packages('fmsb')

if(!is.installed('scatterplot3d'))
  install.packages('scatterplot3d')

if(!is.installed('lattice'))
  install.packages('lattice')

if(!is.installed('TurtleGraphics'))
  install.packages('TurtleGraphics')

if(!is.installed('xtable'))
  install.packages('xtable')

if(!is.installed('texreg'))
  install.packages('texreg')
