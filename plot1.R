#
# Coursera Data Science Specialization
# Exploratory Data Analysis
# author: ckkhan
# date: 29th May 2016
#
# This script constructs Plot 1 of Project 1 (please see README.md)
#

# main procedure to house the script. takes an optional parameter which tells
# it if it should insist on redownloading the source data and overwriting the
# existing copy, if any.
plot1_main <- function(overwrite=FALSE) {
    
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

    # the plot
    hist(pc$global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
    
    # copy plot to png and save
    dev.copy(png, filename="plot1.png", width=480, height=480, units="px")
    dev.off()
    
}

# lines after this are meant for kick starting the script
plot1_main()
