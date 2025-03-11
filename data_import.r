#set location for files saved
setwd("~/Documents/D4G")

#import libraries
library(tidyverse)
library(readxl)


#import crisis raw data deleting extra columns
crisis_2015_2016 <- read_xlsx("Crisis and CT Raw data 2015-2016.xlsx", skip=2)[,1:105]

crisis_2017_2018 <- read_xlsx("Crisis and CT Raw data 2017-2018.xlsx", skip=2)[,1:114]

crisis_2019 <- read_xlsx("Crisis and CT Raw data 2019 Old Call Form.xlsx", skip=2)[,1:114]

crisis_2020 <- read_xlsx("Crisis and CT Raw data 2020.xlsx", skip=2)

crisis_2021_2022 <- read_xlsx("Crisis and CT Raw data 2021-2022.xlsx", skip=2)[,1:125]

crisis_2023_2024 <- read_xlsx("Crisis and CT Raw data 2023-2024.xlsx", skip=2)[,1:124]

#put names into lists with filenames
names_1516<- as.data.frame(names(crisis_2015_2016)) %>% add_column(Years = "2015 & 2016", Indicator=1) %>% rename( 'names' =`names(crisis_2015_2016)`) 
names_1718<- as.data.frame(names(crisis_2017_2018)) %>% add_column(Years = "2017 & 2018", Indicator=1) %>% rename( 'names' =`names(crisis_2017_2018)`)
names_19<- as.data.frame(names(crisis_2019)) %>% add_column(Years = "2019", Indicator=1) %>% rename( 'names' =`names(crisis_2019)`)
names_20<- as.data.frame(names(crisis_2020)) %>% add_column(Years = "2020", Indicator=1) %>% rename( 'names' =`names(crisis_2020)`)
names_2122<- as.data.frame(names(crisis_2021_2022)) %>% add_column(Years = "2021 & 2022", Indicator=1) %>% rename( 'names' =`names(crisis_2021_2022)`)
names_2324<- as.data.frame(names(crisis_2023_2024)) %>% add_column(Years = "2023 & 2024", Indicator=1) %>% rename( 'names' =`names(crisis_2023_2024)`)


#combine names list into one and transpose to identify which variables are in which files
variable_list <- rbind(names_1516, names_1718, names_19, names_20, names_2122, names2324) %>%
    pivot_wider(id_cols = "names", names_from = "Years", values_from = "Indicator", values_fill = 0)
