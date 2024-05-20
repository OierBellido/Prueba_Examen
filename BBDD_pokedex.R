library(httr)
library(jsonlite)
library(tibble)


url_base <- "https://pokeapi.co/api/v2/"


busqueda_pokemon <- "pokemon-species/"

nombre <- c()
descripcion <- c()


for(i in 1:151){
  url_pokemon <- paste(url_base, busqueda_pokemon,i, sep="")
  
  respense <- httr::GET(
    url = url_pokemon
  )
  
  #print(c(i,respense$status_code))
  
  if(respense$status_code == 200){
    
    contenido <- httr::content(respense, as = "text", encoding = "UTF-8")
    
    datos <- jsonlite::fromJSON(contenido)
    
    nombre <- append(nombre, datos$names$name[datos$names$lenguaje$name == "en"])
    descripcion <- append(descripcion,datos$base_experience)
    
  }
  
  Sys.sleep(1)
  
}



df_pokemon <- data.frame(nombre = nombre,
                         descripcion = descripcion,
)





write.table(df_pokemon, "BBDD_pokemon.csv")