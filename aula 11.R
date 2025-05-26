# INSTALAR OS PACOTES NECESSÁRIOS
install.packages("gganimate")
install.packages("gifski")
install.packages("transformr")
install.packages("av")           # Para renderizar em vídeo
install.packages("GetBCBData")

# CARREGAR AS BIBLIOTECAS
library(GetBCBData)
library(tidyverse)
library(gganimate)
library(gifski)
library(transformr)
library(av)

# BAIXAR A SÉRIE TEMPORAL DO CDI
my.id <- c(cdi = 11)

df.bcb <- gbcbd_get_series(
  id = my.id,
  first.date = '2000-01-01',
  last.date = Sys.Date(),
  format.data = 'long',
  use.memoise = TRUE,
  cache.path = tempdir(),
  do.parallel = FALSE)

# VERIFICAR A ESTRUTURA DOS DADOS
glimpse(df.bcb)

# SALVAR A DATA INICIAL PARA O SUBTÍTULO
data_inicial <- min(df.bcb$ref.date)

# CRIAR O GRÁFICO ANIMADO
p_animado <- ggplot(df.bcb, aes(x = ref.date, y = value)) +
  geom_line(color = "#2C3E50") +
  labs(
    title = 'CDI Diário',
    subtitle = paste0('De ', data_inicial, ' até {frame_time}'),
    x = '', y = 'Taxa de juros CDI (% a.d.)') +
  theme_light() +
  transition_reveal(ref.date)

# RENDERIZAR COMO GIF
animate(
  p_animado,
  duration = 10, fps = 30,
  width = 800, height = 500,
  renderer = gifski_renderer("cdi_animated.gif"))

# RENDERIZAR COMO MP4
animate(
  p_animado,
  duration = 10, fps = 30,
  width = 800, height = 500,
  renderer = av_renderer("cdi_animated.mp4"))

