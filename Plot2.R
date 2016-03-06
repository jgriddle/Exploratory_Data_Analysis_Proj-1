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
# PLOT 2: global active power vs time
x1 <- as.character(hpc$Date)
x2 <- hpc$Time
x <- paste(x1, x2, sep = " ")
d <- strptime(x, "%Y-%m-%d %H:%M:%S")

with(hpc, plot(d, Global_active_power, type = "l", lty = 1, main = "", 
               xlab = "", ylab = "Global Active Power (kilowatts)"))
#axis(1, at = c(0, 2880/2, 2880), labels = c("Thu", "Fri", "Sat"))
