
# Author: Sarah McDougald
# Version: 12-4-2017
# Purpose: data scraping

# NOTE: Credit for the scraping part goes to the authors at R-bloggers.com. 
#       Guide found at: https://www.r-bloggers.com/using-rvest-to-scrape-an-html-table/

#################################################################################

# OUTLINE

# 1. Header
# 2. Outline
# 3. Preliminary attempt: Unity 2010 and 2011 data tables
#       a. data scraping from Wikipedia
# 4. Full data collection 
#       a. Unity
#           I) 2010 table
#           II) 2011 table
#           III) 2012 table
#           IV) 2013 table
#       b. Unreal
#           I) Unreal 1
#           II) Unreal 2 - 2010-2013
#           III) Unreal 3 - 2010-2013
#           IV) Unreal 1
#       c. CryEngine
#           I) CryEngine 1
#           II) CryEngine 2
#           III) CryEngine 3 - 2011-2013 (NOTE: no 2010 data. And, very limited data. 
#                   May need to drop this engine.)


# JUSTIFICATION FOR DATA: Since the original dataset was posted in 2014, most of the games in it should have been
#   reviewed before that.
# Most reliable data is from 2010 and later. Thus: 2010-2013 was the year range I picked for my games. ***


# ?. misc notes [to be removed]


# 3 data sources: 

# Unity: https://en.wikipedia.org/wiki/List_of_Unity_games
# Unreal: https://en.wikipedia.org/wiki/List_of_Unreal_Engine_games
# CryEngine: https://en.wikipedia.org/wiki/List_of_CryEngine_games




#################################################################################

# misc notes go here

# - might be nice to have ALLLLL the code needed for this project in ONE R script. As long as it's
#   well organized.

# - Note that the "Preliminary attempt" section also includes the cleaning right next to it. Will
#   want to make sure things are clearly organized when scraping ALL the data. And leave clear notes as to
#   which table is being scraped/worked on with each code section.

# - GOAL: try to finish all of the scraping tonight. and maybe all the cleaning too?


# ~ Questions ~
#   + should I have a ton of different R scripts for the various tasks? just one? two? (one for prep, one for
#     analysis)? three? (one for scraping, one for cleaning, one for analysis)?
#   +


# ~ after scraping the 2010 dataset... ~
# Okay, some things that need to be done to clean it up, that I can see right off the bat:
#   - Will need to standardize the DATES. Could just go by year and cut off everything else.
#   - PROBLEM: the `Platform` and `Publisher` columns have a '....'
#       -> solution: IGNORE FOR NOW. Need to get the bare bones up and running and NOT sweat the small details.



# What are the MOST important data columns....?
#     - The Engine column. Because we'll be comparing by engine. (this column will be added)
#     - 




# JUSTIFICATION FOR DATA: Since the original dataset was posted in 2014, most of the games in it should have been
#   reviewed before that.
# Most reliable data is from 2010 and later. Thus: 2010-2013 was the year range I picked for my games. ***



# All available wikipedia data tables with entries from before 2014 were included in the scraping.
# The original IGN ratings dataset is also imported from an Excel file.
# NOTE: after downloading the original IGN dataset Excel document, I copied and pasted only Sheet 1 of that 
    # Excel document; the other sheets will not be used for this EDA.



#################################################################################


library(rvest)
library(tidyverse)
library(readxl)

# STEP 1. SCRAPED DATA



######## UNITY TABLES


#### Unity 2010

# Data found here: https://en.wikipedia.org/wiki/List_of_Unity_games

data_url_Unity <- "https://en.wikipedia.org/wiki/List_of_Unity_games"

#//*[@id="mw-content-text"]/div/table[4]

data_raw_Unity2010 <- data_url_Unity %>%
  html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[4]' ) %>%
  html_table()


# According to a typeof() call on data_raw_Unity2010, data_raw_Unity2010 is a list.
# That is why this person is pulling it out of a couple of other lists that must have been passed with it 
#   through the scraping process. **
data_raw_Unity2010 <- data_raw_Unity2010[[1]]

# this is also a list still. (So I did not bother making a new object to distinguish it.)
head(data_raw_Unity2010)

# STEP 2. RAW DATA, BUT AS A TIBBLE

# this is now a tibble.
# This is our RAW DATA. For just the 2010 year.
data_tibble_Unity2010 <- as_tibble(data_raw_Unity2010)
#View(data_tibble_Unity2010)



### Unity 2011

data_raw_Unity2011 <- data_url_Unity %>%
  html() %>% # throws a warning message: "use read_html()" instead. BUT, this seems to work so whatever.
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[5]') %>%
  html_table()

