library(lubridate)
library(plyr)

power <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F, na.strings = "?")
power <- mutate(power, Date = dmy(Date))
power <- filter(power, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
power <- mutate(power, DateTimeSeconds = as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))

par(mfrow = c(1,1), bg = "transparent", oma = c(0,0,0,0), mar = c(5.1, 4.1, 4.1, 2.1)) 
hist(power$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

screen <- dev.cur()
png(width = 480, height = 480, filename = "plot1.png")
png <- dev.cur()
dev.set(screen)
dev.copy(which = png)
dev.off(which = png)