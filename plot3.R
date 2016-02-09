# plot3.R

# Read data from zip file
ZipFileName <- "exdata-data-household_power_consumption.zip"
fileName <- "household_power_consumption.txt"
Consumption <- read.csv(file=unz(ZipFileName, fileName), header = TRUE, sep = ";", quote = "\"", dec = ".", fill = TRUE, comment.char = "", stringsAsFactors = F)

# Convert string Date to Date of type Date
Consumption$Date <- as.Date(Consumption$Date, "%d/%m/%Y")

# Limit dates from 2007-02-01 to 2007-02-02
Consumption <- Consumption[(Consumption$Date > "2007-01-31") & (Consumption$Date < "2007-02-03"),]

# Convert Date and string time to time of type POSIXlt
Consumption$Time <- strptime(paste(Consumption$Date, Consumption$Time), "%F %H:%M:%S")

# Convert all other variables to numeric
Consumption[,3:9] <- lapply(Consumption[,3:9], as.numeric)

# open device
png(file="plot3.png", width = 480, height = 480)
# set plot layout
par(mfrow=c(1,1), mar=c(5.1, 4.1, 4.1, 2.1))
# Create plot
plot(Consumption$Time, Consumption$Sub_metering_1, ylab="Energy sub metering", type="l", xlab="")
lines(Consumption$Time, Consumption$Sub_metering_2, col="red")
lines(Consumption$Time, Consumption$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), col=c("black","red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# close device
dev.off()
