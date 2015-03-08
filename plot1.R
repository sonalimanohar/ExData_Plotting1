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

# Plot the chart using hist for a Histogram. Main = "Main Title" xlab = "X-Axis Title"
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
hist(pc$Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()



