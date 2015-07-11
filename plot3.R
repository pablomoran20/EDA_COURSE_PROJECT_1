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
data$Sub_metering_1 <- as.numeric(as.vector(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.vector(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.vector(data$Sub_metering_3))
row.names(data) <- NULL

##PLOT 3
library(datasets)
Sys.setlocale("LC_TIME", "eng")
png(filename = "plot3.png", width = 480, height = 480)
plot.new()
plot(data$Date_Time, data$Sub_metering_1,
     type="l",
     col="black",
     xlab = "",
     ylab = "Energy sub metering",
     ylim=c(0, 40),
     yaxt="n")
axis(side=2, c(0,10,20,30))
lines(data$Date_Time,data$Sub_metering_2,col="red")
lines(data$Date_Time,data$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue" ), lty=1, lwd=1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()