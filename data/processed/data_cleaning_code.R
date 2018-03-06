
# Author: Sarah McDougald
# Version: 2-28-18
# Purpose: data cleaning





# Outline

# 1. Cleaning Unity tables
# 2. Cleaning Unreal Engine tables
# 3. Cleaning CryEngine tables
# 4. Cleaning IGN data table
# 5. Joining Wikipedia tables (into one)
# 6. Cleaning combined Wikipedia data table
# 7. Cleaning Sales/Critic table
# 8. Joining Sales/Critic table to IGN tale
# 9. Cleaning IGN_Sales/Critic table
# 10. FINAL REVIEW


# Libraries


library(tidyverse)
source("data/unprocessed/data_scraping_code.R")
select <- dplyr::select

# Found the "source()" function here: https://stackoverflow.com/questions/35907991/how-to-call-a-r-program-from-another-r-program



# List of data produced and available from this script, "data_scraping_code.R":

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
#data_tibble_IGN


########## CLEAN

# Steps:

## 1. Add Engine and Engine Version to each table.
## 2. Add "Year" column, with the year, to each table.
## 3. for the excel data: change the col name "Game" to "Title"
## 4. At the end of this document: attach all the non-IGN data tables to each other. ***

## Note: arranging in order: (Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)


### UNITY


# NOTES...
# with the Unity datasets, we are ignoring the specific date of release and focusing on the year.
#    * This is done because this specific release-date data is both not useful, and the other datasets do NOT 
#    have it. * Therefore, this variable, Release-Date, was removed.
# added Engine and EngineVersion.
# added Year column so the column names of all the non-IGN data will fit.

# used select() to switch around the order of the column names. It worked pretty well.



cleaned_Unity2010 <- data_tibble_Unity2010 %>%
  mutate(
    Engine = "Unity",
    EngineVersion = "Unity2010",
    Year = 2010
  ) %>% 
  dplyr::select(-`Release date`) %>%
  dplyr::select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)

cleaned_Unity2011 <- data_tibble_Unity2011 %>%
  mutate(
    Engine = "Unity",
    EngineVersion = "Unity2011",
    Year = 2011
  ) %>% 
  select(-`Release date`) %>%
  select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)

cleaned_Unity2012 <- data_tibble_Unity2012 %>%
  mutate(
    Engine = "Unity",
    EngineVersion = "Unity2012",
    Year = 2012
  ) %>% 
  select(-`Release date`) %>%
  select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)

cleaned_Unity2013 <- data_tibble_Unity2013 %>%
  mutate(
    Engine = "Unity",
    EngineVersion = "Unity2013",
    Year = 2013
  ) %>% 
  select(-`Release date`) %>%
  select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)


### UNREAL

# NOTES...
# added Engine and EngineVersion
# switched order of column names using select().

cleaned_Unreal1 <- data_tibble_Unreal1 %>%
  mutate(
    Engine = "Unreal Engine",
    EngineVersion = "Unreal Engine 1" 
  ) %>%
  select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)

cleaned_Unreal2 <- data_tibble_Unreal2 %>%
  mutate(
    Engine = "Unreal Engine",
    EngineVersion = "Unreal Engine 2"
  ) %>%
  select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)

cleaned_Unreal3 <- data_tibble_Unreal3 %>%
  mutate(
    Engine = "Unreal Engine",
    EngineVersion = "Unreal Engine 3"
  ) %>%
  select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)

cleaned_Unreal4 <- data_tibble_Unreal4 %>%
  mutate(
    Engine = "Unreal Engine",
    EngineVersion = "Unreal Engine 4"
  ) %>%
  select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)


### CRYENGINE

# NOTES...
# added Engine and EngineVersion
# added an "empty" variable Genre, filled with NAs; going to join all non-IGN datasets together, and
#   the CryEngine tables were missing this variable.
# renamed the variables Developer(s), Publisher(s) and Platform(s) so they match up with the variable names of
#   the other non-IGN datasets.

