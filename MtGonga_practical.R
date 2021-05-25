library(tidyverse)
library(usethis)
library(devtools)
library(readxl)
library(fs)


#### Importing data #### 
excel_sheets(path = file)

biomass.df <- excel_sheets(path = "biomass2015 (2).xls") %>% #find the name of excel sheet 
  map_df(~read_excel(path = "biomass2015 (2).xls", sheet = .x))
view(biomass.df)

#### analysing and plotting #### 

biomass_tot <- biomass.df %>% 
  select(production, site, plot) %>% #Keeping relevant columns  
  dplyr::mutate(site = factor(site, levels = c("L", "M", "A", "H"))) %>% 
  group_by(site, plot) %>% #bc we want to summarise the tot biomass per site/plot
  summarise(biomass_tot = sum(production, na.rm = T)) #calculating total biomass

view(biomass_tot)

#plot 
biomass_plot <- ggplot() + 
  geom_boxplot(data = biomass_tot, 
               aes(x = plot, y = biomass_tot))

biomass_plot

