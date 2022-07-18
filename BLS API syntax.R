#install the package blsAPI.
install.packages('blsAPI')

#import necessary libraries. 
library(rjson)
library(blsAPI)
library(ggplot2)

#use code below to retrieve data for one or more time series within a set time frame of up to 20 years. 
payload <- list(
  'seriesid'=c('LAUCN360610000000004', 'LAUCN360610000000006'),
  'startyear'=2019,
  'endyear'=2021)
response <- blsAPI(payload, 2)
json <- fromJSON(response)

## Process results
apiDF <- function(data){
  df <- data.frame(year=character(),
                   period=character(),
                   periodName=character(),
                   value=character(),
                   stringsAsFactors=FALSE)
  
  i <- 0
  for(d in data){
    i <- i + 1
    df[i,] <- unlist(d)
  }
  return(df)
}
#creates the unemployed and laborforce dataframes. 
unemployed.df <- apiDF(json$Results$series[[1]]$data)
labor.force.df <- apiDF(json$Results$series[[2]]$data)

## Change value type from character to numeric
unemployed.df[,4] <- as.numeric(unemployed.df[,4])
labor.force.df[,4] <- as.numeric(labor.force.df[,4])

## Rename value prior to merging
names(unemployed.df)[4] <- 'unemployed'
names(labor.force.df)[4] <- 'labor.force'

## Merge data frames
df <- merge(unemployed.df, labor.force.df)

## Create date and unemployement rate
df$unemployment.rate <- df$unemployed / df$labor.force
df$date <- as.POSIXct(strptime(paste0('1',df$periodName,df$year), '%d%B%Y'))