cleaned_CryEngine1 <- data_tibble_CryEngine1 %>%
  mutate(
    Engine = "CryEngine",
    EngineVersion = "CryEngine 1",
    Genre = NA,
    
    Developer = `Developer(s)`,
    Publisher = `Publisher(s)`, 
    Platform = `Platform(s)`
  ) %>% 
  select(-`Developer(s)`,-`Publisher(s)`,-`Platform(s)`,
         Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)
#rename(cleaned_CryEngine1, 
#       Developer = `Developer(s)`,
#       Publisher = `Publisher(s)`, 
#       Platform = `Platform(s)`
#)


#cleaned_CryEngine1 <- cleaned_CryEngine1 %>%
#  select(Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)


###

cleaned_CryEngine2 <- data_tibble_CryEngine2 %>%
  mutate(
    Engine = "CryEngine",
    EngineVersion = "CryEngine 2",
    Genre = NA,
    
    Developer = `Developer(s)`,
    Publisher = `Publisher(s)`, 
    Platform = `Platform(s)`
  ) %>% 
  select(-`Developer(s)`,-`Publisher(s)`,-`Platform(s)`,
         Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)


###

cleaned_CryEngine3 <- data_tibble_CryEngine3 %>%
  mutate(
    Engine = "CryEngine",
    EngineVersion = "CryEngine 3",
    Genre = NA,
    
    Developer = `Developer(s)`,
    Publisher = `Publisher(s)`, 
    Platform = `Platform(s)`
  ) %>% 
  select(-`Developer(s)`,-`Publisher(s)`,-`Platform(s)`,
         Title, Engine, EngineVersion, Genre, Year, Platform, Developer, Publisher)


### IGN DATA

# Note that we are changing the name of the column in the IGN dataset, 'Game', to 'Title', to match the
#    other data tables.

# There is a useful function, `rename()`, in the package `dplyr` that allows the renaming of columns of a tibble.
# Found the function recommended here: http://www.sthda.com/english/wiki/renaming-data-frame-columns-in-r


# UNCOMMENT this line when running data analysis! This is commented because an error is thrown after running
# it the first time successfully. ****
cleaned_IGN <- rename(data_tibble_IGN, Title = Game)

ign <- cleaned_IGN %>%
  na.omit() %>%
  distinct()


# Finally, since we'll be adding Metacritic scores (02/28/18 update), change the variable name of "Score".

ign <- ign %>%
  mutate(
    IGN_Score = Score#,
    #IGN_Score_Quarter = Score_Quarter
  ) %>%
  select(-Score)

# # # # # # NOTE: This could definitely use some more cleaning. Duplicate titles because of `Platform` variable



####### JOINING TOGETHER ALL WIKIPEDIA DATA TABLES

# Function used to append-- i.e. attach-- tibbles to each other: `rbind()`!
# THANK YOU: function found here. Credits: https://www.princeton.edu/~otorres/Merge101R.pdf
cleaned_wiki_games_all <- rbind(cleaned_Unity2010,
                            cleaned_Unity2011,
                            cleaned_Unity2012,
                            cleaned_Unity2013,
                            cleaned_Unreal1,
                            cleaned_Unreal2,
                            cleaned_Unreal3,
                            cleaned_Unreal4,
                            cleaned_CryEngine1, 
                            cleaned_CryEngine2,
                            cleaned_CryEngine3)
  

########## PREPARING THE DATA - WIKIPEDIA


# The following was moved to the beginning of the EDA Rmd file for better clarity.


# Now, filter out the observations that are AFTER 2014 or BEFORE 2010.
# NOTE: We do this because:
#   - The IGN dataset only goes through 2014, because that's when it was created. (See timestamp on its original
#     post.)
#   - also keep in mind: Unity data is only available for 2010 and later. **** 
#cleaned_Wiki_Games <- cleaned_Wiki_Games %>%
#  filter((Year <= 2014))
# Length of this tibble: 408

# Note that if we filter out pre-2010 games, we still end up with 265 rows. Sizeable.



wiki_games <- cleaned_wiki_games_all %>%
  filter(Year <= 2014)

wiki_games_limited <- wiki_games %>%
  filter(Year >= 2010)

