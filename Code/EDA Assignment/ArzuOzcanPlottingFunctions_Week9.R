#Created by Arzu Ozcan

##Purpose - To compile all R codes learnt in ANLY506

### ------------------------------------------------------------------------
### CHAPTER 7 - EXPLARATORY DATA ANALYSIS
### ------------------------------------------------------------------------

#Bar Chart to examine the distribution of a categorical variable
ggplot(data = diamonds) +geom_bar(mapping = aes(x = cut)) 

# Histogram to examine the distribution of a continuous variable
ggplot(data = diamonds) +geom_histogram(mapping = aes(x = carat), binwidth = 0.5) 

# Graph the diamonds with a size of less than three carats and choose a smaller binwidth
smaller <- diamonds %>% 
  filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat)) +geom_histogram(binwidth = 0.1)

# Use geom_freqpoly() instead of geom_histogram() for multiple histograms in the same plot
ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +geom_freqpoly(binwidth = 0.1)


coord_cartesian()   # Use to see the unusual values 

# Drop the entire row with the strange values
diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))                   

# Replace the unusual values with missing values
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))   

# Displays the distribution of a continuous variable broken down by a categorical variable
geom_boxplot()  
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

# To visualize the covariation between categorical variables, you’ll need to count the number of observations for each combination
geom_count()    

ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))

# Scatterplot to visualise the covariation between two continuous variables
ggplot(data = faithful) + geom_point(mapping = aes(x = eruptions, y = waiting)) 