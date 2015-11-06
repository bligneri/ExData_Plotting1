
library(dplyr)
# Name of the file : "household_power_consumption.txt"

if (F){
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
