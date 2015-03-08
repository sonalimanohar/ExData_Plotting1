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
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

# Plot using range() parameter of function. This tells the plot function how many different series (or lines in this case)
# we are dealing with. Use lines() function to add the remaining series.
plot(pc$Date_Time, pc$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", ylim=range(pc$Sub_metering_1, pc$Sub_metering_2, pc$Sub_metering_3) )
lines(pc$Date_Time, pc$Sub_metering_2, type="l", col="red")
lines(pc$Date_Time, pc$Sub_metering_3, type="l", col="blue")

# Use lty() parameter of legend() function to specify that the legend is for a line graph and is a type of line. pch does not have a character for a line.
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1) ) 
dev.off()

