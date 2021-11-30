```{r}
data_exportorders<-data.frame(
  x=c("109.10","109.11","109.12","110.01","110.02","110.03","110.04","110.05","110.06","110.07","110.08","110.09","110.10"),
  
  y=c(515.9,577.8,605.5,527.2,425.9,536.6,549.3,522.9,537.3,553.0,535.0,629.0,591.0)
)

breaksx=c("109.10","109.11","109.12","110.01","110.02","110.03","110.04","110.05","110.06","110.07","110.08","110.09","110.10")
labelsx=c("109.10/1","11","12","110.01","02","03","04","05","06","07","08","09","10")

breaksy=c(425.9,540.7,629.0)
labelsy=c("425.9","Mean 540.7","629.0")


datayearincrease<-data.frame(
  x=c("110.01","110.02","110.03","110.04","110.05","110.06","110.07","110.08","110.09","110.10"),
  y=200,
  label=c(49.3,48.5,33.3,42.6,34.5,31.1,21.4,17.6,25.7,14.6)
)


datayearincrease$label<-paste0(datayearincrease$label," ","%")


ggplot(data=data_exportorders)+
  geom_col(
    mapping=aes(
      x=x,
      y=y
    ),
    width=0.8
  )+
  geom_text(
    data=datayearincrease,
    mappin=aes(
      x=x,y=y,label=label
    ),
    size=2,
    color="red"
  )+
  scale_x_discrete(
    breaks=breaksx,
    labels=labelsx,
    name="Time(one-year changes)"
  )+
  scale_y_continuous(
    breaks=breaksy,
    labels=labelsy,
    name="export orders($ b )",
    limits = c(0,700)
  )+
  theme(
    axis.text.x=element_text(
      margin=margin(4), #input$margin
      size=8 #input$size
    ))+
  theme(
    axis.text.y = element_text(
      margin=margin(2),
      size=8
    ))+
  labs(
    title="110年10月台灣外銷訂單統計",
    subtitle="   (from 109/10 - 110/10) 紅字代表年增率",
    caption="來源:Department Of Statistic"
    
  )+
  geom_line(
    data=data_exportorders,
    aes(
      group=1,
      x=x,
      y=y),
    color="blue",
    size=1,
    alpha=0.8
  )+
  geom_hline(
    yintercept = 540.7,
    color="grey",
    linetype=2,
    size=1,
    alpha=0.8
  )
```
