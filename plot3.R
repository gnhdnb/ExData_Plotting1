library(chron)
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'household_power_consumption.zip')
unzip('household_power_consumption.zip')
dataset <- read.csv("household_power_consumption.txt", sep=';', skip=50000, nrows=20000, header = FALSE, na.strings=c("?"), stringsAsFactors = FALSE)
dataset[,'timestamp'] <- chron(dates=dataset[,1],times=dataset[,2], format=c('d/m/y','h:m:s'))
dataset <- dataset[dataset$timestamp > "01/02/2007" & dataset$timestamp <= "03/02/2007",]
dataset[, 'weekday'] <- weekdays(dataset$timestamp, abbreviate = TRUE)

png(filename = "plot3.png", width = 480, height = 480, units = "px")

plot(
  dataset$timestamp,
  dataset$V7, 
  type='l',
  axes = FALSE,
  xlab='',
  ylab='Energy sub metering')

lines(
  dataset$timestamp,
  dataset$V8, 
  col = 'red',
  type = 'l')

lines(
  dataset$timestamp,
  dataset$V9, 
  col = 'blue',
  type = 'l')

legend(
  x = 'topright',
  legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
  lty = c(1, 1, 1),
  col = c('black', 'red', 'blue')
  )

axis(2)
pts <- c(
  dataset$timestamp[1], 
  dataset$timestamp[nrow(dataset) / 2 + 1],
  dataset$timestamp[nrow(dataset)])
axis(1, at = pts, labels = weekdays(pts))
box(lty="solid")

dev.off()