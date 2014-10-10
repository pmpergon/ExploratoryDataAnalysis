## Exploratory Data Analysis
#       Project Assignment 1 PLot #1
# Data: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
library(Defaults)  #http://stackoverflow.com/questions/13022299/specify-date-format-for-colclasses-argument-in-read-table-read-csv
library(plyr)

## NOTE: household_power_consumption.txt FILE IN DIRECTORY "./ExplAnalData"


#       We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#       One alternative is to read the data from just those dates rather than reading 
#       in the entire dataset and subsetting to those dates.
#       · Note that in this dataset missing values are coded as ?.


setDefaults('as.Date.character', format = '%d/%m/%Y')

hpc<- read.table("./ExplAnalData/household_power_consumption.txt", header=TRUE, sep=";",na.strings="?",colClasses= c("Date","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))


#       We will only be using data from the dates 2007-02-01 and 2007-02-02.

datesub0 <- (as.POSIXlt(hpc$Date)$year) == 107
hpc.sub0<- hpc[datesub0,]
datesub1 <- (as.POSIXlt(hpc.sub0$Date)$yday) == 31
datesub2 <- (as.POSIXlt(hpc.sub0$Date)$yday) == 32

hpc.sub1 <- hpc.sub0[datesub1,]
hpc.sub2 <- hpc.sub0[datesub2,]
hpc.sub <- rbind(hpc.sub1,hpc.sub2)
colnames(hpc.sub) <- colnames(hpc.sub0)
hpc.sub <- hpc.sub [complete.cases(hpc.sub),]
rm(list="hpc")
library (datasets)

#       You may find it useful to convert the Date and Time variables to Date/Time classes
#       in R using the strptime() and as.Date() functions.
# Merge Date & Time data
#       http://stackoverflow.com/questions/11609252/r-tick-data-merging-date-and-time-into-a-single-object
hpc.sub <- mutate(hpc.sub, DateTime = as.POSIXct(paste(hpc.sub$Date, hpc.sub$Time), format="%Y-%m-%d %H:%M:%S"))


##      PLOT #2 Plot of Global Active Power: plot2.png
plot.new()
dev.cur()
dev.copy (png, file ="./ExplAnalData/plot2.png")
plot(hpc.sub$DateTime, hpc.sub$Global_active_power, xlab="",ylab="Global Active Power", type="l")
dev.off()
