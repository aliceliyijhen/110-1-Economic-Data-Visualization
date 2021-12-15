```{r}
x=c(seq(2007,2019))
library(dplyr)
library(tidyr)


y<-list()
y$canada=c(6480,14336,30219,22721,20468,13224,19321,16823,31762,16660,34249,36475,37296)

y$us=c(6623,13316,22911,15514,11931,6274,8609,7003,9589,4441,7206,8795,11332)

y$denmark=c(206,499,51,899,4413,2381,260,11215,16536,9360,13918,12199,8061)

y$nederland=c(125,464,460,2187,4703,1187,1203,7213,6587,4716,6205,6477,6439)

y$spanish=c(578,9047,15206,15840,13858,13975)


.df = data.frame(y[-5]) #|> View()
.df$x = x

.df$spain <- NA # declare
pick_after2014 <- .df$x >= 2014
.df$spain[pick_after2014] <- y$spanish

.df %>% View()
# tidyr
library(dplyr)
library(tidyr)
.df %>%
  tidyr::pivot_longer(
    cols = -x,
    names_to = "country",
    values_to = "pork_import"
  ) -> .df_long



ggplot()+
  geom_line(data = .df_long,
            mapping=aes(
              x=country,
              y=pork_import,
              group=factor(X)
            ),
            size=2
  )
```