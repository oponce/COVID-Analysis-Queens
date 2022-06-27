# COVID Analysis Queens
MSPP Policy and Data Studio project

This folder contains COVID-19 CSV data files providing cumulative totals of cases and deaths since the start of the COVID-19 outbreak in NYC, which the Health Department defines as the diagnosis of the first confirmed COVID-19 case on February 29, 2020. Additionally, this folder houses R script files used to analyze the "data by zipcode" CSV file to provide borough breakouts of case counts, deaths, and positive covid tests. 

# data-by-modzcta.csv   

This file contains data by MODZCTA. Please see the technical notes for a description of MODZCTA ([Geography: Zip codes and ZCTAs](https://github.com/nychealth/coronavirus-data#geography-zip-codes-and-zctas)).

Indicators include: 

| Variable name | Definition | Timeframe | 
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------:| 
| MODIFIED_ZCTA | MODZCTA | |          
| NEIGHBORHOOD_NAME | Neighborhood name of the MODZCTA | |   
| BOROUGH_GROUP | Borough of the MODZCTA | | 
| LABEL | List of the ZCTAs that are bundled into the MODZCTA | |   
| LAT | Latitude of the central point within the MODZCTA | | 
| LONG | Longitude of the central point within the MODZCTA | |  
| COVID_CONFIRMED_CASE_COUNT | Number of confirmed cases by MODZCTA | Cumulative | 
| COVID_PROBABLE_CASE_COUNT | Number of probable cases by MODZCTA | Cumulative | 
| COVID_CASE_COUNT | Number of confirmed and probable cases by MODZCTA | Cumulative | 
| COVID_CONFIRMED_CASE_RATE | Rate of confirmed cases per 100,000 people by MODZCTA | Cumulative | 
| COVID_CASE_RATE | Rate of confirmed and probable cases per 100,000 people by MODZCTA | Cumulative | 
| POP_DENOMINATOR | Population denominators for MODZCTA derived from intercensal estimates by the Bureau of Epidemiology Services (see “Rates per 100,000 people” for more details) | | 
| COVID_CONFIRMED_DEATH_COUNT | Number of confirmed deaths by MODZCTA | Cumulative | 
| COVID_PROBABLE_DEATH_COUNT | Number of probable deaths by MODZCTA | Cumulative | 
| COVID_DEATH_COUNT | Number of confirmed and probable deaths by MODZCTA | Cumulative | 
| COVID_CONFIRMED_DEATH_RATE | Rate of confirmed deaths per 100,000 people by MODZCTA | Cumulative | 
| COVID_DEATH_RATE | Rate of confirmed and probable deaths per 100,000 people by MODZCTA | Cumulative | 
| PERCENT_POSITIVE | Percentage of people ever tested for COVID-19 with a molecular test who tested positive by MODZCTA | Cumulative | 
| TOTAL_COVID_TESTS | Number of people tested for COVID-19 with a molecular test by MODZCTA | Cumulative | 

Neighborhood names represent the [Neighborhood Organizing Census Committee](https://www1.nyc.gov/site/census/index.page) boundaries, which were recently developed by the U.S. Census Bureau with input from community groups.  

Note that sum of counts in this file may not match values in citywide tables because of records with missing geographic information.