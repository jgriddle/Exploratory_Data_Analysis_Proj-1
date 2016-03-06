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
# PLOT 1: histogram of global active power
with(hpc, hist(Global_active_power, col = "red", breaks = 12,
               main = "Global Active Power", 
               xlab = "Global Active Power (kilowatts)", 
               ylab = "Frequency"))
