'This is Hero Hunter, a data-analysis game. Using response times and locations, 
can you figure out where the secret base of your nemesis is?'

library(dplyr)

'0) Game paramters'
#Uncomment the set.seed function to replicate my example data.
#set.seed(847446)
speed <- 15
crimes <- 400

'1) Generate superhero hideout location'
#City area is 100x100 units. Hero's base is somewhere within the middle 70x70 units.

base_x <- runif(1, 15, 85)
base_y <- runif(1, 15, 85)

'2) Generate list of crime locations'

crime_locations <- as.data.frame(cbind(runif(crimes, 0, 100), runif(crimes, 0, 100)))
names(crime_locations) <- c("Location_X", "Location_Y")

'3) Calculate travel time from base to locations'
x_squared <- (base_x - crime_locations$Location_X)^2
y_squared <- (base_y - crime_locations$Location_Y)^2

#If you want to cheat (or verify your answer), comment out the following line.
rm(base_x, base_y)

distance <- (x_squared + y_squared)^0.5
time <- distance / speed

crime_locations <- as.data.frame(cbind(crime_locations, time))
names(crime_locations)[3] <- "Response_Time_min"

'4) Add noise'
#The error rate dictates how much variation there is in each Response Time measurement.
#Each measurement is varied by a number between negative-error_rate and positive-error_rate.
error_rate <- 3

noise <- runif(length(crime_locations$Location_X), 0 - error_rate, 0 + error_rate)
crime_locations <- mutate(crime_locations, Response_Time_min = Response_Time_min + abs(noise))

'5) Output data'
#Outputs a sample of the data to the screen.
head(crime_locations)
#Writes the .csv to your default directory.
write.csv(crime_locations, "Crime_Response_Data.csv")
