# download and unzip file
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

### uncomment to determine data structure and inform colClasses and sep argument of read.table command for entire data set
# read first row only to see data structure and get column classes (to make reading complete data set faster)
# data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, nrows = 1, sep=";")
# unlink(temp) 
# classes <- sapply(data, class)

# read complete data set
powerCon <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")
unlink(temp)

# select observations corresponding to dates of interest: 2007-02-01 and 2007-02-02) 
powerFin <- subset(powerCon, powerCon$Date == "1/2/2007" | powerCon$Date == "2/2/2007")

# transform date column to class data using as.Date, add column DateAndTime using strptime
powerFin$Date <- as.character(powerFin$Date)
powerFin$Time <- as.character(powerFin$Time)
powerFin$DateAndTime <- paste(powerFin$Date, powerFin$Time)
powerFin$DateAndTime <- strptime(c(powerFin$DateAndTime), "%d/%m/%Y %H:%M:%S") # time format
powerFin$Date <- as.Date(powerFin$Date , "%d/%m/%Y") # date format

## send plot to png file
# open png device, set height and width as directed, make background transparent
png(file = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent") 
# create plot, send to a file
hist(powerFin$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
# close png file device
dev.off() ## Close the PDF file device