library(readr)
# read 50 files one time
files <- list.files('tf_table/' , pattern = '.csv' )
# 50 files to one list
tables <- lapply(paste("tf_table",files,sep="/"),read_csv)
# rename table names of the list
newname <- gsub('.csv', '', files)
newname <- paste0('stock',newname)
names(tables) <- newname

# connect to mariadb, use database "treering"
library(RMariaDB)
library(DBI)
drv <- dbDriver("MariaDB")
con <- dbConnect(drv, username="root", password="", dbname ="stock", host="localhost")

# import tables to database
mapply(dbWriteTable, name = newname, value = tables , MoreArgs = list(conn = con))

dbDisconnect(con)
