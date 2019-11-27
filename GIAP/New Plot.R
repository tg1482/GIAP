set.seed(1)

pacman::p_load(tidyverse, viridis, patchwork, hrbrthemes, fmsb, colormap)

install.packages('patchwork')
set.seed(1)
data <-as.data.frame(matrix( sample( 2:20 , 10 , replace=T) , ncol=10))
colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding", "data-viz" , "french" , "physic", "statistic", "sport" )

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
data <-rbind(rep(20,10) , rep(0,10) , data)


# Custom the radarChart !
par(mar=c(0,0,0,0))
p1 <- radarchart( data, axistype=1, 
                  
                  #custom polygon
                  pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
                  
                  #custom the grid
                  cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
                  
                  #custom labels
                  vlcex=1.3 
)

# Barplot
data %>% slice(3) %>% t() %>% as.data.frame() %>% add_rownames() %>% arrange(V1) %>% mutate(rowname=factor(rowname, rowname)) %>%
  ggplot( aes(x=rowname, y=V1)) +
  geom_segment( aes(x=rowname ,xend=rowname, y=0, yend=V1), color="grey") +
  geom_point(size=3, color="#69b3a2") +
  coord_flip() +
 # theme_ipsum() +
  theme(
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.text = element_text( size=12 ),
    legend.position="none"
  ) +
  ylim(0,20) +
  ylab("mark") +
  xlab("")