games_dirty <- inner_join(cleaned_IGN, wiki_games_limited, by = "Title")
# Length of this tibble: 247 rows. 

# (See Long-form EDA from Data Sci I final project for explanation. Will need to toss that in this project somewhere.) 

# For prediction, make string variables into factors.
# Use Platform.y because it contains more information and allows to CLEAN OUT duplicated titles.
# Use Genre.x because it contains more standardized factors and does not have missing data.
games_dirty <- games_dirty %>%
  mutate(
    # Leave Title as a string.
    Platform = as.factor(Platform.y),
    Genre = as.factor(Genre.x),
    Engine = as.factor(Engine),
    EngineVersion = as.factor(EngineVersion),
    Year = as.integer(Year),
    Developer = as.factor(Developer),
    Publisher = as.factor(Publisher)
    # NOTE: May not use developer/publisher because too many levels.
    
  )

# Finally, remove the "superfluous" Genre.y and Platform.y variables-- would be hard to mesh and contain additional data.
# Will add discussion of this in an Rmd.
games_dirty <- games_dirty %>%
  select(-Genre.y, - Platform.y, -Genre.x, -Platform.x)

### Clean it by removing duplicate titles.
games_dirty <- games_dirty %>%
  distinct()

### Let's check each potential predictor.

# Title is a string. These should be unique. Not a predictor, but a "key" of sorts.

# Score is a double. That's our output, Y, so not a predictor.

# Engine - 3 factors
# levels(games_dirty$Engine)

# EngineVersion - 8 factors
# levels(games_dirty$EngineVersion)

# Year - 5 "factors" in integer form currently. 2010- 2014.
# range(games_dirty$Year)

# Developer - over 100 factors. Not suitable for prediction.
# levels(games_dirty$Developer)

# Publisher - 75 factors. Not really suitable for prediction.
# levels(games_dirty$Publisher)

# # # NOTE: It makes sense that we shouldn't be predicting with `Developer` and `Publisher`. 

# Platform - 52 levels. _Not sure how to clean this._ Could look up more.
# levels(games_dirty$Platform)

# Genre - 22 factors. 

#     But can we shrink this? I.e. add a "Misc" category.
#     First, find out how many factors.
# levels(games_dirty$Genre)

#     Now count the number in each factor.
genre_factors_tibble <- games_dirty %>% 
  group_by(Genre) %>%
  summarise(total = length(Genre)) %>%
  arrange(desc(total))

#     NOW: Will have to _go back and double-check this step._ May want to add more factors later. But for now, add
#       only factors with only 1 game in them to "Misc".
#     How to recode factors: http://r4ds.had.co.nz/factors.html#modifying-factor-levels fct_recode()

games_dirty <- games_dirty %>%
  mutate(Genre = fct_recode(Genre,
                            "Misc" = "Action, Simulation",
                            "Misc" = "Adventure, Adventure", 
                            "Misc" = "Fighting, Action", 
                            "Misc" = "Flight, Action", 
                            "Misc" = "Music", 
                            "Misc" = "None",
                            "Misc" = "Puzzle, Adventure",
                            "Misc" = "Wrestling"
                            ))


#     Re-count the levels to double check.
genre_factors_tibble <- games_dirty %>% 
  group_by(Genre) %>%
  summarise(total = length(Genre)) %>%
  arrange(desc(total))


#     Could optionally simplify this even more.
#     NEW MISC: if a genre has < 10, throw it in Misc.
games_dirty_simplified <- games_dirty %>%
  mutate(SimplifiedGenre = fct_recode(Genre,
                            "Misc" = "Sports", 
                            "Misc" = "Shooter, RPG", 
                            "Misc" = "Simulation", 
                            "Misc" = "Puzzle, Action", 
                            "Misc" = "Fighting", 
                            "Misc" = "Action, RPG", 
                            "Misc" = "Platformer", 
                            "Misc" = "Puzzle", 
                            "Misc" = "Strategy", 
                            "Misc" = "Misc", 
                            "Misc" =  "Action, Adventure",
                            "Misc" =  "Adventure"
                            ))

