# INSTALAR O PACOTE

install.packages("GetBCBData")

# CARREGAR A BIBLIOTECA

library(GetBCBData)
library(tidyverse) # TAMBÉM É NECESSÁRIO

# INSTRUÇÕES DO PACOTE (VIGNETTE)
# https://cran.r-project.org/web/packages/GetBCBData/vignettes/GetBCBData-vignette.html

# OS CÓDIGOS DAS VARIÁVEIS VÊM DIRETO DA PLATAFORMA
# ACESSAR O SGS
# http://www.bcb.gov.br/?sgs

# EXEMPLO COM CDI
# METADADOS
# Taxa média de juros tendo como base as operações de emissão de Depósitos 
# Interfinanceiros pré-fixados, pactuadas por um dia útil, registradas e 
# liquidadas pelo sistema Cetip, considerando apenas operações do mercado 
#interbancário realizadas entre instituições de conglomerados diferentes 
# (Extra-grupo), desprezando-se as demais (Intra-Grupo).

my.id <- c(cdi = 11)

df.bcb <- gbcbd_get_series(id = my.id ,
                           first.date = '2000-01-01',
                           last.date = Sys.Date(),
                           format.data = 'long',
                           use.memoise = TRUE, 
                           cache.path = tempdir(), # use tempdir for cache folder
                           do.parallel = FALSE)

glimpse(df.bcb)

# GRÁFICO SIMPLES

p <- ggplot(df.bcb, aes(x = ref.date, y = value) ) +
  geom_line() + 
  labs(title = 'CDI', 
       subtitle = paste0(min(df.bcb$ref.date), ' to ', max(df.bcb$ref.date)),
       x = '', y = 'Taxa de juros CDI, % a.d.') + 
  theme_light()

print(p)