```{r}
#mp$stmaen(從open street maps拿)

ggmap::get_stamenmap(
  bbox = c(left = 121.5017, bottom = 25.2132, right = 121.6613, top = 25.2994),
  zoom=12)->shimenap
ggmap::ggmap(shimenap)
#shimenap=shimenairpicture(底圖)

bbox = c(left = 121.5017, bottom = 25.2132, right = 121.6613, top = 25.2994)
#下面各一個里(乾華和德茂里)
bbox|>
  osmdata::opq()|>
  #osmdata::add_osm_feature(key="wikidata",value="Q96974751") |>
  osmdata::add_osm_feature(key="admin_level",value="9") |>
  osmdata::osmdata_sf()->shimenline

#第二個feature嘗試
#(bbox|>
#  mp$osm$request_data(
#    features=c("wikidata"="Q96974741","wikidata"="Q96974751")
# )->shimenline2)


shimenline|>View()
#shimenline是在底圖上面抓sf

shimenline$osm_multipolygons|>
  ggplot()+geom_sf()
#這個是只畫shimenline那一塊
#不含底圖整個範圍

#以下整合
ggmap::ggmap(shimenap)+
  geom_sf(data=shimenline$osm_multipolygons,
          inherit.aes = F
  )
#ask from here 
#畫出來多了太多不要的里是不是應該用疊圖的比較快
#中文亂碼處理問題
```
```{r}
#中文亂碼
#shimenline$osm_multipolygons$name  #裡面的字是亂碼
rm(dfregion)
#dfregion
A<-as.character(shimenline$osm_multipolygons$name)
Encoding(A) <- "UTF-8"
A->shimenline$osm_multipolygons$name
shimenline|>View()
#這裡的亂碼問題已改好
class(shimenline$osm_multipolygons$name)

###以下是老師的方法
#way1 and way2
A <- colnames(graphData$Case_10_result) # 把有問題的字串叫A
Encoding(A) <- "UTF-8"
A -> colnames(graphData$Case_10_result) # 記得把轉好的A存回源頭

A <- as.charater(graphData$Case_10_result$`六都`) # Encoding只對character class有效，此變數為factor，所以要先改class
Encoding(A) <- "UTF-8"
A -> graphData$Case_10_result$六都

```

```{r}
shimenline$osm_multipolygons|>
  dplyr::select("name","boundary")

shimenline$osm_multipolygons[c(12:20),]->wantregiontotal
rm(wantregion)
wantregiontotal

shimenline$osm_multipolygons[c(15,16,19,20,18),]->influence1
influence1

shimenline$osm_multipolygons[c(17,14,12),]->influence2
influence2

shimenline$osm_multipolygons[c(13),]->influence3
influence3

#class=dataframe
```




```{r}

coloryetmap<-function(){
  ggmap::ggmap(shimenap)+
    geom_sf(data=wantregiontotal,mapping=aes(
      fill=c("3-5公里","5-8公里","3-5公里","0-3公里","0-3公里","3-5公里","0-3公里","0-3公里","0-3公里")  
    ),
    inherit.aes = F
    )
}

coloryetmap()

#c(influence1+influence2+influence3)
#cut只能用在數值資料
#wantregiontotal2<-wantregiontotal
#wantregiontotal2$name|>
# cut(c(inflence1$name,influence2$name,influence3$name),ordered_result = T
#    )->.fct|>class()



#  group=c("influence1","influence2","influence3")),

#我把原本的shimenline$osm_multipolygons裡面的資料取出分三類為:influence1,influence2,influence3(依照影響大小分類，這三個也是dataframe資料形式,資料數量分別是5,3,1),所以下面我畫圖的時候fill用這三個分類來畫，可是顏色並沒有被更改到

coloryetmap()+
  
  #coloryetmap()|>ggplot()+ggmap::ggmap()+geom_sf()
  
  ```
```{r}
#試色三
pal <- colorspace::choose_palette(gui="shiny")

colorspace::sequential_hcl(n = 3, h = c(200, 360), c = c(8, NA, 66), l = c(54, 35), power = c(1.3, 0,9), register = "emgncy")

colorspace::scale_fill_discrete_sequential(palette="emgncy")

coloryetmap()+colorspace::scale_fill_discrete_sequential(palette="emgncy",name="影響範圍大小(涵蓋的里)",labels=c("0-3公里(乾華,尖鹿,茂林,草里,石門)","3-5公里(山溪,老梅,富基)","5-8公里(德茂)"))+theme_void()+labs(title="核一電廠對新北市石門區(里)影響程度",subtitle="(塗色範圍包含整個石門區)",caption="資料來源:新北市
核子事故區域民眾防護應變計畫")

```