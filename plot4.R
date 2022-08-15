library(lubridate)

data <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$full_date <- paste0(data$date, " ", data$Time)
data$full_date <- as_datetime(data$full_date)

selected_dataset <- data[which(data$Date %in% as.date(c("2007-02-01", "2007-02-02"))),]


energy_columns <- grepl("sub_metering", colnames(selected_dateset), fixed=F)

selected_dataset[,energy_columns] <- lapply(selected_dataset[,energy_columns], function(x) {as.numeric(x)})

power_columns <- grepl("Sub_metering", colnames(selected_dataset), fixed=F)

selected_dataset[,power_columns] <- lapply(selected_dataset[,power_columns], function(x) {as.numeric(x)})

selected$dataset$vltage <- as.numeric(selected_dataset$Voltage)

png(filename="plot4.png", width=480, height = 480 )

par(mfrow=c(2,2))

with(selected_dataset, plot(Global_active_power~full_date, type='l', xlab = "", ylab="Global Active Power (kilowatts)" ))

with(selected_dataset, plot(Voltage~full_date, type='l',  xlab = "datetime"))

with(selected_dataset, plot(Sub_metering_1~full_date, type='l', col = "black",xlab = "", ylab="Energy sub metering" ))

with(selected_dataset, lines(Sub_metering_2~full_date, col = "red",  xlab = "", ylab="Energy sub metering" ))

with(selected_dataset, lines(Sub_metering_3~full_date, col = "blue", xlab = "", ylab="Energy sub metering" ))

legend("topright", legend=c(colnames(selected_dataset[,energy_columns])), bty = "n",col= c("black", "red", "blue"), lwd = 1, cex=0.8)

with(selected_dataset, plot(Global_reactive_power~full_date, type='l',xlab = "datetime"))

dev.off()
