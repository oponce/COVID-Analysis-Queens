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
                                      total_white="B01001A_001",
                                      total_male_white="B01001A_002",
                                      total_female_white="B01001A_017",
                                      total_black="B01001B_001",
                                      total_male_black="B01001B_002",
                                      total_female_black="B01001B_017",
                                      total_AIAN="B01001C_001",
                                      total_male_AIAN="B01001C_002",
                                      total_female_AIAN="B01001C_017",
                                      total_asian="B01001D_001",
                                      total_male_asian="B01001D_002",
                                      total_female_asian="B01001D_017",
                                      total_NHPI="B01001E_001",
                                      total_male_NHPI="B01001E_002",
                                      total_female_NHPI="B01001E_017",
                                      total_other="B01001F_001",
                                      total_male_other="B01001F_002",
                                      total_female_other="B01001F_017",
                                      total_2ormore="B01001G_001",
                                      total_male_2ormore="B01001G_002",
                                      total_female_2ormore="B01001G_017",
                                      total_NH_white="B01001H_001",
                                      total_male_NH_white="B01001H_002",
                                      total_female_NH_white="B01001H_017",
                                      total_HL="B01001I_001",
                                      total_male_HL="B01001I_002",
                                      total_female_HL="B01001I_017",
                                      employment16plus= "B23001_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER
                                      employment16plus_male="B23001_002", #EMPLOYMENT STATUS FOR THE MALE POPULATION 16 YEARS AND OVER
                                      employment16plus_female="B23001_088", #EMPLOYMENT STATUS FOR THE FEMALE POPULATION 16 YEARS AND OVER
                                      employment16pluswhite="B23002A_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (WHITE ONLY)
                                      employment16pluswhite_male="B23002A_002", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (WHITE MALES ONLY)
                                      employment16plutswhite_female="B23002A_041", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (WHITE FEMALES ONLY)
                                      employment16plusblack="B23002B_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (BLACK ONLY)
                                      employment16plusblack_male="B23002B_002", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (BLACK ONLY MALE)
                                      employment16plusblack_female="B23002B_041", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (BLACK ONLY FEMALE)
                                      employment16plusAIAN="B23002C_001",  #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (American Indian & Alaskan Native ONLY)
                                      employment16plusAIAN_male="B23002C_002", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (American Indian & Alaskan Native ONLY Male)
                                      employment16plusAIAN_female="B23002C_041", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (American Indian & Alaskan Native ONLY Female)
                                      employment16plusasian="B23002D_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (ASIAN ONLY)
                                      employment16plusasian_male="B23002D_002" #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (ASIAN ONLY MALE)
                                      employment16plusasian_female="B23002D_041" #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (ASIAN ONLY FEMALE)
                                      employment16plusNHPI="B23002E_001",  #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (Native Hawaiian or Pacific Islander ONLY)
                                      employment16plusNHPI_male="B23002E_002" #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (Native Hawaiian or Pacific Islander ONLY MALE)
                                      employment16plusNHPI_female="B23002E_041" #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (Native Hawaiian or Pacific Islander ONLY Female)
                                      employment16plusother="B23002F_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (Some other race ONLY)
                                      employment16plusother_male="B23002F_002", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (Some other race ONLY Male)
                                      employment16plusother_female="B23002F_041", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (Some other race only Female)
                                      employment16plus2ormore="B23002G_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (TWO OR MORE RACES)
                                      employment16plus2ormore_male="B23002G_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (TWO OR MORE RACES MALE)
                                      employment16plus2ormore_female="B23002G_041", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (TWO OR MORE RACES FEMALE)
                                      employment16pluswhiteNH="B23002H_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (non Hispanic white only)
                                      employment16pluswhiteNH_male="B23002H_002", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (non Hispanic white only male)
                                      employment16pluswhiteNH_female="B23002H_041", #EMPLOYMENT STATUS FOR THE POPULATION 16 YARS AND OVER (non Hispanic white only female)
                                      employment16plusHSL="B23002I_001", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (HISPANIC or LATINO ONLY)
                                      employment16plusHSL_male="B23002I_002", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (HISPANIC OR LATINO ONLY MALE)
                                      employment16pusHSL_female="B23002I_041", #EMPLOYMENT STATUS FOR THE POPULATION 16 YEARS AND OVER (HISPANIC OR LATINO ONLY FEMALE)
                                      educationHSdiploma="B15003_017", #EDUCATIONAL ATTAINMENT (HIGH SCHOOL DEGREE) FOR THE POPULATION 25 YEARS AND OVER
                                      educationGED="B15003_018", #EDUCATIONAL ATTAINMENT (GED) FOR THE POPULATION 25 YEARS AND OVER
                                      educationassociates="B15003_021", #EDUCATIONAL ATTAINMENT (associates) FOR THE POPULATION 25 YEARS AND OVER
                                      educationbachelors="B15003_022",
                                      educationmasters="B15003_023",
                                      educationprofessionaldegree="B15003_024",
                                      educationdoctorate="B15003_025",
                                      educationHSdiploma_white_male="B15002A_005",
                                      educationGED_white_male="B15002A_006",
                                      educationassociates_white_male="B15002A_008",
                                      educationbachelors_white_male="B15002A_009",
                                      educationprofesionaldegree_white_male="B15002A_010",
                                      educationHSdiploma_white_female="B15002A_014",
                                      educationGED_white_female="B15002A_015",
                                      educationassociates_white_female="B15002A_017",
                                      educationbachelors_white_female="B15002A_018",
                                      educationprofessionaldegree_white_female="B15002A_019",
                                      educationHSdiploma_black_male="B15002B_005",
                                      educationGED_black_male="B15002B_006",
                                      educationassociates_black_male="B15002B_008",
                                      educationbachelors_black_male="B15002B_009",
                                      educationprofessionaldegree_black_male="B15002B_010",
                                      educationHSdiploma_black_female="B15002B_014",
                                      educationGED_black_female="B15002B_015",
                                      educationassociates_black_female="B15002B_017",
                                      educationbachelors_black_female="B15002B_018",
                                      educationprofessionaldegree_black_female="B15002B_019",
                                      educationHSdiploma_AIAN_male="B15002C_005",
                                      educationGED_AIAN_male="B15002C_006",
                                      educationassociates_AIAN_male="B15002C_008",
                                      educationbachelors_AIAN_male="B15002C_009",
                                      educationprofessionaldegree_AIAN_male="B15002C_010",
                                      educationHSdiploma_AIAN_female="B15002C_014",
                                      educationGED_AIAN_female="B15002C_015",
                                      educationassociates_AIAN_female="B15002C_017",
                                      educationbachelors_AIAN_female="B15002C_018",
                                      educationprofessionaldegree_AIAN_female="B15002C_019",
                                      educationHSdiploma_asian_male="B15002D_005",
                                      educationGED_asian_male="B15002D_006",
                                      educationassociates_asian_male="B15002D_008",
                                      educationbachelors_asian_male="B15002D_009",
                                      educationprofessionaldegree_asian_male="B15002D_010",
                                      educationHSdiploma_asian_female="15002D_014",
                                      educationGED_asian_female="B15002D_015",
                                      educationassociates_asian_female="B15002D_017",
                                      educationbachelors_asian_female="B15002D_018",
                                      educationprofessionaldegree_asian_female="B15002D_019",
                                      educationHSdiploma_NHPI_male="B15002E_005",
                                      educationGED_NHPI_male="B15002E_006",
                                      educationassociates_NHPI_male="B15002E_008",
                                      educationbachelors_NHPI_male="B15002E_009",
                                      educationprofessionaldegree_NHPI_male="B15002E_010",
                                      educationHSdiploma_NHPI_female="B15002E_014",
                                      educationGED_NHPI_female="B15002E_015",
                                      educationassociates_NHPI_female="B15002E_017",
                                      educationbachelors_NHPI_female="B15002E_018",
                                      educationprofessionaldegree_NHPI_female="B15002E_019",
                                      educationHSdiploma_otherrace_male="B15002F_005",
                                      educationGED_otherrace_male="B15002F_006",
                                      educationassociates_otherrace_male="B15002F_008",
                                      educationbachelors_otherrace_male="B15002F_009",
                                      educationprofessionaldegree_otherrace_male="B15002F_010",
                                      educationHSdiplomma_otherrace_female="B15002F_014",
                                      educationGED_otherrace_female="B15002F_015",
                                      educationassociates_otherrace_female="B15002F_017",
                                      educationbachelors_otherrace_female="B15002F_018",
                                      educationprofessionaldegree_otherrace_female="B15002F_019",
                                      educationHSdiploma_2ormore_male="B15002G_005",
                                      educationGED_2ormore_male="B15002G_006",
                                      educationassociates_2ormore_male="B15002G_008",
                                      educationbachelors_2ormore_male="B15002G_009",
                                      educationprofessionaldegree_2ormore_male="B15002G_010",
                                      educationHSdiploma_2ormore_female="B15002G_014",
                                      educationGED_2ormore_female="B15002G_015",
                                      educationassociates_2ormore_female="B15002G_017",
                                      educationbachelors_2ormore_female="B15002G_018",
                                      educationprofessionaldegree_2ormore_female="B15002G_019",
                                      educationHSdiploma_WNH_male_="B15002H_005",
                                      educationGED_WNH_male="B15002H_006",
                                      educationassociates_WNH_male="B15002H_008",
                                      educationbachelors_WNH_male="B15002H_009",
                                      educationprofesionaldegree_WNH_male="B15002H_010",
                                      educationHSdiploma_WNH_female="B15002H_014",
                                      educationGED_WNH_female="B15002H_015",
                                      educationassociates_WNH_female="B15002H_017",
                                      educationbachelors_WNH_female="B15002H_018",
                                      educationprofessionaldegree_WNH_female="B15002H_019",
                                      
                                      ),
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
