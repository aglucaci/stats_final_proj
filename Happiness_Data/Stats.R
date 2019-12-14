#Alexander G. Lucaci
# Implementing... 
# https://www.kaggle.com/javadzabihi/happiness-2017-visualization-prediction

library(plyr)
library(dplyr)
library(tidyverse)
library(lubridate)
library(caTools)
library(ggplot2)
#install.packages("ggthemes")
library(ggthemes)
library(reshape2)
library(data.table)
library(tidyr)
#install.packages("corrgram") ERROR
#library(corrgram)
#install.packages("corrplot")
library(corrplot)
#install.packages("formattable")
library(formattable)
#install.packages("cowplot")
library(cowplot)
#install.packages("ggpubr") ERROR
#library(ggpubr)
#install.packages("plot3D")
library(plot3D)




Happiness <- read.csv("data_2016.csv")

str(Happiness)


########## Correlation between variables

# Finding the correlation between numerical columns
Num.cols <- sapply(Happiness, is.numeric)
Cor.data <- cor(Happiness[, Num.cols])

corrplot(Cor.data, method = 'color') 


# Create a correlation plot
newdatacor = cor(Happiness[c(4:11)])
corrplot(newdatacor, method = "number")


ggplot(Happiness, aes(x.plot, y.plot)) +
  stat_summary(fun.data=mean_cl_normal) + 
  geom_smooth(method='lm', formula= y~x)

ggplot(data = Happiness, aes(x = happiness, y = electricity)) + 
  geom_point(color='blue') +
  geom_smooth(method = "lm", se = FALSE)



ggplot(data = Happiness, aes(x = happiness, y = electricity)) + 
  geom_point(aes(color=gdp)) +
  geom_smooth(method = "lm", se = FALSE) + labs(title = "Scatter plot with regression line")



ggplot(data = Happiness, aes(x = happiness, y = electricity)) + 
  geom_point(aes(color=gdp)) +
  geom_smooth(method = "lm", se = FALSE) + 
  facet_wrap(~gdp) + 
  labs(title = "Scatter plot with regression line")


ggplot(data = Happiness, aes(x = happiness, y = electricity)) + 
  geom_point(aes(color=happiness)) +
  geom_smooth(method = "lm", se = FALSE) + 
  geom_smooth(aes(color = happiness, fill = happiness), 
              method = "lm", fullrange = TRUE) + 
  labs(title = "Scatter plot with regression line")

ggplot(data = Happiness, aes(y = happiness, x = electricity)) + 
  geom_point(aes(color=happiness)) +
  geom_smooth(method = "lm", se = FALSE) + 
  geom_smooth(aes(color = happiness, fill = happiness), 
              method = "lm", fullrange = TRUE) + 
  labs(title = "Scatter plot with regression line")



ggplot(data = Happiness, aes(y = happiness, x = electricity)) + 
  geom_point(aes(color=happiness)) +
  geom_smooth(aes(color = happiness, fill = happiness), 
              method = "lm", fullrange = TRUE) + 
  labs(title = "Scatter plot with regression line")


# happiness score by gdp and colored by life expectancy.
ggplot(data = Happiness, aes(y = happiness, x = gdp)) + 
  geom_point(aes(color=life), size = 4, alpha = 0.8) +
  geom_smooth(aes(color = happiness, fill = happiness), 
              method = "lm", fullrange = TRUE) + 
  labs(title = "Scatter plot with regression line") +
  geom_text(aes(label=Country), size=2)

# # # -------------------------------------------------------------------------#

#Good .
ggplot(data = Happiness, aes(y = happiness, x = gdp)) + 
  geom_point(aes(color=life), size = 4, alpha = 0.8) +
  geom_smooth(aes(color = happiness, fill = happiness), 
              method = "lm", fullrange = TRUE) + 
  labs(title = "Scatter plot with regression line")



# MLM
# https://datatofish.com/multiple-linear-regression-in-r/


model <- lm(Happiness$happiness ~ Happiness$electricity + Happiness$gdp + Happiness$life)
summary(model)

plot(x=Happiness$electricity, y=Happiness$happiness) 