##### Make a classifying variable of quantiles of IGN score.

#score_quartiles <- factor("")

games_dirty_simplified_2 <- games_dirty_simplified %>%
  mutate(Score_Quarter = as.factor(
                                  if_else(Score >= 5.0, 
                                  if_else((Score >= 7.5), "Top Quarter", "Second Quarter"),
                                  if_else((Score >= 2.5), "Third Quarter", "Bottom Quarter"))))





# NEXT: Take out factors with only one row!!!!
# Q: How to know how many items are in each factor? ***







ign_wiki <- games_dirty_simplified_2

ign_wiki <- ign_wiki %>%
  na.omit() %>%
  mutate(
    IGN_Score = Score,
    IGN_Score_Quarter = Score_Quarter
  ) %>%
  select(-Score, -Score_Quarter)



########## CLEANING SALES/CRITIC TABLE


# 1. Change to factors.
# 2. Check if unique. (Note: no double-ups, i.e. commas, in variables; so won't have the multiple-game entry 
#    problem in the IGN dataset.)

sales_critic_table <- data_tibble_gamesales %>%
  mutate(
    Title = Name,
    Platform = as.factor(Platform),
    Year_of_Release = as.integer(Year_of_Release),
    Genre = as.factor(Genre),
    Publisher = as.factor(Publisher),
    User_Score = 10 * as.double(User_Score), # note that this is down by a factor of 10. So multiplying.
    Rating = as.factor(Rating), # this is ESRB rating. 
    Developer = as.factor(Developer)
  ) %>%
  distinct() %>%
  select(-Name)





########## APPENDING SALES/CRITIC TABLE TO IGN TABLE

# Use a join function to combine.

keys <- c("Title", "Platform")

# Join 1.
ign_salescritic_games <- inner_join(ign, sales_critic_table, by = "Title")
# Creates a tibble of 19,941. Needs to be cleaned: get rid of Platform.y and call it distinct.
# USE THIS JOIN.

# Join 2.
ign_salescritic_games2 <- inner_join(ign, sales_critic_table, by = keys)
# This creates a tibble of 1027 games. GETS RID of a lot of data. Just ignore the "Platform" variable from `ign`.


########## CLEANING IGN_SALES/CRITIC TABLE 

# Note: Using the `Platform` variable from the Sales/Critic data, because it's more succint.

ign_salescritic_games <- ign_salescritic_games %>%
  select(-Platform.x, -Genre.x) %>%
  mutate(
    Platform = Platform.y,
    Genre = Genre.y
  ) %>%
  select(-Platform.y, -Genre.y) %>%
  distinct() %>%
  na.omit() %>%
  mutate(
    IGN_Score_Quarter = as.factor(
        if_else(IGN_Score >= 5.0, 
              if_else((IGN_Score >= 7.5), "Top Quarter", "Second Quarter"),
              if_else((IGN_Score >= 2.5), "Third Quarter", "Bottom Quarter")))
  )
# Tibble of 14,067 !!!!!!! :)


# NOTE!!!!
#     There are multiple titles anyway, because there are 
#     _different Metacritic scores and sales depending on Platform._


# Okay, if this reflects the data and actual trends then it is fine to keep duplicate titles. BUT, I need to mention
#   this in my analysis.


ign_sc <- ign_salescritic_games

########## FINAL REVIEW OF DATA

# games_dirty

# Output variable: `Score`
# Suitable input predictors, CURRENTLY: `Engine`, `EngineVersion`, `Year`, `SimplifiedGenre`, `Genre`.



# Processed, ready-to-model datasets available:

#ign - raw IGN data table, as is. (For reference.)
#ign_wiki - the 140=9-something row of "cleaned"-as-possible data mixing IGN scores and Wikipedia data.
#ign_sc - the 14,000 approximate data table of Metacritic data, IGN score, sales, etc. 
#     [Don't use Metacritic to predict! Breaks the assumption of independence.]
#_____ - [should have a joining of all 3 sources of data, but oh well. Try additionally if time..]






