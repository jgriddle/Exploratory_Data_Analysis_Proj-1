library(dplyr)

# Read power consumption data de data subdirectory
if (file.exists("data")) { 
   hpc <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, 
                     stringsAsFactors = FALSE, na.strings = "?")
} else { 
   print("Can't Find Data Directory")
}

str(hpc)

# list rows of data that have missing values
#  -- this is only for sanity check against original data
#temp_missing <- hpc[!complete.cases(hpc),]

# create new dataset without missing data 
hpc <- na.omit(hpc)

# Change Date from character to Date in yyyy-mm-dd format
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

hpc <- filter(hpc, hpc[, 1] >= "2007-02-01" 
              & hpc[, 1] <= "2007-02-02") 
str(hpc)

## Plots
# PLOT 4: 
x1 <- as.character(hpc$Date)
x2 <- hpc$Time
x <- paste(x1, x2, sep = " ")
d <- strptime(x, "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2, 2))

# upper left
with(hpc, plot(d, Global_active_power, type = "l", lty = 1, main = "", 
               xlab = "", ylab = "Global Active Power (kilowatts)"))

# upper right
with(hpc, plot(d, Voltage, type = "l", lty = 1, main = "", 
               xlab = "datetime", ylab = "Voltage"))

# lower left
rng <- c(0, 40)
with(hpc, plot(d, Sub_metering_1, type = "l", lty = 1, main = "", 
               col = "black", xlab = "", ylab = "Energy sub metering", #xaxt = 'n', 
               ylim = rng))
with(hpc, lines(d, Sub_metering_2, col = "red"))
with(hpc, lines(d, Sub_metering_3, col = "blue"))
legend("topright", lty = "solid", col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# lower right
with(hpc, plot(d, Global_reactive_power, type = "l", lty = 1, main = "", 
               xlab = "datetime", ylab = "Global_reactive_power"))

