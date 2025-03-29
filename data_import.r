setwd("~/Documents/D4G")

library(tidyverse)

#import all reports raw data
call_reports_20_23 <- read_csv("./2020-2023/CallReports.csv")
call_reports_20_23_links <- read_csv("./2020-2023/CallReportsLinkedTogether.csv", skip = 2)

call_reports_24 <- read_csv("./2024/Call Reports.csv")
call_reports_24_links <- read_csv("./2024/CallReportsLinkedTogether.csv")


call_data <- merge(call_reports_20_23, call_reports_24, all=TRUE, sort=FALSE)

names_20_23<- as.data.frame(names(call_reports_20_23)) %>% add_column(Years = "2020-2023", Indicator=1) %>% rename( 'names' =`names(call_reports_20_23)`) 
names_24<- as.data.frame(names(call_reports_24)) %>% add_column(Years = "2024", Indicator=1) %>% rename( 'names' =`names(call_reports_24)`)


#combine names list into one and transpose to identify which variables are in which files
variable_list <- rbind(names_20_23, names_24) %>%
    pivot_wider(id_cols = "names", names_from = "Years", values_from = "Indicator", values_fill = 0)

#Report Versions
rep_version_list1<- as_tibble(unique(call_reports_20_23$ReportVersion))
rep_version_list2<- as_tibble(unique(call_reports_24$ReportVersion))

rep_list <- as_tibble(unique(rbind(rep_version_list1, rep_version_list2)))


unique_list <- function(var) {
    summary_list <- as_tibble(unique(var))
    return(summary_list)
}

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

