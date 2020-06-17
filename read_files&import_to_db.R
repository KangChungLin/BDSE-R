library(readr)
# read 50 files one time
files = list.files('after_r4/' , pattern = '.csv' )
# 50 files to one list
tables = lapply(paste("after_r4",files,sep="/"),read_csv)
# rename table names of the list
newname = gsub('_r.csv', '', files)
names(tables) = newname

# connect to mariadb, use database "treering"
library(RMariaDB)
library(DBI)
drv <- dbDriver("MariaDB")
con <- dbConnect(drv, username="root", password="", dbname ="treering", host="localhost")

# import tables to database
mapply(dbWriteTable, name = newname, value = tables , MoreArgs = list(conn = con))

dbDisconnect(con)
