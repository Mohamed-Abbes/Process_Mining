setwd(" ") #Enter your Working Directory
data <- read.csv('', sep=",") #Enter File Name

#convert timestamp to date and time
data$Time <- as.POSIXct(data$Time, origin = "2023-01-05 00:00:00", tz="GMT")


#instantiate an object of class eventlog by specifying dataframe data in this case
eventlog <- bupaR::simple_eventlog(eventlog = data, 
                                   case_id = 'CaseID', 
                                   activity_id = 'Activity', 
                                   timestamp = 'Time',
                                   resource_id = 'Resource')

#write.csv(data, "C:", row.names=FALSE)


#using pipe operator to forward dataframe into sumamry function
eventlog %>%
  summary

#Process Map
process_map(eventlog, type = frequency("absolute"))
process_map(eventlog, type = performance(median))

#Ressource Map
resource_map(eventlog, type = frequency("absolute"))
resource_map(eventlog, type = performance(median,'secs'))

#Returns diffrent sequences, coverage argument specificies how much of the log you want to explore.
trace_explorer(eventlog,coverage = 1)

animate_process(eventlog)

animate_process(eventlog,
                mapping = token_aes(shape = "image",
                                    size = token_scale(10),
                                    image = token_scale("https://upload.wikimedia.org/wikipedia/commons/5/5f/Pacman.gif")))
#Order process by frequency
eventlog %>% activity_frequency(level = "activity") %>% plot()

eventlog%>%
  trace_explorer(coverage = 0.8)
performance_dashboard(eventlog)
activity_dashboard(eventlog)      