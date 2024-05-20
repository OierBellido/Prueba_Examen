df <- read.csv("BBDD_pokemon.csv")
df_desc<- read.table("BBDD_pokemon.csv")

df_desc$nombre<- tolower(df_desc$nombre)

df_juntar<- merge(df, df_desc_ by="nombre")

write.table(df_juntar)