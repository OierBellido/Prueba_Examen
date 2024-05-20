library(httr)
library(jsonlite)
library(tibble)


url_base <- "https://pokeapi.co/api/v2/"


busqueda_pokemon <- "pokemon/"

nombre <- c()
experiencia_base <- c()
vida <- c()
ataque <- c()
defensa <- c()
ataque_especial <- c()
defensa_especial <- c()
velocidad <- c()
abilidad <- c()
tipo <- c()
tipo_secundario <- c()

for(i in 1:151){
  url_pokemon <- paste(url_base, busqueda_pokemon,i, sep="")
  
  respense <- httr::GET(
    url = url_pokemon
  )
  
  #print(c(i,respense$status_code))
  
  if(respense$status_code == 200){
    
    contenido <- httr::content(respense, as = "text", encoding = "UTF-8")
    
    datos <- jsonlite::fromJSON(contenido)
    
    nombre <- append(nombre, datos$name)
    experiencia_base <- append(experiencia_base,datos$base_experience)
    vida <- append(vida,datos$stats$base_stat[1])
    ataque <- append(ataque,datos$stats$base_stat[2])
    defensa <- append(defensa,datos$stats$base_stat[3])
    ataque_especial <- append(ataque_especial,datos$stats$base_stat[4])
    defensa_especial <- append(defensa_especial,datos$stats$base_stat[5])
    velocidad <- append(velocidad,datos$stats$base_stat[6])
    
    abilidad <- append(abilidad,datos$abilities$ability$name[1])
    
    tipos <- datos$types$type$name
    
    tipo <- append(tipo, tipos[1])
    
    if(length(tipos) ==2){
      tipo_secundario <- append(tipo_secundario,tipos[2])
    }
    else{
      tipo_secundario <- append(tipo_secundario,NA)
    }
    
    
  }
  
  Sys.sleep(1)
  
}



df_pokemon <- data.frame(nombre = nombre,
                         experiencia_base = experiencia_base,
                         vida = vida,
                         ataque = ataque,
                         defensa = defensa,
                         ataque_especial = ataque_especial,
                         defensa_especial = defensa_especial,
                         velocidad = velocidad,
                         abilidad = abilidad,
                         tipo = tipo,
                         tipo_secundario = tipo_secundario)





write.table(df_pokemon, "BBDD_pokemon.csv")



