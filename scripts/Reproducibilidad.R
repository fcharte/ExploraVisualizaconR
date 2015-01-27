# -----------------------------------------------------------------
# Exportación de resultados a LaTeX y HTML
# -----------------------------------------------------------------
if(!is.installed('xtable'))
  install.packages('xtable')
library('xtable')

# Preparar una tabla por cada categoría existente.
tabla <- lapply(split(ebay[,-1], ebay$Category), xtable)
str(tabla) # Comprobamos la estructura de las tablas que hemos obtenido

print(tabla$Books[1:5,], digits=2, include.rownames=FALSE) # Tabla de una categoría sin nombres de fila
print(tabla$Books[1:5,], tabular.environment = "longtable", floating = FALSE) # Cambiando el entorno a longtable
strwrap(print(tabla$Books[1:5,], type='HTML')) # Generación de la tabla en HTML

# Cada tabla podria escribirse en un archivo distinto e importarse desde el documento principal
print(tabla$Books[1:5,], digits=2, include.rownames=FALSE, file = "tablaBooks.tex")
print(tabla$Books[1:5,], digits=2, include.rownames=FALSE, type = "HTML", file = "tablaBooks.html")
file.show("tablaBooks.tex") # Mostrar los archivos en la aplicación asociada por defecto
file.show("tablaBooks.html")

# -----------------------------------------------------------------
# Exportación de resultados: paquete Hmisc
# -----------------------------------------------------------------
if(!is.installed('Hmisc'))
  install.packages('Hmisc')
library('Hmisc')

tabla <- latex(ebay[ebay$Category=='Books',][1:5,])
readLines(tabla$file)

# -----------------------------------------------------------------
# Exportación de resultados de tests y modelos estadísticos
# -----------------------------------------------------------------
if(!is.installed('texreg'))
  install.packages('texreg')
library('texreg')

modelo1 <- lm(Sepal.Length ~ Sepal.Width, iris)
modelo2 <- lm(Petal.Width ~ Sepal.Width, iris)
modelo1
str(modelo1)

screenreg(list(modelo1, modelo2), custom.model.names=c('Sepal length', 'Petal width'))
texreg(list(modelo1, modelo2), custom.model.names=c('Sepal length', 'Petal width'))
htmlreg(list(modelo1, modelo2), custom.model.names=c('Sepal length', 'Petal width'))
