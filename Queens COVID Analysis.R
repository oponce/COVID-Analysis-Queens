#import necessary libraries.
library('tidyverse')
library('janitor')
library('dplyr')

#read the corona virus data by zipcode csv data file. 
coronavirus_data <- read_csv('data-by-modzcta.csv')
################################################################################################
#Comparison of Queens' neighborhoods, sort descending by confirmed covid case count. 
queens_covid_data <- coronavirus_data %>%
  filter(BOROUGH_GROUP=="Queens")%>%
  mutate(COUNT_POSITIVE = PERCENT_POSITIVE*.01*TOTAL_COVID_TESTS)%>%
  arrange(desc(COVID_CONFIRMED_CASE_COUNT))

#write CSV of the queens covid data file to utilize in QGIS. 
write_csv(queens_covid_data, "Queens COVID Data.csv")

#select the first 10 rows of the dataset for comparison across confirmed covid case count. 
top10_confirmed_covid <- queens_covid_data[1:10,]

#write CSV of the top 10 confirmed covid.
write_csv(top10_confirmed_covid, "Top 10 Queens Neighborhoods Confirmed COVID.csv")

#arrange the queens covid dataset by covid confirmed death count. 
queens_covid_data <- queens_covid_data %>% arrange(desc(COVID_CONFIRMED_DEATH_COUNT))

#select the first 10 rows of the dataset for comparison across confirmed covid death count. 
top10_confirmed_covid_death <- queens_covid_data[1:10,]

#write CSV of the top 10 confirmed covid death.
write_csv(top10_confirmed_covid_death, "Top 10 Queens Neighborhoods Confirmed COVID Deaths.csv")

#arrange the queens covid dataset by covid case rate. 
queens_covid_data <- queens_covid_data %>% arrange(desc(COVID_CASE_RATE))

#select the first 10 rows of the dataset for comparison across covid case rate. 
top10_covid_case_rate <- queens_covid_data[1:10,]

#write CSV of the top 10 confirmed covid case rate.
write_csv(top10_covid_case_rate, "Top 10 Queens Neighborhoods COVID Case Rate.csv")

#arrange the queens covid dataset by total covid tests. 
queens_covid_data <- queens_covid_data %>% arrange(desc(TOTAL_COVID_TESTS))

#select the first 10 rows of the dataset for comparison across confirmed covid death count. 
top10_total_covid_tests <- queens_covid_data[1:10,]

#write CSV of the top 10 total covid tests.
write_csv(top10_total_covid_tests, "Top 10 Queens Neighborhoods TOtal COVID Tests.csv")

##########################################################################################################
#Borough comparisons:select certain rows, calculate the number of positive covid tests,
#aggregate the data by borough, and compute certain calculations. 
borough_covid_data <- coronavirus_data %>% 
  select(MODIFIED_ZCTA,NEIGHBORHOOD_NAME,BOROUGH_GROUP,
         COVID_CONFIRMED_CASE_COUNT,COVID_PROBABLE_CASE_COUNT,COVID_CASE_COUNT,
         POP_DENOMINATOR,COVID_CONFIRMED_DEATH_COUNT,COVID_PROBABLE_DEATH_COUNT,
         COVID_DEATH_COUNT, PERCENT_POSITIVE,TOTAL_COVID_TESTS)%>%
  mutate(COUNT_POSITIVE = PERCENT_POSITIVE*.01*TOTAL_COVID_TESTS)%>%
  group_by(BOROUGH_GROUP) %>% # set up to aggregate by borough
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
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(name="COVID Case Count",labels = scales::unit_format(scale = 1/1000, unit="K")) +
  scale_x_discrete(name="Borough") +
  scale_fill_discrete(name="Borough") +
  labs(
    title = "Total COVID Case Count by Borough",
    subtitle = "Data as of July 8th 2022",
    caption = "Source:https://github.com/nychealth/coronavirus-data") +
  geom_text(aes(label=scales::comma(TOTAL_COVID_CASE_COUNT)), position=position_dodge(width=0.9), vjust=1.25) +
  theme(plot.subtitle=element_text(size=9, hjust=0.5))

boro_comparison_case_counts

#create a graph comparing the boroughs' death counts (probable and confirmed).
boro_comparison_death_counts <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=TOTAL_COVID_DEATH_COUNT, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge") +  
  scale_y_continuous(name="COVID Death Count",labels = scales::unit_format(scale = 1/1000, unit="K")) +
  scale_x_discrete(name="Borough") +
  scale_fill_discrete(name="Borough") +
  labs(
    title = "Total COVID Death Count by Borough",
    subtitle = "Data as of July 8th 2022",
    caption = "Source:https://github.com/nychealth/coronavirus-data") +
  geom_text(aes(label=scales::comma(TOTAL_COVID_DEATH_COUNT)), position=position_dodge(width=0.9), vjust=1.25) +
  theme(plot.subtitle=element_text(size=9, hjust=0.5))

