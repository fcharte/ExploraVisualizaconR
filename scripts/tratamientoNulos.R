# -----------------------------------------------------------------
# Problemática
# -----------------------------------------------------------------
valores <- as.integer(runif(50,1,10)) # Número de horas trabajadas semanalmente en una encuesta
indices <- as.integer(runif(5,1,50))  # Sin respuesta 5 casos
valores[indices] <- NA

valores
valores > 5 # Los valores NA no pueden ser comparados
valores + 10 # Ni se puede operar con ellos
mean(valores)

# -----------------------------------------------------------------
# Tratar valores ausentes
# -----------------------------------------------------------------
is.na(valores)
any(is.na(valores))
na.fail(valores)

valores2 <- na.omit(valores)
str(valores2)

valores2 > 5 
valores2 + 10 
mean(valores2)

nrow(airquality)
nrow(na.omit(airquality))
nrow(airquality[complete.cases(airquality),])

promedio <- mean(valores, na.rm = TRUE)
promedio
valores[is.na(valores)] <- promedio
mean(valores)

lm(Solar.R ~ Temp, airquality, na.action=na.omit)

