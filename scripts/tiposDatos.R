# -----------------------------------------------------------------
# Tipos de datos simples
# -----------------------------------------------------------------
class(45)
class(34.5)
class("R")
class(TRUE)
class(Inf)
class(1+2i)
class(NaN)

typeof(45)
typeof(34.5)
typeof("R")
typeof(TRUE)
typeof(Inf)
typeof(1+2i)
typeof(NaN)


# -----------------------------------------------------------------
# Asignación de valores a variables
# -----------------------------------------------------------------
a <- 45
a

a = 3.1416
a

"Hola" -> a
a

is.integer(a)
is.character(a)

# -----------------------------------------------------------------
# Variables en el espacio de trabajo
# -----------------------------------------------------------------
ls()
rm(a)
ls()


# -----------------------------------------------------------------
# Vectores: Creación 
# -----------------------------------------------------------------
diasMes <- c(31,29,31,30,31,30,31,31,30,31,30,31)
dias <- c('Lun','Mar','Mié','Jue','Vie','Sáb','Dom')

diasMes
dias

quincena <- 16:30
quincena

semanas <- seq(1,365,7)
semanas

rep(T,5)
c(rep(T,5),rep(F,5))
rep(c(T,F), 5)

# -----------------------------------------------------------------
# Vectores: Acceso al contenido
# -----------------------------------------------------------------
length(dias)
length(semanas)

dias[2]  	# Solo el segundo elemento
dias[-2]	# Todos los elementos menos el segundo
dias[c(3,7)]# Los elementos 3 y 7

length(5)
5[1]

# -----------------------------------------------------------------
# Vectores: Generación de valores aleatorios
# -----------------------------------------------------------------
set.seed(4242)
rnorm(100, mean=10, sd=3)
loto <- as.integer(runif(6, min=1, max=49))
loto

# Diferencia entre rnorm (distribución normal) y runif (distribución uniforme)
prev <- par(mfrow=c(1,2))
hist(rnorm(1000))
hist(runif(1000))
par(prev)


# -----------------------------------------------------------------
# Vectores: Operar sobre vectores completos
# -----------------------------------------------------------------
vect1 <- rnorm(100000)
vect2 <- rnorm(100000)

vect3 <- c()
system.time(
  for(idx in 1:length(vect1))
    vect3[idx] <- vect1[idx] * vect1[idx] + vect2[idx]
)

system.time(vect4 <- vect1 * vect1 + vect2)

stopifnot(vect3 == vect4) # Detener el programa si el resultado no es idéntico


# -----------------------------------------------------------------
# Matrices: Creación de una matriz
# -----------------------------------------------------------------
mes <- matrix(1:35,ncol=7)  # Dos formas de generar exactamente
mes <- matrix(1:35,nrow=5) # la misma matriz
mes

mes <- matrix(1:35,nrow=5,ncol=7,byrow=T)
length(mes)
nrow(mes)
ncol(mes)
dim(mes)

# -----------------------------------------------------------------
# Matrices: Conversión de un vector en una matriz
# -----------------------------------------------------------------
is.matrix(vect4)
dim(vect4)

dim(vect4) <- c(1000, 100)
is.matrix(vect4)
dim(vect4)

# -----------------------------------------------------------------
# Matrices: Acceso a los elementos
# -----------------------------------------------------------------
mes[2,]
mes[,2]
mes[2,5]

# -----------------------------------------------------------------
# Matrices: Nombres de columnas y de filas
# -----------------------------------------------------------------
rownames(mes) <- c('Semana1','Semana2','Semana3','Semana4','Semana5')
colnames(mes) <- dias
mes
attributes(mes)

mes[,'Jue']
mes['Semana4',]

# -----------------------------------------------------------------
# Matrices: Otras operaciones
# -----------------------------------------------------------------
fix(mes)
str(mes)

# -----------------------------------------------------------------
# Factors
# -----------------------------------------------------------------
mdias <- c(dias[as.integer(runif(1000,0,7)+1)])
mdias[1:10]
object.size(mdias)

fdias <- factor(mdias)
fdias[1:10]
object.size(fdias)

nlevels(fdias)
levels(fdias)
levels(fdias)[1] <- 'Sun'

peso <- ordered(c('Ligero','Medio','Pesado'))
tam <- peso[c(sample(peso,25,replace=T))]
tam
tam[2] < tam[1]

dias[3]
fdias[3]
as.numeric(fdias[3])
as.numeric(dias[3])


