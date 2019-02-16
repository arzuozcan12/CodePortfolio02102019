#Created by Arzu Ozcan

##Purpose - To compile all R codes learnt in ANLY506

### -----------------------------------------
### CHAPTER 5 - DATA TRANSFORMATION - Week 7
### -----------------------------------------

View(flights) # Open the dataset in the RStudio viewer

                # int stands for integers
                # dbl stands for doubles, or real numbers.
                # chr stands for character vectors, or strings.
                # dttm stands for date-times (a date + a time).
                # lgl stands for logical, vectors that contain only TRUE or FALSE.
                # fctr stands for factors, which R uses to represent categorical variables with fixed possible values.
                # date stands for dates

# Dplyr Basics
filter()        # Picks observations by their values
arrange()       # Reorders the rows
select()        # Picks variables by their names
mutate()        # Creates new variables with functions of existing variables
summarise()     # Collapses many values down to a single summary
group_by()      # Changes the scope of each function from operating on the entire dataset to operating on it group-by-group

filter()        # Subsets observations based on their values. The first argument is the name of the data frame. The second and subsequent arguments are the expressions that filter the data frame. For example, we can select all flights on January 1st with:
filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1) # Saves the result
## dec25 <- filter(flights, month == 12, day == 25

filter(flights, month == 1)                       # Use == when testing for equalit!!! 
filter(flights, month == 11 | month == 12)        # Finds all flights that departed in November or December
nov_dec <- filter(flights, month %in% c(11, 12))  # selects every row where x is one of the values in y

# to find flights that weren't delayed (on arrival or departure) by more than two hours, you could use either of the following two filters:
# filter(flights, !(arr_delay > 120 | dep_delay > 120))
# filter(flights, arr_delay <= 120, dep_delay <= 120)

is.na(x)          # Determines if a value is missing

arrange()         # Orders a data frame and a set of column names
desc()            # Orders by a column in descending order

df <- tibble(x = c(5, 2, NA))       # Sorts missing values at the end

select(flights, year, month, day)   # Selects columns by name
select(flights, year:day)           # Selects all columns between year and day (inclusive)
select(flights, -(year:day))        # Selects all columns except those from year to day (inclusive)

mutate()          # Add new columns that are functions of existing columns
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
mutate(flights_sml,gain = dep_delay - arr_delay,speed = distance / air_time * 60)

mutate(flights_sml,gain = dep_delay - arr_delay,hours = air_time / 60,gain_per_hour = gain / hours)

cumsum()          # Cummulative sum
cumprod()         # Cummulative products
cummin()          # Cummulative mins
cummax()          # Cummulative maxes
cummean()         # Cummulative means

min_rank()        # Gives smallest values the small ranks
desc(x)           # Gives the largest values the smallest ranks

summarise()       # Prints a data frame to a single row

# Measures of location
mean(x)
median(x)

# Measures of spread
sd(x)             # Standard deviation - standard measure of spread
IQR(x)            # Interquartile range

# Measures of rank
min(x)
quantile(x, 0.25) # Finds a value of x that is greater than 25% of the values, and less than the remaining 75%
max(x) 

# Measures of position
first(x)          # Finds the first departure
nth(x, 2)
last(x)           # Finds the last departure

# Counts
n()               # Finds the size of the current group
sum(!is.na(x))    # Finds the number of non-missing values
n_distinct(x)     # Finds the number of distinct (unique) values

library(dplyr)

# Counts and proportions of logical values
sum(x > 10)
mean(y == 0)      # When used with numeric functions, TRUE is converted to 1 and FALSE to 0. This makes sum() and mean() very useful: sum(x) gives the number of TRUEs in x, and mean(x) gives the proportion

# Grouping
summarise()
mutate()
filter()


