# use data.table library
library(data.table)
# create a tempfile and a tempdir
tmpFile <- tempfile()        
tmpdir <- tempdir()
# download the data to the tmpFile
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile=tmpFile, method="curl")
# unzip to tmpDir
unzip(tmpFile, exdir = tmpdir)
# name the extracted file
file <- paste(tmpdir, "household_power_consumption.txt", sep="/")
# get the headers from the data (skip misses these)
header <- fread(file, nrows=1, header=F, sep=";", stringsAsFactors = FALSE)
# use fread() to read the file, skip to the first occurance of 1/2/2007
# data rate is once per minute, so skip 1440 per required day
DT <- fread(file, skip="1/2/2007", nrows=2880, header=F, sep=";", na.strings="?")
# give DT the column names
# colnames(DT) <- unlist(header)
setnames(DT, as.character(header))
# calculate the date and time
datetime <- strptime(paste(DT$Date, DT$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# plot 2
# open png device.  480x480 is the default resolution
png(file="plot2.png")
plot(datetime, DT$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
