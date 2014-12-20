# -----------------------------------------------------------------
# ggplot2: Nubes de puntos
# -----------------------------------------------------------------
if(!is.installed('ggplot2'))
  install.packages('ggplot2')
library(ggplot2)

qplot(iris$Sepal.Length)

qplot(Sepal.Length, Sepal.Width, data=iris, colour=Species, size=Petal.Width)

# -----------------------------------------------------------------
# ggplot2: Gráfica de líneas
# -----------------------------------------------------------------
qplot(Petal.Length, Sepal.Length, data=iris, color=Species) +
  geom_line()

qplot(Petal.Length, Sepal.Length, data=iris, color=Species) +
  geom_line(aes(linetype = Species))


# -----------------------------------------------------------------
# ggplot2: Nube de puntos con regresión entre variables
# -----------------------------------------------------------------
qplot(Petal.Length, Petal.Width, data = iris, color = Species) +
  geom_point() + geom_smooth(se=F)  # Solo curva de regresión

qplot(Petal.Length, Petal.Width, data = iris, color = Species) +
  geom_point() + geom_smooth()  # Curva y error estándar

qplot(Petal.Length, Petal.Width, data = iris, color = Species) +
  geom_point() + geom_smooth(level = 0.99)  # Curva y error estándar


qplot(elevation, slope, data =
        covertype[sample(1:nrow(covertype), 500),],
      geom = c("point", "smooth"), color = wilderness_area) +
  theme_bw()

# -----------------------------------------------------------------
# ggplot2: Curva de densidad
# -----------------------------------------------------------------
ggplot(covertype, aes(x = elevation)) + geom_density()

ggplot(covertype, aes(x = elevation, fill = wilderness_area)) + geom_density()

ggplot(covertype, aes(x = elevation, color = wilderness_area)) + geom_density()

ggplot(covertype, aes(x = elevation, linetype = wilderness_area)) + geom_density()

# -----------------------------------------------------------------
# ggplot2: Composición de múltiples gráficas
# -----------------------------------------------------------------
qplot(ClosePrice, sellerRating, data =
        ebay[ebay$endDay %in% c('Wed','Thu','Fri') &
               ebay$currency != 'US',],
      facets = currency ~ endDay, color=Duration)

# La misma grafica anterior expresada de otra forma con ggplot()
grp <- ggplot(ebay[ebay$endDay %in% c('Wed','Thu','Fri') & ebay$currency != 'US',],
       aes(x = ClosePrice, y = sellerRating)) +
  geom_point(aes(color = Duration))

grp + facet_grid(currency ~ endDay) # Formato cuadrícula

grp + facet_wrap(currency ~ endDay) # Una gráfica tras otra

grp + facet_wrap(currency ~ endDay, ncol = 4) # Cuatro columnas con tantas filas como se precise

grp + facet_wrap(currency ~ endDay, scales = "free") # Escalas X/Y independientes para cada gráfica

qplot(currency, ClosePrice, data=ebay[ebay$endDay != 'Wed',],
      fill = currency) + geom_bar(stat = 'identity') +
  facet_wrap(~endDay)


# -----------------------------------------------------------------
# Dibujar funciones y polinomios
# -----------------------------------------------------------------

# Líneas a partir de función existente (tan)
x <- seq(-10, 10, .25)
y <- tan(x)
plot(x, y, type = "n")
lines(matrix(c(x,y), ncol = 2))

# Líneas a partir de función paramétrica
circle <- function(t) {
  x <- cos(t)
  y <- sin(t)
  c(x,y)
}

heart <- function(t) {
  x <- 16 * sin(t)^3
  y <- 13 * cos(t) - 5 * cos(2*t) - 2 * cos(3*t) - cos(4*t)
  c(x,y)
}

mpoints <- matrix(sapply(seq(0,2*pi,0.1), circle), ncol = 2, byrow = TRUE)
plot(mpoints)
lines(mpoints)

mpoints <- matrix(sapply(seq(0,2*pi,0.1), heart), ncol = 2, byrow = TRUE)
plot(mpoints)
lines(mpoints)

# Curva a partir de funciones existentes (sin y cos)
curve(sin, from = -4, to = 4, col = 'blue', lty = 'dotted', lwd = 2,
      ylab='sin(x) vs cos(x)', xname = "Valores de entrada")
curve(cos, from = -4, to = 4, col = 'cyan', lty = 'dashed', lwd = 2, add = TRUE)
legend("topleft", c("sin(x)", "cos(x)"), col = c('blue', 'cyan'),
       lty = c('dotted','dashed'), lwd = 2, ncol = 2)

curve(abs, from = -10, to = 10)

# Curvas a partir de polinomios
curve(x^2 - x, lty = 3, lwd = 2, from = -10, to = 10)
curve(x^3 - x^2 + 1, lty = 2, lwd = 2, from = -10, to = 10, add = TRUE)

