# happiness report final 
install.packages('meifly', repos='http://cran.us.r-project.org')
library(meifly)
library(plyr)
library(leaps)
library(MASS)

data_2016 <- read.csv(file="C:/Users/Stella/Desktop/stat_final_project/data_2016.csv", header=TRUE, sep=",")
data_2017 <- read.csv(file="C:/Users/Stella/Desktop/stat_final_project/data_2017.csv", header=TRUE, sep=",")

# Correlation and pick columns for further analysis 
cor(data_2016$happiness, data_2016$gdp) # Yes 
cor(data_2016$happiness, data_2016$electricity) # Yes 
cor(data_2016$happiness, data_2016$unemployment) # Yes
cor(data_2016$happiness, data_2016$pop) # Yes 
cor(data_2016$happiness, data_2016$life) # Yes 
cor(data_2016$happiness, data_2016$natural) # Yes
cor(data_2016$happiness, data_2016$primary_2016) # Yes

# model
data_2016_mat <- read.csv(file="C:/Users/Stella/Desktop/stat_final_project/data_2016_mat.csv", header=TRUE, sep=",")
data_2017_mat <- read.csv(file="C:/Users/Stella/Desktop/stat_final_project/data_2017_mat.csv", header=TRUE, sep=",")

mod <- fitall(data_2016$happiness, data_2016_mat, method = "lm")

sum <- summary(mod)
coeff <- coef(mod)

## Extract AIC from each model
mod.aic <- t(sapply(mod, extractAIC))

## Create an order list of increasing AIC
mod.order <- order(mod.aic[,2], decreasing = TRUE)
mod.order

## Show the result for the best model
m112 <- mod[mod.order][1]
m96 <- mod[mod.order][2]
m80 <- mod[mod.order][3]

m71 <- mod[mod.order][127]
m71

m112 <- m112[[1]][10]
m112 <- m112[[1]][10]

# m112_predict <- predict(lm(formula = happiness ~ pop + primary_2016 + unemployment, data = data_2016, model = FALSE))
# m112_predict

m112_predict <- predict(lm(formula = happiness ~ pop + primary_2017 + unemployment, data = data_2017, model = FALSE))
m112_predict

m71_predict <- predict(lm(formula = happiness ~ electricity + gdp + life + unemployment, data = data_2017, model = FALSE))
m71_predict



scatter.smooth(x=data_2017$happiness, y=m112_predict)
scatter.smooth(x=data_2017$happiness, y=m71_predict)


write_csv(sum, "C:/Users/Stella/Desktop/stat_final_project/data_2016_summary.csv")
write_csv(coeff, "C:/Users/Stella/Desktop/stat_final_project/data_2016_coefficient.csv")


