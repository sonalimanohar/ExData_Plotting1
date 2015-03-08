# Using Mac. Therefore need to download files from "https" URLs using curl method. Will not work otherwise.
# Not required for Windows.
require("RCurl")

# Set your working directory.
# Assumption is that the evaluator will set his/her working directory at this point.
# setwd('<your working directory path>')

# Set variable fileURL to the URL string
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the file to your current working directory. I am using Mac, therefore I have to use method = "curl"
download.file(fileUrl, destfile = "power_consumption.zip", method = "curl")
unzip("power_consumption.zip")

# Read only the data for 2 days as specified in the assignment. Seperator is required for columns. Data has null values in the form of "?"
pc <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep=";", na.strings = "?")

# Define names for each of the columns based on what is provided in the assignment
names(pc) <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

# Concatenate Date & Time and convert it to Date_time format using the strptime() function. Store it as a new column
# in the dataset
pc$Date_Time <- strptime(paste(pc$Date, pc$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# Save as .png with dimensions = 480x480
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

# Use par(mfrow) function to plot multiple charts in a single view. C(2,2) indicates that the view should display 
# 2 charts in two rows each. Use mar parameter to provide the margins otherwise an error is thrown
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
with(pc, {
  plot(pc$Date_Time,pc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  plot(pc$Date_Time,pc$Voltage, type = "l" , xlab = "datetime", ylab = "Voltage")
  plot(pc$Date_Time, pc$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", ylim=range(pc$Sub_metering_1, pc$Sub_metering_2, pc$Sub_metering_3) )
  lines(pc$Date_Time, pc$Sub_metering_2, type="l", col="red")
  lines(pc$Date_Time, pc$Sub_metering_3, type="l", col="blue")
  plot(pc$Date_Time,pc$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()

