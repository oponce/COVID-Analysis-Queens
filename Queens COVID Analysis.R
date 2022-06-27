#import necessary libraries.
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

#create a graph comparing the boroughs' case counts.
boro_comparison_case_counts <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=TOTAL_COVID_CASE_COUNT, fill=BOROUGH_GROUP) +
  # Note these arguments inside 'geom_bar' :
  ### stat = "identity" allows us to have both an x and y aestethic with our bar graph
  ### position = "dodge" puts the different colored bars side-by-side
  geom_bar(stat = "identity", position = "dodge")

boro_comparison_case_counts

#create a graph comparing the boroughs' death counts (probable and confirmed).
boro_comparison_death_counts <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=TOTAL_COVID_DEATH_COUNT, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")

boro_comparison_death_counts

#create a graph comparing the boroughs' covid positive rate (probable and confirmed).
boro_comparison_COVID_rates <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_COVID_RATE, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")

#create a graph comparing the boroughs' confirmed covid death rate
boro_comparison_confirmed_COVID_deat_rates <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_CONFIRMED_DEATH_RATE, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")

boro_comparison_confirmed_COVID_deat_rates

#create a graph comparing the boroughs' confirmed covid death rate
boro_comparison_COVID_positive_tests <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_PERCENT_POSITIVE, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")

boro_comparison_COVID_positive_tests

#create a graph comparing the boroughs' confirmed covid death rate
boro_comparison_COVID_positive_tests <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_PERCENT_POSITIVE, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")

boro_comparison_COVID_positive_tests

#create a graph comparing the boroughs' the number of covid tests in each borough
boro_comparison_COVID_tests <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_COVID_TESTS, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")

boro_comparison_COVID_tests

#create a graph comparing the boroughs' populations
boro_comparison_pop <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=TOTAL_POP_DENOMINATOR, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")

boro_comparison_pop