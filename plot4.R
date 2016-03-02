# Coursera course "Exploratory Data Analysis" Project 1
#
# Plot 4
#
rm(list = ls())
setwd("~/Code/ExData_Plotting1")

my_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = my_url, destfile = "Dataset.zip", method = "curl")
unzip(zipfile = "Dataset.zip")

household_power_consumption.df <- read.csv(file = "household_power_consumption.txt", 
                                           sep = ";",
                                           header = TRUE,
                                           stringsAsFactors = FALSE,
                                           na.strings = "?")

household_power_consumption.df <- na.omit(household_power_consumption.df)
number.records <- nrow(household_power_consumption.df)

power_consumption.df <- data.frame(DateTime              = as.POSIXct(rep(NA, times = number.records)),
                                   Global_active_power   = as.numeric(rep(NA, times = number.records)),
                                   Global_reactive_power = as.numeric(rep(NA, times = number.records)),
                                   Voltage               = as.numeric(rep(NA, times = number.records)),
                                   Global_intensity      = as.numeric(rep(NA, times = number.records)),
                                   Sub_metering_1        = as.numeric(rep(NA, times = number.records)),
                                   Sub_metering_2        = as.numeric(rep(NA, times = number.records)),
                                   Sub_metering_3        = as.numeric(rep(NA, times = number.records)))

power_consumption.df$DateTime <- paste(household_power_consumption.df$Date, household_power_consumption.df$Time)
power_consumption.df$DateTime <- as.POSIXct(strptime(power_consumption.df$DateTime, "%d/%m/%Y %H:%M:%S"))
# 
power_consumption.df$Global_active_power   <- as.numeric(household_power_consumption.df$Global_active_power)
power_consumption.df$Global_reactive_power <- as.numeric(household_power_consumption.df$Global_reactive_power)
power_consumption.df$Voltage               <- as.numeric(household_power_consumption.df$Voltage)
power_consumption.df$Global_intensity      <- as.numeric(household_power_consumption.df$Global_intensity)
power_consumption.df$Sub_metering_1        <- as.numeric(household_power_consumption.df$Sub_metering_1)
power_consumption.df$Sub_metering_2        <- as.numeric(household_power_consumption.df$Sub_metering_2)
power_consumption.df$Sub_metering_3        <- as.numeric(household_power_consumption.df$Sub_metering_3)
#
# Select subset to plot
#
plot.data <- power_consumption.df[power_consumption.df$DateTime >= "2007-02-01 00:00:00" & 
                                  power_consumption.df$DateTime <  "2007-02-02 24:00:00", ]
plot.data <- na.omit(plot.data)

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#
# Name the plot file as plot4.png
plot.colors <- c("black","red","blue")
xrange <- plot.data$DateTime
par(mfrow = c(2,2))

# subplot #1
yrange <- plot.data$Global_active_power
plot(xrange, yrange, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# subplot #2
yrange <- plot.data$Voltage
plot(xrange, yrange, type = "l", ylab = "Voltage", xlab = "datetime")

# subplot #3
plot(xrange, plot.data$Sub_metering_1, col = plot.colors[1], type = "l", ylab = "Energy sub meeting", xlab = "")
lines(xrange, plot.data$Sub_metering_2, col = plot.colors[2])
lines(xrange, plot.data$Sub_metering_3, col = plot.colors[3])
legend("topright", col = plot.colors, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty= "n")

# subplot #4
plot(xrange, plot.data$Global_reactive_power, xlab = "datetime", type = "l")

#################
# Export to file

png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
# subplot #1
yrange <- plot.data$Global_active_power
plot(xrange, yrange, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# subplot #2
yrange <- plot.data$Voltage
plot(xrange, yrange, type = "l", ylab = "Voltage", xlab = "datetime")

# subplot #3
plot(xrange, plot.data$Sub_metering_1, col = plot.colors[1], type = "l", ylab = "Energy sub meeting", xlab = "")
lines(xrange, plot.data$Sub_metering_2, col = plot.colors[2])
lines(xrange, plot.data$Sub_metering_3, col = plot.colors[3])
legend("topright", col = plot.colors, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n")

# Plot #4
plot(xrange, plot.data$Global_reactive_power, xlab = "datetime", type = "l")

dev.off()
