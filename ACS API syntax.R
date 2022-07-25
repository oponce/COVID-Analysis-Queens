#install tidycensus.
install.packages("tidycensus")

#load the necessary libraries.
library(tidycensus)
library(tidyverse)
library(janitor)

#install your API key (register online). 
census_api_key("14460ee241461082fa6220bb2acb9a2ca9b85fb8", install = TRUE, overwrite=TRUE)

#view variables for the ACS 2013 files. 
v13 <- load_variables(2013, "acs1", cache=TRUE)

#write CSV for 2013 variable information
write_csv(v13, "ACS 2013 variable list.csv")

#load various demographic variables for the ACS 2013.
demography13 <- get_acs(geography = "county", 
                        variables = c(total_population= "B00001_001", 
                                      total_male="B01001_002",
                                      total_female="B01001_026",
                                      total_male_white="B01001A_002",
                                      total_female_white="B01001A_017",
                                      total_male_black="B01001B_002",
                                      total_female_black="B01001B_017",
                                      total_male_AIAN="B01001C_002",
                                      total_female_AIAN="B01001C_017",
                                      total_male_asian="B01001D_002",
                                      total_female_asian="B01001D_017",
                                      total_male_NHPI="B01001E_002",
                                      total_female_NHPI="B01001E_017",
                                      total_male_other="B01001F_002",
                                      total_female_other="B01001F_017",
                                      total_male_2ormore="B01001G_002",
                                      total_female_2ormore="B01001G_017",
                                      total_male_NH_white="B01001H_002",
                                      total_female_NH_white="B01001H_017",
                                      total_male_HL="B01001I_002",
                                      total_female_HL="B01001I_017"),
                        year = 2013,
                        survey = "acs1")

#view variables for the ACS 2019 file.
v19 <- load_variables(2019, "acs1", cache=TRUE)

#load various employment/labor variables for the ACS 2019.
demography19 <- get_acs(geography = "county", 
                          variables = c(employment16plus= "B23001_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER
                                        employment16pluswhite="B23002A_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (WHITE ONLY)
                                        employment16plusblack="B23002B_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (BLACK ONLY)
                                        employment16plusAIAN="B23002C_001",  #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (American Indian & Alaskan Native ONLY)
                                        employment16plusasian="B23002D_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (ASIAN ONLY)
                                        employment16plusNHPI="B23002E_001",  #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (Native Hawaiian or Pacific Islander ONLY)
                                        employment16plusother="B23002F_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (Some other race ONLY)
                                        employment16plus2ormore="B23002G_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (TWO OR MORE RACES)
                                        employment16pluswhiteNH="B23002H_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (non hispanic white only)
                                        employment16plusHSL="B23002I_001",     #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (HISPANIC or LATINO ONLY)
                                        educationHSdiploma="B15003_017", #EDUCATIONAL ATTAINMENT (HIGH SCHOOL DEGREE) FOR THE POPULATION 25 YEARS AND OVER
                                        educationGED="B15003_018", #EDUCATIONAL ATTAINMENT (GED) FOR THE POPULATION 25 YEARS AND OVER
                                        educationassociates="B15003_021", #EDUCATIONAL ATTAINMENT (associates) FOR THE POPULATION 25 YEARS AND OVER
                                        educationbachelors="B15003_022",
                                        educationmasters="B15003_023",
                                        educationprofessionaldegree="B15003_024",
                                        educationdoctorate="B15003_025"
                                        ),
                          year = 2019,
                          survey = "acs1")

#filter the newly created dataset to include only New York CIty data. 
NYC_demography19 <- demography19%>% filter(NAME=="Kings County, New York" | NAME=="Queens County, New York" | NAME=="Bronx County, New York" | NAME=="New York County, New York" |NAME=="Richmond County, New York")

#write CSV for 2019 New York City  information
write_csv(NYC_demography19, "NYC Employment and Education Data.csv")

#view variables for the ACS 2014 file. 
v14 <- load_variables(2014, "acs1", cache=TRUE)

#view variables for the ACS 2021 file.
v21 <- load_variables(2021, "acs1", cache=TRUE)

#view variables for the ABS 2020 file.
v20 <- load_variables(2020, "acs1", cache=TRUE)
