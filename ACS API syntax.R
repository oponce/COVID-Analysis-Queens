#install tidy verse.
install.packages("tidycensus")

#load the necessary libraries.
library(tidycensus)
library(tidyverse)
library(janitor)

#installs your API key. 
census_api_key("14460ee241461082fa6220bb2acb9a2ca9b85fb8", install = TRUE, overwrite=TRUE)

#view variables for the ACS 2013-2017 files. 
v13 <- load_variables(2013, "acs1", cache=TRUE)

#load the unweighted sample count of the population.
unweighted_pop <- get_acs(geography = "county", 
                          variables = "B00001_001",
                          year = 2013,
                          survey = "acs1")

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
                                        total_female_HL="B01001I_017"
                                        ),
                          year = 2013,
                          survey = "acs1")