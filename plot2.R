##DOWNLOAD AND UNZIP DATA
fileurl<- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./Project.zip", mode="wb")
unzip("Project.zip", overwrite = TRUE, exdir="dir()")

##CONVERT "household_power_consumption.txt" INTO DATA FRAME
data <- read.table("household_power_consumption.txt", header = T, sep=";", dec=".")

##ISOLATE DATA FROM 2007-02-01 AND 2007-02-02
data$Date_Time <- paste(data$Date, data$Time, sep=" ")
data$Date_Time <- strptime(data$Date_Time, "%d/%m/%Y %H:%M:%S")
data$Date <- strptime(data$Date, "%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
data$Global_active_power <- as.numeric(as.vector(data$Global_active_power))
row.names(data) <- NULL

##PLOT 2
library(datasets)
Sys.setlocale("LC_TIME", "eng")
png(filename = "plot2.png", width = 480, height = 480)
plot.new()
plot(data$Date_Time, data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     ylim=c(0,8),
     yaxt="n")
axis(side=2, c(0,2,4,6))
dev.off()