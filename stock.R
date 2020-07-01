TWII <- read_csv("C:/Users/Student/Downloads/TWII.csv", 
                 col_types = cols(Date = col_date(format = "%Y-%m-%d"), Close = col_double()))
plot(TWII$Date,TWII$Close,type = 'l')
ggplot(data = TWII, aes(x=Date,y=Close)) + geom_line()
