data("flights")

#----------SELECT-----------
select(flights, starts_with("TIME")) # starts with time(!case sensitive) in column names
select(flights, contains("TIME"))    # contains time(!case sensitive) anywhere in the column names
select(flights, ends_with("TIME"))   # ends with time(!case sensitive) in column names
select(flights, matches("(.*)ig(.*)")) #regex matching : a columnname should contain "ig" doesn't matter what it starts or ends

#----------MUTATE-----------
flights_sml <- flights %>%
  select(year:day,ends_with("delay"),distance,air_time) %>%
  mutate(gain  = arr_delay-dep_delay,
         speed = distance/air_time,
         hours = air_time/60,
         gain_per_hour = gain/hours)    # mutate() always adds new columns at the end of your dataset
                                        # moreover we can create new columns while using newly created columns inside mutate()


transmute(flights,
          gain  = arr_delay-dep_delay,
          speed = distance/air_time,
          hours = air_time/60,
          gain_per_hour = gain/hours)    # If you only want to keep the new variables, use transmute()

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,  # this will return the result after division in round figure
          minute = dep_time %% 100)  # this will return the modulus

#----------GROUP_BY-----------
by_day <- group_by(flights, year, month, day) 
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))




                         