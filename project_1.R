# Coursera course "Exploratory Data Analysis" Project 1
#
rm(list = ls())
setwd("~/Code/ExploratoryDataAnalysis-Project-1")

my_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = my_url, destfile = "Dataset.zip", method = "curl")
unzip(zipfile = "Dataset.zip")