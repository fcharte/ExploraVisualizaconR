# -----------------------------------------------------------------
# Importar datos de archivos CSV
# -----------------------------------------------------------------
results <- read.csv('data/results.csv')
class(results)
str(results)
head(results[,c('Algorithm','Dataset','Accuracy')])

# -----------------------------------------------------------------
# Importar datos Excel
# -----------------------------------------------------------------
if(!is.installed('XLConnect'))
  install.packages('XLConnect')
library('XLConnect')

ebay <- readWorksheetFromFile('data/eBayAuctions.xls',sheet=1)
class(ebay)
str(ebay)
tail(ebay)

# -----------------------------------------------------------------
# Escribir y leer datos de Excel
# -----------------------------------------------------------------
if(!is.installed('xlsx'))
  install.packages('xlsx')
library('xlsx')

write.xlsx(results, file = 'data/results.xlsx', sheetName = 'Resultados')

ebay <- read.xlsx('data/eBayAuctions.xls', sheetIndex=1)
class(ebay)
str(ebay)
tail(ebay)


# -----------------------------------------------------------------
# Importar datos en formato ARFF
# -----------------------------------------------------------------
if(!is.installed('foreign'))
  install.packages('foreign')
library('foreign')


if(!is.installed('RWeka'))
  install.packages('RWeka')
library('RWeka')

covertype <- read.arff('data/covertype.arff')
class(covertype)
str(covertype)
head(covertype)

# -----------------------------------------------------------------
# Copiar información a y desde el portapapeles
# -----------------------------------------------------------------
write.table(results[1:100,], 'clipboard', sep='\t')
partial.results <- read.delim('clipboard')

# -----------------------------------------------------------------
# Obtener datos a partir de una URL
# -----------------------------------------------------------------
if(!is.installed('RCurl'))
  install.packages('RCurl')
library('RCurl')

url <- getURL('https://raw.githubusercontent.com/fcharte/CursoUNIA14/master/data/results.csv',ssl.verifypeer = FALSE)
results2 <- read.csv(textConnection(url))
str(results2)

# -----------------------------------------------------------------
# Datasets integrados
# -----------------------------------------------------------------
library(datasets)
data()
str(iris)
head(iris)
