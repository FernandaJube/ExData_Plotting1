housepower<-file("household_power_consumption.txt")
hp <- read.table(text = grep("^[1,2]/2/2007", readLines(housepower), value = TRUE), header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
hp$Date <- as.Date(hp$Date, "%d/%m/%Y")

hp <- hp[complete.cases(hp),]

dateTime <- paste(hp$Date, hp$Time)

dateTime <- setNames(dateTime, "DateTime")

hp <- hp[ ,!(names(hp) %in% c("Date","Time"))]

hp1 <- cbind(dateTime, hp)

hp1$dateTime <- as.POSIXct(dateTime)
#plot 3
with(hp1,{plot(Sub_metering_1~dateTime,type="l",ylab="Global Active Power (kilowatts)",xlab="")
  lines(Sub_metering_2~dateTime,col="Red")
  lines(Sub_metering_3~dateTime,col="Blue")})
legend("topright",col=c("black","red","blue"),lty=1,lwd=2,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,file="plot3.png",width = 480, height = 480)
dev.off()
