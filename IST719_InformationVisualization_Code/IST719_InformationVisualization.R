########################################################################
#Final presentation code
#Cal Wardell
#IST 719
#
#Overall question, what to know before looking for cars in Poland!
#Question1: What makers of car have the lowest price?
#Question2: How does mileage play a role in the price of the car?
########################################################################

carprice <- read.csv('Car_Prices_Poland_Kaggle.csv', header = TRUE, stringsAsFactors = FALSE)
rows <- nrow(carprice)
columns <- ncol(carprice)
#Formula to ensure our data is sufficient
(columns*4)*(rows/100)
#51887.88, more then enough

#Structure of our data
str(carprice)
carprice <- carprice[carprice$province != '(',] #Saw we had this variable so we removed it
#Drop car ID column
carprice = subset(carprice, select = -c(X) )
par(mar = c(12,6,2,2)) #Set parameters for the graphs
province_df <- carprice[carprice$province != 'Berlin',]
province_df <- province_df[province_df$province != 'Moravian-Silesian Region',]
province_df <- province_df[province_df$province != 'Niedersachsen',]
province_df <- province_df[province_df$province != 'Nordrhein-Westfalen',]
province_df <- province_df[province_df$province != 'Trenczyn',]
province_df <- province_df[province_df$province != 'WarmiÅ"sko-mazurskie',]

#First single dimension visual
barplot(table(province_df$province)
        ,las=2
        , main = 'Number of cars in each region'
        , col = 'red'
        )

#Second single dimension Visual
par(mar = c(8,6,2,2))
boxplot(x= carprice$price
        #,breaks = 50
        , main = 'Price Distribution'
        , col = 'green'
        , horizontal = TRUE
)

#Third single dimension visual
par(mar = c(8,6,2,2))
barplot(table(carprice$mark)
        ,las=2
        , main = 'Car Maker Count'
        , col = 'green'
)


#Multi-demnsion plot
smoothScatter(carprice$price
              ,carprice$mileage
              ,colramp = colorRampPalette(c("white", "#669999", "#FFAAAA", "#AA3939"))
              ,main = 'Car Price Compared to Car Mileage'
              ,xlab = 'Car Price(PLN)'
              ,ylab = 'Car Mileage (KM)'
              ) 

#maker of the car average price
par(mar = c(8,6,2,2))
library(ggplot2)
ggplot(carprice) + aes(x=mark, y=price) + geom_boxplot(outlier.shape=NA) + 
  theme(axis.text.x = element_text(angle = 90)) + ylim(0,400000) + ylab('Price(PLN)')+
xlab('Make of car')
