#set location for files saved
#setwd("~/Documents/D4G")
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/D4G 2025 Hackathon/")
#import libraries
library(tidyverse)


#import all reports raw data
call_reports_20_23 <- read_csv("./RawData/CMHA - 211/2020-2023/CallReports.csv")
call_reports_20_23_links <- read_csv("./RawData/CMHA - 211/2020-2023/CallReportsLinkedTogether.csv", skip = 2)

call_reports_24 <- read_csv("./RawData/CMHA - 211/2024/Call Reports.csv")
call_reports_24_links <- read_csv("./RawData/CMHA - 211/2024/CallReportsLinkedTogether.csv")

#merge call data into one data frame
call_data <- merge(call_reports_20_23, call_reports_24, all=TRUE, sort=FALSE)

#add years to the variables to make it easier to combine
names_20_23<- as.data.frame(names(call_reports_20_23)) %>% add_column(Years = "2020-2023", Indicator=1) %>% rename( 'names' =`names(call_reports_20_23)`) 
names_24<- as.data.frame(names(call_reports_24)) %>% add_column(Years = "2024", Indicator=1) %>% rename( 'names' =`names(call_reports_24)`)


#combine names list into one and transpose to identify which variables are in which files
variable_list <- rbind(names_20_23, names_24) %>%
  pivot_wider(id_cols = "names", names_from = "Years", values_from = "Indicator", values_fill = 0)

#Report Versions Variable analysis
rep_version_list1<- as_tibble(unique(call_reports_20_23$ReportVersion))
rep_version_list2<- as_tibble(unique(call_reports_24$ReportVersion))

#combine report versions from both data sets
rep_list <- as_tibble(unique(rbind(rep_version_list1, rep_version_list2)))

#function to return unique list 
unique_list <- function(var) {
  summary_list <- as_tibble(unique(var))
  return(summary_list)
}

#identify all columns with more than 200 unique values
columns_with_many_unique_values <- call_data %>%
  summarise(across(everything(), ~n_distinct(.))) %>%
  gather(key = "column", value = "unique_count") %>%
  filter(unique_count > 200)

#check each variable and remove the ones that are too many
referrals_made <- unique_list(call_data$ReferralsMade)
check10 <- unique_list(call_data$`Call Information - How did you hear - Other please describe`)
#Remove
check11 <- unique_list(call_data$`Call overview - Offender (relationship to PAR)`)
#Remove
check12 <- unique_list(call_data$`Call overview - Person(s) at Risk`)
#Remove
check13 <- unique_list(call_data$`Chat Information - Counselor Response Time`)
#numeric, fine to keep
check14 <- unique_list(call_data$`Special Codes - Special Codes`)
#fixed values, fine
check15 <- unique_list(call_data$`Safety and Rescue  - Explore...143`)
#fixed values, fine
check16 <- unique_list(call_data$`Safety and Rescue  - Explore...147`)

check17<- unique_list(call_data$`other-how did you hear - other`)
#REMOVE

check18 <-unique_list(call_data$`Call Information - How did you hear - Other please describe`)


#no issue
Safety169 <- unique_list(call_data$`Safety and Rescue  - Resources (PIE) - Did you discuss?`)
Safety168 <- unique_list(call_data$`Safety and Rescue  - Prior History`)
Safety167 <- unique_list(call_data$`Safety and Rescue  - Pain and Present Acute State`)
Safety166 <- unique_list(call_data$`Safety and Rescue  - Is the PAR presently safe?`)
Safety165 <- unique_list(call_data$`Safety and Rescue  - Explore...148`)
Safety164 <- unique_list(call_data$`Safety and Rescue  - Explore...147`)
Safety163 <- unique_list(call_data$`Safety and Rescue  - Does the PAR have a suicide plan with accessible means?`)
Safety162 <- unique_list(call_data$`Safety and Rescue  - Did you offer a follow up?`)
Safety161 <- unique_list(call_data$`Safety and Rescue  - Did you define uncertainty?`)
Safety160 <- unique_list(call_data$`Safety and Rescue  - Can the PAR stay safe for the duration of the call?`)

ThirdParty159 <- unique_list(call_data$`Third Party  - Suicide in progress`)
ThirdParty158 <- unique_list(call_data$`Third Party  - Have you thought about suicide in the last two months?`)
ThirdParty157 <- unique_list(call_data$`Third Party  - Have you ever attempted to kill yourself?`)
ThirdParty156<- unique_list(call_data$`Third Party  - Are you thinking of suicide?`)

char_columns <- sapply(call_data, is.character)

# Print the names of character columns
list_vars_check<-as_tibble(names(char_columns[char_columns]))