data_raw_Unity2011 <- data_raw_Unity2011[[1]]
data_tibble_Unity2011 <- as_tibble(data_raw_Unity2011)



### Unity 2012

data_raw_Unity2012 <- data_url_Unity %>%
  html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[6]') %>%
  html_table()

data_raw_Unity2012 <- data_raw_Unity2012[[1]]
data_tibble_Unity2012 <- as_tibble(data_raw_Unity2012)


### Unity 2013

data_raw_Unity2013 <- data_url_Unity %>%
  html() %>% 
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[7]') %>%
  html_table()

data_raw_Unity2013 <- data_raw_Unity2013[[1]]
data_tibble_Unity2013 <- as_tibble(data_raw_Unity2013)

# About 74 data points total from Unity.


######## UNREAL TABLES

data_url_Unreal <- "https://en.wikipedia.org/wiki/List_of_Unreal_Engine_games"


data_raw_Unreal1 <- data_url_Unreal %>%
  html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[1]') %>%
  html_table()

data_raw_Unreal1 <- data_raw_Unreal1[[1]]
data_tibble_Unreal1 <- as_tibble(data_raw_Unreal1)


data_raw_Unreal2 <- data_url_Unreal %>%
  html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[2]') %>%
  html_table()

data_raw_Unreal2 <- data_raw_Unreal2[[1]]
data_tibble_Unreal2 <- as_tibble(data_raw_Unreal2)



data_raw_Unreal3 <- data_url_Unreal %>%
  html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[3]') %>%
  html_table()

data_raw_Unreal3 <- data_raw_Unreal3[[1]]
data_tibble_Unreal3 <- as_tibble(data_raw_Unreal3)



data_raw_Unreal4 <- data_url_Unreal %>%
  html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[4]') %>%
  html_table()

data_raw_Unreal4 <- data_raw_Unreal4[[1]]
data_tibble_Unreal4 <- as_tibble(data_raw_Unreal4)


######## CRYENGINE TABLES


data_url_CryEngine <- "https://en.wikipedia.org/wiki/List_of_CryEngine_games"

data_raw_CryEngine1 <- data_url_CryEngine %>%
  html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[1]') %>%
  html_table()

data_raw_CryEngine1 <- data_raw_CryEngine1[[1]]
data_tibble_CryEngine1 <- as_tibble(data_raw_CryEngine1)



data_raw_CryEngine2 <- data_url_CryEngine %>%
  html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[2]') %>%
  html_table()

data_raw_CryEngine2 <- data_raw_CryEngine2[[1]]
data_tibble_CryEngine2 <- as_tibble(data_raw_CryEngine2)




data_raw_CryEngine3 <- data_url_CryEngine %>%
  html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[3]') %>%
  html_table()


data_raw_CryEngine3 <- data_raw_CryEngine3[[1]]
data_tibble_CryEngine3 <- as_tibble(data_raw_CryEngine3)


# CryEngine 4 only contains games made after 2014 (at least, that is what the Wikipedia tables have).




######## ORIGINAL DATASET: IGN REVIEWS

# Tried the following and did not work: `read_xlsx()` and `read_excel()`. From the `readxl` package.
#data_raw_IGN <- read_xlsx(path = 'data/unprocessed/gamedata_reddit_datasci_Table1.csv')
#data_raw_IGN <- read_excel(path = 'gamedata_reddit_datasci_Table1.xlsx')


data_tibble_IGN <- read_csv(file = 'data/unprocessed/gamedata_reddit_datasci_Table1.csv')

#data_tibble_IGN <- as_tibble(data_raw_IGN) # Not sure how I missed before that read_csv has tibble as the output.



######## SECONDARY LARGE DATASET: GAME SALES

data_tibble_gamesales <- read_csv("data/unprocessed/Video_Games_Sales_as_at_22_Dec_2016.csv")
# When cleaning: Will need to 1) check for unique rows as always, 2) check for unique titles (?), 3) cast to factors



########### END OF SCRIPT. All data needed is contained in here.


# List of data produced and available from this script:

### _Scraped Wikipedia data_
#data_tibble_Unity2010
#data_tibble_Unity2011
#data_tibble_Unity2012
#data_tibble_Unity2013
#data_tibble_Unreal1
#data_tibble_Unreal2
#data_tibble_Unreal3
#data_tibble_Unreal4
#data_tibble_CryEngine1
#data_tibble_CryEngine2
#data_tibble_CryEngine3

### _The IGN dataset (17k)_
#data_tibble_IGN

### _Game Sales and Critic data (16k)_
#data_tibble_gamesales








