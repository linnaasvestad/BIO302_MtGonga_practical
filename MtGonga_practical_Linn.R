library(tidyverse)
library(readxl)

#### Importing data #### 
file.choose("biomass2015 (2).xls") # to find the path to the file 
excel_sheets() #creats a list of all the available sheets in the file

biomass.df <- excel_sheets("/Users/linnaasvestad/Desktop/UiB V2021/RStudio /BIO302_MtGonga/biomass2015 (2).xls") %>% 
  map_df(~read_xls("/Users/linnaasvestad/Desktop/UiB V2021/RStudio /BIO302_MtGonga/biomass2015 (2).xls", .)) # the dot takes all the available sheets we found using the excel_sheet function into the parameter 
biomass.df  

view(biomass.df)

### If you only use map, instead of map_df, you get all of the sheets separate as lists. 
dt <- excel_sheets("/Users/linnaasvestad/Desktop/UiB V2021/RStudio /BIO302_MtGonga/biomass2015 (2).xls") %>% 
  map(~read_xls("/Users/linnaasvestad/Desktop/UiB V2021/RStudio /BIO302_MtGonga/biomass2015 (2).xls", .)) 
dt

## to get access to each of the separate sheets: 
SiteL <- dt[1]
SiteM <- dt[2]
Site_A <- dt[3]
Site_H <- dt[4]

#### cleaning the dataframe #### 
biomass <- biomass.df %>% 
  select(production, site, plot) %>% #keeping relevant columns 
  drop_na() %>% 
  group_by(site, plot) %>% #we want to look at tot biomass in each site/plot 
  summarise(tot_biomass = sum(production)) #making a new column with total biomass  this function will create a row for each combinations of groupings 

view(biomass)

#### plotting the data #### 

biomass_plot <- ggplot() + 
  geom_boxplot(data = biomass, 
               aes(x = plot, y = tot_biomass))
biomass_plot
