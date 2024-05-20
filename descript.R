df<- read.table("pokedex_stats.csv")

df %>% 
  group_by("type") %>% 
  summarize(cantidad<-n(),ataque<- mean(ataque,na.rm=T))
  