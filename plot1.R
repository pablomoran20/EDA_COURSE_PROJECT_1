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

##PLOT 1
library(datasets)
png(filename = "plot1.png", width = 480, height = 480)
plot.new()
hist(data$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red",
     xlim=c(0, 6),
     ylim=c(0, 1200),
     xaxt="n",
     yaxt="n"
)
axis(side=1, c(0,2,4,6))
axis(side=2, c(0,200,400,600,800,1000,1200))
dev.off()