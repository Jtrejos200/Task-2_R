# Jaime Andrés Trejos -201914673

# Taller B

# librerias
rm(list=ls())
require(pacman)
p_load(tidyverse)
p_load(rio)


# Definir el direcorio de trabajo
setwd("D:/Documents/task_2/task_2/data")

# Punto 1.0: Crear una lista

chip <- list()

# Punto 1.1: Importar datos con un loop

# Son como 80 archivos .xls en 4 carpetas. Para importarlos necesitamos construir
# una lista con los nombres y la ruta de cada archivo para poder aplicarle a cada
# uno la funcion import

# Ejemplo para el primer archivo de la carpeta 2017

filename <- list.files("imput/2017")[1]

chip[1] <- import(file = paste0("imput/2017/",filename))

# Obtiene la lista de los 80 nombres de archivos .xls y los guarda en la lista nombres
nombres = lapply(2017:2020 , function(x) list.files(paste0("imput/",x),full.names=T)) %>%
  unlist()

# Inicio de la lista de nombres
head(nombres)

# Final de la lista de nombres
tail(nombres)

# Ciclo para aplicarle import() a cada nombre de archivo
for (i in 1:length(nombres)){
  chip[[i]] = import(file = nombres[i])  
}

# Verificacion de la lista

chip[1]
chip[[10]][2,1]
colnames(chip[[1]])[1]


# Punto 2.0: Crear funcion

f_extrac = function(lista,n,tipo_rubro){ #definimos los argumentos de la función
  lista_n = lista[[n]] #Extrae dataframe correspondiente al argumento n
  codigo = colnames(lista_n)[1] #obtiene codigo DANE de municipio
  colnames(lista_n) = lista_n[7,] #ajusta nombres de columnas
  periodo = lista_n[2,1] #Obtiene el periodo
  valor = lista_n %>% subset(NOMBRE==tipo_rubro) %>% select(`PAGOS(Pesos)`) #obtiene valor de pago para rubro correspondiente
  return(c(valor, periodo, codigo))  #obtenemos en formato vector
}


f_extrac(lista = chip , n = 10 , tipo_rubro = "TOTAL INVERSIÓN") #Función

# Punto 3.0: Apply

for (i in 1:length(nombres)){
  print(f_extrac(lista = chip , n = i , tipo_rubro = "EDUCACIÓN"))
}
#Loop que aplica la función a toda la lista
