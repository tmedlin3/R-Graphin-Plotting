data <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

selected_dataset <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

selected_dataset$Global_active_power <- as.numeric(selected_dataset$Global_active_power)

png(filename="plot1.png", width=480, height = 480 )

par(las=1)

plot1 <- hist(selected_dataset$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")

dev.off()