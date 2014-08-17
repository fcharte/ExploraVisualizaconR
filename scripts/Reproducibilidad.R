# -----------------------------------------------------------------
# Exportación de resultados a LaTeX y HTML
# -----------------------------------------------------------------
if(!is.installed('xtable'))
  install.packages('xtable')
library('xtable')

# Preparar una tabla por cada categoría existente. Cada una podria escribirse en un archivo distinto e importarse desde el documento principal
tabla <- lapply(split(ebay[,-1], ebay$Category), xtable)
print(tabla$Books[1:5,], digits=2, include.rownames=FALSE)
print(tabla$Books[1:5,], tabular.environment = "longtable", floating = FALSE)
strwrap(print(tabla$Books[1:5,], type='HTML'))

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
