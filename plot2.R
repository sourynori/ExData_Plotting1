rm(list = ls())
filename<-"household_power_consumption.txt"

data<-read.table(filename, header = TRUE,  sep = ";", col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),colClasses = c("character","character","double","double","double","double","double","double","double"),na.strings = "?")

data$Date<-as.Date(data$Date, "%d/%m/%Y")
sdata<-subset(data,data$Date==as.Date("2007-02-01") | data$Date== as.Date("2007-02-02"))

sdata$datetime<- paste(sdata$Date,sdata$Time)
sdata$datetime<-strptime(sdata$datetime,format = "%Y-%m-%d %H:%M:%S")
sdata$weekdays<-weekdays(sdata$datetime)
png('plot2.png')
plot(sdata$datetime,sdata$Global_active_power,type = 'l',ylab = "Global Active Power (kilowatts)",xlab = "")

dev.off()