# -----------------------------------------------------------------
# Exploración del contenido
# -----------------------------------------------------------------
class(iris)  # Clase del objeto
typeof(iris) # Tipo del objeto
str(iris)    # Información sobre su estructura

summary(iris) # Resumen de contenido
head(iris)  # Primeras filas 
tail(iris)  # Últimas filas
# Selección de filas y columnas
iris$Sepal.Length[which(iris$Species == 'versicolor')] 

# -----------------------------------------------------------------
# Estadística descriptiva
# -----------------------------------------------------------------
unlist(list(
  media = mean(valores), 
  desviacion = sd(valores), 
  varianza = var(valores),
  minimo = min(valores), 
  maximo = max(valores),
  mediana = median(valores),
  rango = range(valores),
  quartiles = quantile(valores)))

mean(iris$Sepal.Length)
lapply(iris[,1:4], mean)
mean(iris$Sepal.Length[which(iris$Species == 'versicolor')])
mean(subset(iris, Species == 'versicolor', select=Sepal.Length)$Sepal.Length)
sapply(unique(iris$Species), function(specie) mean(iris$Sepal.Length[iris$Species == specie]))

# Hmisc
if(!is.installed('Hmisc'))
  install.packages('Hmisc')
library('Hmisc')
describe(ebay)

# -----------------------------------------------------------------
# Agrupamiento de datos
# -----------------------------------------------------------------
table(iris$Sepal.Length,iris$Species)  # Conteo para cada lóngitud de sépalo por especie
tail(table(ebay$sellerRating, ebay$currency))  # Los vendedores con mejor reputación operan en dólares

cortes <- seq(from=4, to=8, by=0.5)
seplen <- cut(iris$Sepal.Length,breaks=cortes)  # Discretizar la longitud de sépalo
table(seplen, iris$Species)  

# split, sample, subset
bySpecies <- split(iris,iris$Species) # Separar en grupos segun un factor
str(bySpecies)
mean(bySpecies$setosa$Sepal.Length)

str(covertype)  
subset(covertype, slope > 45 & soil_type == '1', select=c(elevation, slope, class)) # Selección de filas y columnas

subcovertype <- covertype[sample(1:nrow(covertype), nrow(covertype)*.1),] # Selección aleatoria
str(subcovertype)

# -----------------------------------------------------------------
# Ordenación de datos
# -----------------------------------------------------------------
sort(valores)
order(valores)
rank(valores)
rank(valores, ties.method='first')
# Ordenar un data frame por una cierta columna
sortedIris <- iris[order(iris$Petal.Length),]
head(sortedIris)

# -----------------------------------------------------------------
# Particionamiento de datos
# -----------------------------------------------------------------

# Primeras n filas para training restantes para test
nTraining <- as.integer(nrow(iris)*.75)
training <- iris[1:nTraining,]
test <- iris[(nTraining+1):nrow(iris),]
nrow(training) + nrow(test) == nrow(iris)

# Otra forma
set.seed(4242)
indices <- sample(1:nrow(iris),nTraining)
particion <- list(training=iris[indices,], test=iris[-indices,])
lapply(particion,nrow)
particion$test


pb <- winProgressBar(title="Estado del proceso", label="0% terminado", min=0, max=100, initial=0)

for(i in 1:100) {
  Sys.sleep(0.1) 
  info <- sprintf("%d%% terminado", round((i/100)*100))
  setWinProgressBar(pb, i/(100)*100, label=info)
}

close(pb)