#
# Coursera Data Science Specialization
# Exploratory Data Analysis
# author: ckkhan
# date: 29th May 2016
#
# This script constructs Plot 4 of Project 1 (please see README.md)
#

# main procedure to house the script. takes an optional parameter which tells
# it if it should insist on redownloading the source data and overwriting the
# existing copy, if any.
plot4_main <- function(overwrite=FALSE) {
    
    # load required R packages
    library(data.table)
    
    # retrieve a fresh copy of the data set, if missing or required
    url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zfn<-"household_power_consumption.zip"
    fn<-"household_power_consumption.txt"
    if(!file.exists(fn) || overwrite) {
        download.file(url, zfn, mode="wb")
        unzip(zfn, overwrite=TRUE, exdir=getwd())
    }

    # load data set into R, clean column names and filter to only those
    # rows required (where date is either "01/02/2007" or "02/02/2007")
    pc<<-fread(fn, sep=";", header=TRUE, na.strings="?")
    colnames(pc)<<-tolower(colnames(pc))
    pc<<-pc[pc$date=="1/2/2007" | pc$date=="2/2/2007"]
    
    # convert the date time columns
    pc$time<<-as.POSIXct(paste(pc$date, pc$time, sep=" "), format="%d/%m/%Y %T")
    pc$date<<-as.POSIXct(pc$date, format="%d/%m/%Y")

    # the plot (4 in 1, 2x2 layout)
    par(mfcol=c(2,2))
    
    # topleft plot
    plot(pc$time, pc$global_active_power, type="l", xlab="", ylab="Global Active Power")
    
    # bottomleft plot
    plot(pc$time, pc$sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    points(pc$time, pc$sub_metering_2, type="l", col="red")
    points(pc$time, pc$sub_metering_3, type="l", col="blue")
    legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), bty="n", lty=1, cex=0.8)
    
    # topright plot
    plot(pc$time, pc$voltage, type="l", xlab="datetime", ylab="Voltage")
    
    # bottomright plot
    plot(pc$time, pc$global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    
    # copy plot to png and save
    dev.copy(png, filename="plot4.png", width=480, height=480, units="px")
    dev.off()
    
}

# lines after this are meant for kick starting the script
plot4_main()
