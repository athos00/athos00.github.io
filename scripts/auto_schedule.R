library(tidyverse)
library(knitr)

# set these:
firstDay = as.Date("2025-01-08")
firstDayID = "Wed"
lastDay = as.Date("2025-04-23")
lectureDays = c("Wed", "Fri")
labDays = c("Thu")
holidays = as.Date(c("2025-01-20", "2025-03-12", "2025-03-13", "2025-03-14"))

### render table
allDates = seq(from = firstDay, to = lastDay, by = 'day')
schedule = data.frame(allDates,
                      dayOfWeek = weekdays(allDates, abbreviate=T)) %>%
  filter(dayOfWeek %in% c(lectureDays, labDays))
schedule = schedule %>%
  mutate(lab = ifelse(dayOfWeek %in% labDays, TRUE, FALSE)) %>%
  mutate(Topic = ifelse(allDates %in% holidays, "NO CLASS", "")) %>%
  mutate(Date = format(allDates, format = "%b %d")) %>%
  mutate(Date = paste(dayOfWeek, Date)) %>%
  mutate(Week = rep("", nrow(schedule))) %>%
  mutate(Reading = rep("", nrow(schedule))) %>%
  mutate(Notes = rep("", nrow(schedule))) %>%
  mutate(Assignment = rep("", nrow(schedule))) %>%
  mutate(Exam = rep("", nrow(schedule))) %>%
  mutate(Project = rep("", nrow(schedule))) %>%
  select(Week, Date, Topic, Reading, Notes, Assignment)
# to be pasted into qmd:
schedule %>%
  kable(format = "markdown")