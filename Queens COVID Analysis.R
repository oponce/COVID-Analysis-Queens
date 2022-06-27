#load necessary libraries.
library('tidyverse')
library('janitor')

#read the corona virus data by zipcode csv data file. 
coronavirus_data <- read_csv('data-by-modzcta.csv')

#Comparison of Queens neighborhoods. 
queens_covid_data <- coronavirus_data %>%
  filter(BOROUGH_GROUP=="Queens")%>%
  mutate(COUNT_POSITIVE = PERCENT_POSITIVE*.01*TOTAL_COVID_TESTS)

#Borough comparisons:select certain rows, calculate the number of positive covid tests,
#aggregate the data by borough, and compute certain calculations. 
borough_covid_data <- coronavirus_data %>% 
  select(MODIFIED_ZCTA,NEIGHBORHOOD_NAME,BOROUGH_GROUP,
         COVID_CONFIRMED_CASE_COUNT,COVID_PROBABLE_CASE_COUNT,COVID_CASE_COUNT,
         POP_DENOMINATOR,COVID_CONFIRMED_DEATH_COUNT,COVID_PROBABLE_DEATH_COUNT,
         COVID_DEATH_COUNT, PERCENT_POSITIVE,TOTAL_COVID_TESTS)%>%
  mutate(COUNT_POSITIVE = PERCENT_POSITIVE*.01*TOTAL_COVID_TESTS)%>%
  group_by(BOROUGH_GROUP) %>% # set up to aggregate by boroough
  summarize(zipcodes=n(), #count of zipcodes in each borough
            TOTAL_COVID_CONFIRMED_CASE_COUNT=sum(COVID_CONFIRMED_CASE_COUNT),
            TOTAL_COVID_PROBABLE_CASE_COUNT=sum(COVID_PROBABLE_CASE_COUNT),
            TOTAL_COVID_CASE_COUNT=sum(COVID_CASE_COUNT),
            TOTAL_POP_DENOMINATOR=sum(POP_DENOMINATOR),
            TOTAL_COVID_CONFIRMED_DEATH_COUNT=sum(COVID_CONFIRMED_DEATH_COUNT),
            TOTAL_COVID_PROBABLE_DEATH_COUNT= sum(COVID_PROBABLE_DEATH_COUNT),
            TOTAL_COVID_DEATH_COUNT=sum(COVID_DEATH_COUNT),
            TOTAL_COUNT_POSITIVE=sum(COUNT_POSITIVE),
            BOROUGH_COVID_TESTS=sum(TOTAL_COVID_TESTS))%>%
  mutate(BOROUGH_CONFIRMED_COVID_RATE=(TOTAL_COVID_CONFIRMED_CASE_COUNT/TOTAL_POP_DENOMINATOR)*100000)%>%
  mutate(BOROUGH_COVID_RATE=(TOTAL_COVID_CASE_COUNT/TOTAL_POP_DENOMINATOR)*100000)%>%
  mutate(BOROUGH_CONFIRMED_DEATH_RATE=(TOTAL_COVID_CONFIRMED_DEATH_COUNT/TOTAL_POP_DENOMINATOR)*100000)%>%
  mutate(BOROUGH_COVID_DEATH_RATE=(TOTAL_COVID_DEATH_COUNT/TOTAL_POP_DENOMINATOR)*100000)%>%
  mutate(BOROUGH_PERCENT_POSITIVE=(TOTAL_COUNT_POSITIVE/BOROUGH_COVID_TESTS))
  
write_csv(queens_covid_data, "Queens COVID data by zipcode.csv")
write_csv(borough_covid_data, "Borough COVID data.csv")