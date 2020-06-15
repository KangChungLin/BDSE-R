library(RMariaDB)
library(DBI)

drv <- dbDriver("MariaDB")
con <- dbConnect(drv, username="root", password="", dbname ="treering", host="localhost")
dbListTables(con)

res <- dbSendQuery(con, "SELECT * FROM cil05 WHERE year = 1900")
dbFetch(res)
dbClearResult(res)

dbWriteTable(con, "mtcars", mtcars)
dbWriteTable(con, "cil02a", CIL02A_r)

res <- dbSendQuery(con, "SELECT * FROM cil02a WHERE year < 1940")
dbFetch(res)
dbClearResult(res)  # 須清除結果才能進行下一步

dbDisconnect(con)

rm(list=ls())
gc()