boro_comparison_death_counts

#create a graph comparing the boroughs' covid case rate (probable and confirmed).
boro_comparison_COVID_rates <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_COVID_RATE, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")+
  scale_y_continuous(name="COVID Case Rate",labels = scales::unit_format(scale = 1/1000, unit="K")) +
  scale_x_discrete(name="Borough") +
  scale_fill_discrete(name="Borough") +
  labs(
    title = "COVID Case Rate (per 100,000 people) by Borough",
    subtitle = "Data as of July 8th 2022",
    caption = "Source:https://github.com/nychealth/coronavirus-data") +
  geom_text(aes(label=scales::comma(round(BOROUGH_COVID_RATE))), position=position_dodge(width=0.9), vjust=1.25) +
  theme(plot.subtitle=element_text(size=9, hjust=0.5))

boro_comparison_COVID_rates

#create a graph comparing the boroughs' confirmed covid death rate
boro_comparison_confirmed_COVID_deat_rates <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_CONFIRMED_DEATH_RATE, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge")+
  scale_y_continuous(name="Confirmed COVID Death Rate") +
  scale_x_discrete(name="Borough") +
  scale_fill_discrete(name="Borough") +
  labs(
    title = "Confirmed COVID Death Rate by Borough",
    subtitle = "Data as of July 8th 2022",
    caption = "Source:https://github.com/nychealth/coronavirus-data") +
  geom_text(aes(label=round(BOROUGH_CONFIRMED_DEATH_RATE)), position=position_dodge(width=0.9), vjust=1.25) +
  theme(plot.subtitle=element_text(size=9, hjust=0.5))

boro_comparison_confirmed_COVID_deat_rates

#create a graph comparing the boroughs' percentage of covid tests that were positive.
boro_comparison_COVID_positive_tests <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_PERCENT_POSITIVE, fill=BOROUGH_GROUP, label=scales::percent(round(BOROUGH_PERCENT_POSITIVE, digits=2))) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(name="Percent of COVID Tests Positive",labels = scales::percent) +
  scale_x_discrete(name="Borough") +
  scale_fill_discrete(name="Borough") +
  labs(
    title = "Percent of COVID Tests Positive by Borough",
    subtitle = "Data as of July 8th 2022",
    caption = "Source:https://github.com/nychealth/coronavirus-data") +
  geom_text(position=position_dodge(width=0.9), vjust=1.25) +
  theme(plot.subtitle=element_text(size=9, hjust=0.5))

boro_comparison_COVID_positive_tests

#create a graph comparing the boroughs' the total number of covid tests in each borough
boro_comparison_COVID_tests <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=BOROUGH_COVID_TESTS, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(name="Number of COVID Tests",labels = scales::unit_format(scale = 1/1000, unit="K")) +
  scale_x_discrete(name="Borough") +
  scale_fill_discrete(name="Borough") +
  labs(
    title = "Number of COVID Tests by Borough",
    subtitle = "Data as of July 8th 2022",
    caption = "Source:https://github.com/nychealth/coronavirus-data") +
  geom_text(aes(label=scales::comma(BOROUGH_COVID_TESTS)), position=position_dodge(width=0.9), vjust=1.25, size=3) +
  theme(plot.subtitle=element_text(size=9, hjust=0.5))

boro_comparison_COVID_tests

#create a graph comparing the boroughs' populations
boro_comparison_pop <- ggplot(borough_covid_data) +
  aes(x=BOROUGH_GROUP, y=TOTAL_POP_DENOMINATOR, fill=BOROUGH_GROUP) +
  geom_bar(stat = "identity", position = "dodge") + 
  scale_y_continuous(name="Number of People",labels = scales::unit_format(scale = 1/1000, unit="K")) +
  scale_x_discrete(name="Borough") +
  scale_fill_discrete(name="Borough") +
  labs(
    title = "Population by Borough",
    subtitle = "Data as of July 8th 2022",
    caption = "Source:https://github.com/nychealth/coronavirus-data") +
  geom_text(aes(label=scales::comma(TOTAL_POP_DENOMINATOR)), position=position_dodge(width=0.9), vjust=1.25, size=3) +
  theme(plot.subtitle=element_text(size=9, hjust=0.5))

boro_comparison_pop