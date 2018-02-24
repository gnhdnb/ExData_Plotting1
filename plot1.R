library(chron)
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'household_power_consumption.zip')
unzip('household_power_consumption.zip')
dataset <- read.csv("household_power_consumption.txt", sep=';', skip=50000, nrows=20000, header = FALSE, na.strings=c("?"), stringsAsFactors = FALSE)
dataset[,'timestamp'] <- chron(dates=dataset[,1],times=dataset[,2], format=c('d/m/y','h:m:s'))
dataset <- dataset[dataset$timestamp > "01/02/2007" & dataset$timestamp < "03/02/2007",]

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(dataset$V3, xlab='Global Active Power (kilowatts)', col='red', main='Global Active Power')
dev.off()