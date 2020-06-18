# package
rm(list=ls())
load.libraries <- c('dplyr','ggplot2','readr','lubridate','plotly')
install.lib <- load.libraries[!load.libraries %in% installed.packages()]
for(libs in install.lib) install.packages(libs, dependences = TRUE)
sapply(load.libraries, require, character = TRUE)

# C123
# read file
library(stringr)

all_csv_c <- paste("ML_Course/Examples/Data/C123/",
                   list.files("ML_Course/Examples/Data/C123/",pattern = ".csv"),sep="")

name_c = gsub("[[:punct:]]","",str_extract(list.files("ML_Course/Examples/Data/C123/",pattern = "()"), "\\(.*?\\)"))

all_list_c <- lapply(all_csv_c,read_csv)

# bind table
all_df_c <- do.call("rbind",all_list_c)
head(all_df_c)

# change colname and type
names(all_df_c)[1] <- "Date"
names(all_df_c)[3] <- "Counts"

all_df_c %>% mutate(Date = as.Date(paste(substr(all_df_c$Date,1,4),substr(all_df_c$Date,5,6),"01",sep = "-" )) ,
                    Counts = as.numeric(Counts) ) %>% group_by(Date,Model) %>% 
  summarise(Counts=sum(Counts)) -> all_df_c

head(all_df_c)

# K456

all_csv_c2 <- paste("ML_Course/Examples/Data/K456/",
                   list.files("ML_Course/Examples/Data/K456/",pattern = ".csv"),sep="")

name_c2 = gsub("[[:punct:]]","",str_extract(list.files("ML_Course/Examples/Data/K456/",pattern = "()"), "\\(.*?\\)"))

all_list_c2 <- lapply(all_csv_c2,read_csv)

# bind table
all_df_c2 <- do.call("rbind",all_list_c2)

# change colname and type
name.vector2 = rep(name_c2,each=unique(sapply(all_list_c2, NROW)))

all_df_c2 <- cbind(all_df_c2 , Region=name.vector2)
names(all_df_c2)[1] <- "Date"
names(all_df_c2)[3] <- "Counts"

all_df_c2 %>% mutate(Date = as.Date(paste(substr(Date,1,4),substr(Date,5,6),"01",sep = "-" )) ,
                    Counts = as.numeric(Counts) ) %>% group_by(Date,Model) %>% 
  summarise(Counts=sum(Counts))-> all_df_c2

head(all_df_c2)

# bind two big table
df <- rbind(all_df_c,all_df_c2)
head(df)

# ggplot
ggplot(df, aes(x = Date, y = Counts, fill = Model, group = Model)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_line(aes(color = Model),size = 0.8) +
  geom_text(aes(label = Counts, y = Counts),
            nudge_x = c(0.22,-0.22)) +
  geom_point(colour='black') +
  scale_x_date(date_breaks = "1 month", date_labels = "%Y-%m") +
  scale_y_continuous(breaks = seq(0, 400, 50)) +
  scale_color_brewer(type='qua', palette=2) +
  labs(
    x = "Date.Time",
    y = "Counts" ,
    colour = "Model",
    title = "C123 & K456 Cases Bar-Chart",
    subtitle = "Period from 2018.01 to 2019.08",
    caption = "source: xxxx ; Author: PeterWang"
  ) +
  theme(
    axis.text.x = element_text(size = 10, vjust = 0.4 , angle = 45),
    axis.text.y = element_text(size = 12, vjust = 1.2) ,
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    plot.caption = element_text(size = 10),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold")
  )




















