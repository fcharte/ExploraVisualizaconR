# -----------------------------------------------------------------
# Nubes de puntos
# -----------------------------------------------------------------
plot(iris$Sepal.Length)

plot(iris$Sepal.Length, iris$Sepal.Width)

plot(iris$Sepal.Length, iris$Sepal.Width, col=iris$Species)

plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species,  
     xlab = 'Longitud del pétalo', ylab = 'Ancho del pétalo')
title(main = 'IRIS', 
      sub = 'Exploración de los pétalos según especie', 
      col.main = 'blue', col.sub = 'blue')

# -----------------------------------------------------------------
# Gráfica de cajas
# -----------------------------------------------------------------
plot(iris$Petal.Length ~ iris$Species)

boxplot(iris$Petal.Length ~ iris$Species)
title(main = 'IRIS', ylab = 'Longitud pétalo', sub = 'Análisis de pétalo por familia')

# -----------------------------------------------------------------
# Gráfica de líneas
# -----------------------------------------------------------------
ebayPerCurr <- split(ebay, ebay$currency) # Separar por moneda
endPricePerDay <- lapply(ebayPerCurr, function(curr) split(curr$ClosePrice, curr$endDay))  # En cada moneda, separar por dias
meanPricesUS <- sapply(endPricePerDay$US, mean) # Precio medio de cierre para moneda
meanPricesEUR <- sapply(endPricePerDay$EUR, mean)
meanPricesUS[is.na(meanPricesUS)] <- mean(meanPricesUS, na.rm = T)
rango <- range(meanPricesUS, meanPricesEUR) # Obtener el rango a representar

plot(meanPricesUS, type = "o", axes = F, ann = F, col = "blue", ylim = rango)
lines(meanPricesEUR, type = "o", col = "red")
axis(1, at = 1:length(meanPricesUS), lab = names(meanPricesUS))
axis(2, at = 3*0:rango[2], las = 1)
title(main = 'Precio de cierre según día', xlab = 'Día', ylab = 'Precio final')
legend("bottomright", c("$","€"), col=c("blue","red"), lty=c(1,1))

# -----------------------------------------------------------------
# Gráfica de barras
# -----------------------------------------------------------------
barplot(sapply(endPricePerDay$EUR, length), col = rainbow(7))
title(main='Número de operaciones por día')


accuracy <- aggregate(Accuracy ~ Algorithm, results, mean)
precision <- aggregate(Precision ~ Algorithm, results, mean)

valMedios <- matrix(c(precision$Precision, accuracy$Accuracy), nrow=6, ncol=2)
rownames(valMedios) <- accuracy$Algorithm
barplot(valMedios, beside=T, horiz = T, col = cm.colors(6), legend.text=T, names.arg = c('Accuracy', 'Precision'))

# -----------------------------------------------------------------
# Gráfica de sectores
# -----------------------------------------------------------------
opPorCategoria <- aggregate(ClosePrice ~ Category, ebay, length)[1:8,]
colores <- topo.colors(length(opPorCategoria$Category))
pie(opPorCategoria$ClosePrice, labels=opPorCategoria$ClosePrice, col = colores, main='Productos por categoría')
legend("bottom", "Categoría", opPorCategoria$Category, cex=0.6, fill = colores, ncol = 4)

# -----------------------------------------------------------------
# Histogramas
# -----------------------------------------------------------------
hist(covertype$elevation, main='Elevación del terreno', xlab='Metros')

# Los histogramas son objetos
histograma <- hist(covertype$elevation, breaks=100, main='Elevación del terreno', xlab='Metros')
histograma # Podemos ver la información generada
# Y usarla para personalizar el resultado
plot(histograma, col=ifelse(histograma$breaks < 2500, 'green', ifelse(histograma$breaks > 3000, "red", "blue")), main='Elevación del terreno', xlab='Metros')

hist(covertype$elevation, breaks=12, col=rainbow(12), main='Elevación del terreno', xlab='Metros')

hist(covertype$elevation, prob=T, col="grey", main='Elevación del terreno', xlab='Metros')
lines(density(covertype$elevation, adjust=5), col='black', lwd=3)

plot(density(covertype$elevation, adjust=5), col='black', lwd=3)

plot(density(rnorm(1000), adjust=3), col='blue', lwd=4, main='Distribución normal', xlab='Valores')

hist(iris)

# -----------------------------------------------------------------
# Gráficas múltiples
# -----------------------------------------------------------------
plot(iris[,1:4],col=iris$Species) # Combinaciones de atributos de iris

# Análisis de la correlación entre las mismas variables anteriores
if(!is.installed('ellipse'))
  install.packages('ellipse')
library(ellipse)

plotcorr(cor(iris[,1:4]),col=heat.colors(10))

# Composición usando matriz nXm de gráficas
prev <- par(mfrow=c(2,2))
plot(iris$Sepal.Length,iris$Sepal.Width,col=iris$Species)
plot(iris$Petal.Length,iris$Petal.Width,col=iris$Species)
plot(iris$Sepal.Length,iris$Petal.Width,col=iris$Species)
plot(iris$Petal.Length,iris$Sepal.Width,col=iris$Species)
par(prev)

# Composición usando distribución libre
layout(matrix(c(1,1,2,3), 2, 2, byrow = T))
hist(ebay$Duration, main='Duración subasta',xlab='Días')
barplot(sapply(endPricePerDay$EUR, length), col = rainbow(7),horiz=T,las=1)
title(main='Operaciones por día')
plot(meanPricesEUR, type = "o", axes = F, ann=F)
title(main = 'Precio cierre por día', ylab='Euros', xlab='Día')
axis(1, at = 1:length(meanPricesEUR), lab = names(meanPricesEUR), las=2)
axis(2, at = 3*0:rango[2], las = 1)
par(prev)

# -----------------------------------------------------------------
# Guardar gráficas
# -----------------------------------------------------------------
pdf('AnalisisSubastas.pdf', width=8.3, height=11.7)
hist(ebay$Duration, main='Duración subasta',xlab='Días')
barplot(sapply(endPricePerDay$EUR, length), col = rainbow(7),horiz=T,las=1)
title(main='Operaciones por día')
plot(meanPricesEUR, type = "o", axes = F, ann=F)
title(main = 'Precio cierre por día', ylab='Euros', xlab='Día')
axis(1, at = 1:length(meanPricesEUR), lab = names(meanPricesEUR), las=2)
axis(2, at = 3*0:rango[2], las = 1)
dev.off()
system("open AnalisisSubastas.pdf")

# -----------------------------------------------------------------
# Generar animaciones
# -----------------------------------------------------------------
if(!is.installed('animation'))
  install.packages('animation')
library('animation')

saveGIF({
  for(lim in seq(-3.14,3.14,by=0.1)) {
    curve(sin, from=lim, to=lim + 9.42)
  }
}, movie.name = "D:/animacion.gif", interval=0.1, ani.width = 640, ani.height = 640)
system("open D:/animacion.gif")
