#Created by Arzu Ozcan

##Purpose - To compile all R codes learnt in ANLY506

### --------------------------------------------------------------------------
### CHAPTER 8 - MATRICES AND DATAFRAMES - Week6
### --------------------------------------------------------------------------

# Create a dataframe of boat sale data called bsale
bsale <- data.frame(name = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j"),
                    color = c("black", "green", "pink", "blue", "blue", 
                              "green", "green", "yellow", "black", "black"),
                    age = c(143, 53, 356, 23, 647, 24, 532, 43, 66, 86),
                    price = c(53, 87, 54, 66, 264, 32, 532, 58, 99, 132),
                    cost = c(52, 80, 20, 100, 189, 12, 520, 68, 80, 100),
                    stringsAsFactors = FALSE)   # Don't convert strings to factors!

# Explore the bsale dataset:
head(bsale)           # Shows the first few rows
str(bsale)            # Shows the structure of the data
View(bsale)           # Opens the data in a new window
names(bsale)          # Prints the names of the columns
nrow(bsale)           # Prints the number of rows in the data

# Calculating statistics from column vectors
mean(bsale$age)       # Calculates the mean age
table(bsale$color)    # Prints the number of boats for each color
max(bsale$price)      # Calculates the maximum price

# Adding new columns
bsale$id <- 1:nrow(bsale)
bsale$age.decades <- bsale$age / 10
bsale$profit <- bsale$price - bsale$cost

# Calculate the mean price of green boats
with(bsale, mean(price[color == "green"]))

# Find the names of boats older than 100 years?
with(bsale, name[age > 100])

# Find the percent of black boats had a positive profit
with(subset(bsale, color == "black"), mean(profit > 0))

# Save only the price and cost columns in a new dataframe
bsale.2 <- bsale[c("price", "cost")]

# Change the names of the columns to "p" and "c"
names(bsale.2) <- c("p", "c")

# Create a dataframe called old.black.bsale containing only data from black boats older than 50 years
old.black.bsale <- subset(bsale, color == "black" & age > 50)

# Create a matrix where x, y and z are columns
x <- 1:5
y <- 6:10
z <- 11:15
cbind(x, y, z)
##      x  y  z
## [1,] 1  6 11
## [2,] 2  7 12
## [3,] 3  8 13
## [4,] 4  9 14
## [5,] 5 10 15

# Create a matrix where x, y and z are rows
rbind(x, y, z)
##   [,1] [,2] [,3] [,4] [,5]
## x    1    2    3    4    5
## y    6    7    8    9   10
## z   11   12   13   14   15

# Creating a matrix with numeric and character columns will make everything a character:

cbind(c(1, 2, 3, 4, 5),
      c("a", "b", "c", "d", "e"))
##      [,1] [,2]
## [1,] "1"  "a" 
## [2,] "2"  "b" 
## [3,] "3"  "c" 
## [4,] "4"  "d" 
## [5,] "5"  "e"

# Create a matrix of the integers 1:10,
#  with 5 rows and 2 columns

matrix(data = 1:10,
       nrow = 5,
       ncol = 2)
##      [,1] [,2]
## [1,]    1    6
## [2,]    2    7
## [3,]    3    8
## [4,]    4    9
## [5,]    5   10

# Create a matrix with 2 rows and 5 columns
matrix(data = 1:10,
       nrow = 2,
       ncol = 5)
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    5    7    9
## [2,]    2    4    6    8   10

# Create a matrix with 2 rows and 5 columns, but fill by row instead of columns
matrix(data = 1:10,
       nrow = 2,
       ncol = 5,
       byrow = TRUE)
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    2    3    4    5
## [2,]    6    7    8    9   10

# Create a dataframe of survey data
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))
# Print the result
survey
##   index sex age
## 1     1   m  99
## 2     2   m  46
## 3     3   m  23
## 4     4   f  54
## 5     5   f  23

str(survey)- # Show the structure of the survey dataframe
  
# Create a dataframe of survey data WITHOUT factors
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                       "sex" = c("m", "m", "m", "f", "f"),
                       "age" = c(99, 46, 23, 54, 23),
                       stringsAsFactors = FALSE)
# Print the result 
survey
##   index sex age
## 1     1   m  99
## 2     2   m  46
## 3     3   m  23
## 4     4   f  54
## 5     5   f  23

# Look at the structure: no more factors!
str(survey)
## 'data.frame':    5 obs. of  3 variables:
##  $ index: num  1 2 3 4 5
##  $ sex  : chr  "m" "m" "m" "f" ...
##  $ age  : num  99 46 23 54 23

# Matrix and Dataframe Functions

head()      # Show the first few rows
tail()      # Show the last few rows
View()      # Open the entire dataframe in a new window
Summary()   # Print summary statistics
structure() # Print additional information
names()     # List the names of columns