# -----------------------------------------------------------------
# Gráfica tipo 'circos'
# -----------------------------------------------------------------
if(!is.installed('circlize'))
  install.packages('circlize')
library(circlize)
library(mldr)

labels <- emotions$dataset[ , emotions$labels$index]
nlabels <- ncol(labels)

tbl <- sapply(1:nlabels, function(ind1)
  sapply(1:nlabels, function(ind2)
    if(ind2 < ind1) sum(labels[,ind1]*labels[,ind2]) else 0
  ))
colnames(tbl) <- colnames(labels)
row.names(tbl) <- colnames(tbl)

par(mar = c(1, 1, 1, 1))

circos.par(gap.degree = 3)
chordDiagram(mat, annotationTrack = "grid", transparency = 0.5,
             preAllocateTracks = list(track.height = 0.1))
for(si in get.all.sector.index()) {
  circos.axis(h = "top", labels.cex = 0.6, sector.index = si, track.index = 2)
}
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")

  circos.lines(xlim, c(mean(ylim), mean(ylim)), lty = 3)
  for(p in seq(0, 1, by = 0.25)) {
    circos.text(p*(xlim[2] - xlim[1]) + xlim[1], mean(ylim), p, cex = 0.8, adj = c(0.5, -0.2), niceFacing = TRUE)
  }
  circos.text(mean(xlim), 1.4, sector.name, niceFacing = TRUE)
}, bg.border = NA)
circos.clear()

# -----------------------------------------------------------------
# Gráfica tipo 'spider'
# -----------------------------------------------------------------
if(!is.installed('fmsb'))
  install.packages('fmsb')
library('fmsb')
set.seed(4242)
maxmin <- data.frame(emotions=c(1, 0), corel=c(1, 0), scene=c(1, 0), yeast=c(1, 0), ebay=c(1, 0))
dat <- data.frame(emotions=runif(3,0,1), corel=runif(3,0,1), scene=runif(3,0,1), yeast=runif(3,0,1), ebay=runif(3,0,1))
dat <- rbind(maxmin,dat)

radarchart(dat, axistype=2, plty=1:3, plwd=2, vlabels=names(dat))

# -----------------------------------------------------------------
# Gráficas en 3D
# -----------------------------------------------------------------
if(!is.installed('scatterplot3d'))
  install.packages('scatterplot3d')
library('scatterplot3d')
z <- seq(-10, 10, 0.01)
x <- cos(z)
y <- sin(z)
scatterplot3d(x, y, z, highlight.3d = TRUE, col.axis = "blue",
              col.grid = "lightblue", main = "Helix", pch = 20)

if(!is.installed('lattice'))
  install.packages('lattice')
library('lattice')

z <- matrix(rnorm(625)+574,nrow=25)
z <- z + seq(50, 1, length=25)
persp(z, phi = 30, theta = 30,  zlim=c(550,650),xlab = "X", ylab = "Y", zlab='Z', main = "Elevación del terreno")


# -----------------------------------------------------------------
# Gráficos de tortuga (Logo)
# -----------------------------------------------------------------
if(!is.installed('TurtleGraphics'))
  install.packages('TurtleGraphics')
library('TurtleGraphics')

drawTriangle<- function(points){
  turtle_setpos(points[1,1],points[1,2])
  turtle_goto(points[2,1],points[2,2])
  turtle_goto(points[3,1],points[3,2])
  turtle_goto(points[1,1],points[1,2])
}
getMid<- function(p1,p2) c((p1[1]+p2[1])/2, c(p1[2]+p2[2])/2)
sierpinski <- function(points, degree){
  drawTriangle(points)
  if (degree  > 0){
    p1 <- matrix(c(points[1,], getMid(points[1,], points[2,]),
                   getMid(points[1,], points[3,])), nrow=3, byrow=TRUE)

    sierpinski(p1, degree-1)
    p2 <- matrix(c(points[2,], getMid(points[1,], points[2,]),
                   getMid(points[2,], points[3,])), nrow=3, byrow=TRUE)

    sierpinski(p2, degree-1)
    p3 <- matrix(c(points[3,], getMid(points[3,], points[2,]),
                   getMid(points[1,], points[3,])), nrow=3, byrow=TRUE)
    sierpinski(p3, degree-1)
  }
  invisible(NULL)
}
turtle_init(520, 500, "clip")
p <- matrix(c(10, 10, 510, 10, 250, 448), nrow=3, byrow=TRUE)
turtle_col("red")
turtle_do(sierpinski(p, 6))
turtle_setpos(250, 448)

turtle_init()
turtle_do({
  for(j in 1:45) {
    for(i in 1:6) {
      turtle_forward(20)
      turtle_right(360/6)
    }
    turtle_right(360/45)
  }
})
