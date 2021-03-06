
library(dplyr)
# The file has to be in the same directory as the scripts
# Name of the file : "household_power_consumption.txt"

# set the locale in english in order to have English day name
Sys.setlocale("LC_TIME", "C")

if (T){
test<-read.csv("household_power_consumption.txt",sep=";",na.strings=c("?"))

# Convert as date
# test$Date<-as.Date(test$Date,format = "%d/$m/%Y")
test<-test %>% mutate (Date = Date %>% strptime("%d/%m/%Y") %>% as.character())

hpc<-subset(test,Date >="2007-02-01" & Date<="2007-02-02")

# Add a DateTime column :
hpc<-mutate(hpc,TimeDate = paste(Date,Time,sep=" "))

# Convert the DateTime into a posixctl Date & Time :
hpc$DateTime<-strptime(hpc$TimeDate,"%Y-%m-%d %H:%M:%S", tz="EST")

# Free memory !
rm(test)
}

# Now ready to graph and roll !

png("plot4.png")
par(mfrow = c(2,2))

plot(hpc$DateTime,hpc$Global_active_power,type="l",xlab="",ylab="Global Active Power",main="")

plot(hpc$DateTime,hpc$Voltage,type="l",xlab="datetime",ylab="Voltage",main="")

yrange<-range(c(hpc$Sub_metering_1,hpc$Sub_metering_2,hpc$Sub_metering_3))
plot(hpc$DateTime,hpc$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",main="",col="black",ylim=yrange)
lines(hpc$DateTime,hpc$Sub_metering_2,type="l",col="red")
lines(hpc$DateTime,hpc$Sub_metering_3,type="l",col="blue")
legend("topright",lty=c(1,1,1),bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(hpc$DateTime,hpc$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",main="")

# Close the file
dev.off()