# To access a specific column in a dataframe by name, use the $
head(ToothGrowth[c("len", "supp")]) # Give me the len AND supp columns of ToothGrowth

# Create a new dataframe called survey
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "age" = c(24, 25, 42, 56, 22))

# Print the result
survey
##   index age
## 1     1  24
## 2     2  25
## 3     3  42
## 4     4  56
## 5     5  22

# Add a new column called sex to survey
survey$sex <- c("m", "m", "f", "f", "m")

# survey with new sex column
survey
##   index age sex
## 1     1  24   m
## 2     2  25   m
## 3     3  42   f
## 4     4  56   f
## 5     5  22   m

# Change name of 1st column of df to "a"
names(df)[1] <- "a"

# Change name of 2nd column of df to "b"
names(df)[2] <- "b"

# Change the name of the first column of survey to "participant.number"
names(survey)[1] <- "participant.number"
survey
##   participant.number age sex
## 1                  1  24   m
## 2                  2  25   m
## 3                  3  42   f
## 4                  4  56   f
## 5                  5  22   m

# Change the column name from age to age.years
names(survey)[names(survey) == "age"] <- "years"

survey
##   participant.number years sex
## 1                  1    24   m
## 2                  2    25   m
## 3                  3    42   f
## 4                  4    56   f
## 5                  5    22   m


# Slicing Dataframes

## Return row 1
df[1, ]

## Return column 5
df[, 5]

## Rows 1:5 and column 2
df[1:5, 2]

## Give the rows 1-6 and column 1 of ToothGrowth
ToothGrowth[1:6, 1]
### [1]  4.2 11.5  7.3  5.8  6.4 10.0

## Give the rows 1-3 and columns 1 and 3 of ToothGrowth
ToothGrowth[1:3, c(1,3)]
###    len dose
### 1  4.2  0.5
### 2 11.5  0.5

# Give me the 1st row (and all columns) of ToothGrowth
ToothGrowth[1, ]
##   len supp dose len.cm index
## 1 4.2   VC  0.5   0.42     1

## Give me the 2nd column (and all rows) of ToothGrowth
ToothGrowth[, 2]
###  [1] VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC VC
### [24] VC VC VC VC VC VC VC OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ
### [47] OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ OJ
### Levels: OJ VC

## Create a new df with only the rows of ToothGrowth
##  where supp equals VC
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]

## Create a new df with only the rows of ToothGrowth
##  where supp equals OJ and dose < 1

ToothGrowth.OJ.a <- ToothGrowth[ToothGrowth$supp == "OJ" &
                                  ToothGrowth$dose < 1, ]

## Get rows of ToothGrowth where len < 20 AND supp == "OJ" AND dose >= 1
subset(x = ToothGrowth,
       subset = len < 20 &
         supp == "OJ" &
         dose >= 1)
###    len supp dose len.cm index
### 41  20   OJ    1    2.0    41
### 49  14   OJ    1    1.4    49

## Get rows of ToothGrowth where len > 30 AND supp == "VC", but only return the len and dose columns
subset(x = ToothGrowth,
       subset = len > 30 & supp == "VC",
       select = c(len, dose))
###    len dose
### 23  34    2
### 26  32    2

## What is the mean tooth length of Guinea pigs given OJ?

## Step 1: Create a subsettted dataframe called oj

oj <- subset(x = ToothGrowth,
             subset = supp == "OJ")

## Step 2: Calculate the mean of the len column from
##  the new subsetted dataset

mean(oj$len)
### [1] 21

## Step 1: Create a subsettted dataframe called oj
oj <- ToothGrowth[ToothGrowth$supp == "OJ",]

## Step 2: Calculate the mean of the len column from
##  the new subsetted dataset
mean(oj$len)
### [1] 21

mean(ToothGrowth$len[ToothGrowth$supp == "OJ"])
### [1] 21

health <- data.frame("age" = c(32, 24, 43, 19, 43),
                     "height" = c(1.75, 1.65, 1.50, 1.92, 1.80),
                     "weight" = c(70, 65, 62, 79, 85))

health
###   age height weight
### 1  32    1.8     70
### 2  24    1.6     65
### 3  43    1.5     62
### 4  19    1.9     79
### 5  43    1.8     85

## Calculate bmi
health$weight / health$height ^ 2
### [1] 23 24 28 21 26

## Save typing by using with()
with(health, height / weight ^ 2)
### [1] 0.00036 0.00039 0.00039 0.00031 0.00025

## Long code
health$weight + health$height / health$age + 2 * health$height
### [1] 74 68 65 83 89

## Short code that does the same thing
with(health, weight + height / age + 2 * height)
### [1] 74 68 65 83 89


### 3  7.3  0.5
