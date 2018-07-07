rm(list = ls())
filename<-"household_power_consumption.txt"

data<-read.table(filename, header = TRUE,  sep = ";", col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),colClasses = c("character","character","double","double","double","double","double","double","double"),na.strings = "?")

data$Date<-as.Date(data$Date, "%d/%m/%Y")
sdata<-subset(data,data$Date==as.Date("2007-02-01") | data$Date== as.Date("2007-02-02"))

sdata$datetime<- paste(sdata$Date,sdata$Time)
sdata$datetime<-strptime(sdata$datetime,format = "%Y-%m-%d %H:%M:%S")
sdata$weekdays<-weekdays(sdata$datetime)
png('plot4.png')

par(mfrow = c(2,2))

#plot1.1
plot(sdata$datetime,sdata$Global_active_power,type = 'l',ylab = "Global Active Power",xlab = "")

#plot1.2
plot(sdata$datetime,sdata$Voltage, type = 'l', ylab="Voltage",xlab="datetime")

#plot2.1
plot(sdata$datetime,sdata$Sub_metering_1, type = 'l', xlab = "" , ylab = "Energy sub metering")
lines(sdata$datetime,sdata$Sub_metering_2,col = "red")
lines(sdata$datetime,sdata$Sub_metering_3,col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"), lty = 1, bty = "n")

#plot2.2
plot(sdata$datetime,sdata$Global_reactive_power, type = 'l', ylab="Global_reactive_power",xlab="datetime")



dev.off()