#Created by Arzu Ozcan

##Purpose - To compile all R codes learnt in ANLY506

### ------------------------------------------------------------------------
### K-MEANS CLUSTER ANALYSIS - Week12
### ------------------------------------------------------------------------

# Packages Needed

library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization

# Data Preparation

## Rows are observations (individuals) and columns are variables
## Remove or estimate any missing value in the data 
## Standardize the data (i.e., scale) to make variables comparable. 
### e.g.data set USArrests

df <- USArrests
df <- scale(df)
head(df)

# Clustering Distance Measures

get_dist    # Computes a distance matrix between the rows of a data matrix. The default distance computed is the Euclidean
fviz_dist   # To visualize a distance matrix
## 
distance <- get_dist(df)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

# K-Means Clustering

##  Specify the number of clusters (K) to be created (by the analyst)
##  Select randomly k objects from the data set as the initial cluster centers or means
##  Assigns each observation to their closest centroid, based on the Euclidean distance between the object and the centroid
##  For each of the k clusters update the cluster centroid by calculating the new mean values of all the data points in the cluster. The centroid of a Kth cluster is a vector of length p containing the means of all variables for the observations in the kth cluster; p is the number of variables.
##  Iteratively minimize the total within sum of square (Eq. 7). That is, iterate steps 3 and 4 until the cluster assignments stop changing or the maximum number of iterations is reached. By default, the R software uses 10 as the default value for the maximum number of iterations.

# Computing k-means clustering in R 
kmeans      # Group the data into two clusters (centers = 2). 
nstart      # Attempts multiple initial configurations and reports on the best one. For example, adding nstart = 25 will generate 25 initial configurations. This approach is often recommended
k2 <- kmeans(df, centers = 2, nstart = 25)
str(k2)

## The output of kmeans 

### Cluster: A vector of integers (from 1:k) indicating the cluster to which each point is allocated
### Centers: A matrix of cluster centers
### Totss: The total sum of squares
### withinss: Vector of within-cluster sum of squares, one component per cluster
### tot.withinss: Total within-cluster sum of squares, i.e. sum(withinss)
### Betweenss: The between-cluster sum of squares, i.e. $totss-tot.withinss$
### size: The number of points in each cluster

fviz_cluster  # Provides a nice illustration of the clusters. If there are more than two dimensions (variables) fviz_cluster will perform principal component analysis (PCA) and plot the data points according to the first two principal components that explain the majority of the variance

fviz_cluster(k2, data = df)

### Use standard pairwise scatter plots to illustrate the clusters compared to the original variables
df %>%
  as_tibble() %>%
  mutate(cluster = k2$cluster,
         state = row.names(USArrests)) %>%
  ggplot(aes(UrbanPop, Murder, color = factor(cluster), label = state)) +
  geom_text()

### Set the number of clusters (k) before starting the algorithm
  
k3 <- kmeans(df, centers = 3, nstart = 25)
k4 <- kmeans(df, centers = 4, nstart = 25)
k5 <- kmeans(df, centers = 5, nstart = 25)

### Plots to compare
p1 <- fviz_cluster(k2, geom = "point", data = df) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = df) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = df) + ggtitle("k = 5")

library(gridExtra)
grid.arrange(p1, p2, p3, p4, nrow = 2)

# Determining Optimal Clusters

## Elbow Method

### Compute clustering algorithm (e.g., k-means clustering) for different values of k. For instance, by varying k from 1 to 10 clusters
### For each k, calculate the total within-cluster sum of square (wss)
### Plot the curve of wss according to the number of clusters k
### The location of a bend (knee) in the plot is generally considered as an indicator of the appropriate number of clusters
### We can implement this in R with the following code. The results suggest that 4 is the optimal number of clusters as it appears to be the bend in the knee (or elbow).

set.seed(123)

### function to compute total within-cluster sum of square 
wss <- function(k) {
  kmeans(df, k, nstart = 10 )$tot.withinss
}

### Compute and plot wss for k = 1 to k = 15
k.values <- 1:15

# extract wss for 2-15 clusters
wss_values <- map_dbl(k.values, wss)

plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

### “Elbow method” has been wrapped up in a single function (fviz_nbclust):
  
  set.seed(123)

fviz_nbclust(df, kmeans, method = "wss")

## Average Silhouette Method
### function to compute average silhouette for k clusters
avg_sil <- function(k) {
  km.res <- kmeans(df, centers = k, nstart = 25)
  ss <- silhouette(km.res$cluster, dist(df))
  mean(ss[, 3])
}

### Compute and plot wss for k = 2 to k = 15
k.values <- 2:15

### extract avg silhouette for 2-15 clusters
avg_sil_values <- map_dbl(k.values, avg_sil)

plot(k.values, avg_sil_values,
     type = "b", pch = 19, frame = FALSE, 
     xlab = "Number of clusters K",
     ylab = "Average Silhouettes")

### The “average silhoutte method” has been wrapped up in a single function (fviz_nbclust):
  
  fviz_nbclust(df, kmeans, method = "silhouette")

## Gap Statistic Method

### To compute the gap statistic method we can use the clusGap function which provides the gap statistic and standard error for an output.
###compute gap statistic
  set.seed(123)
  gap_stat <- clusGap(df, FUN = kmeans, nstart = 25,
                      K.max = 10, B = 50)
###Print the result
  print(gap_stat, method = "firstmax")
### Clustering Gap statistic ["clusGap"] from call:
### clusGap(x = df, FUNcluster = kmeans, K.max = 10, B = 50, nstart = 25)
### B=50 simulated reference sets, k = 1..10; spaceH0="scaledPCA"
###  --> Number of clusters (method 'firstmax'): 4
###           logW   E.logW       gap     SE.sim
###  [1,] 3.458369 3.638250 0.1798804 0.03653200
###  [2,] 3.135112 3.371452 0.2363409 0.03394132
###  [3,] 2.977727 3.235385 0.2576588 0.03635372
###  [4,] 2.826221 3.120441 0.2942199 0.03615597
###  [5,] 2.738868 3.020288 0.2814197 0.03950085
###  [6,] 2.669860 2.933533 0.2636730 0.03957994
###  [7,] 2.598748 2.855759 0.2570109 0.03809451
###  [8,] 2.531626 2.784000 0.2523744 0.03869283
###  [9,] 2.468162 2.716498 0.2483355 0.03971815
### [10,] 2.394884 2.652241 0.2573567 0.04104674
### Visualize the results with fviz_gap_stat which suggests four clusters as the optimal number of clusters
  
fviz_gap_stat(gap_stat)
# Extracting Results
## Suggested 4 as the number of optimal clusters
## Perform the final analysis
## Extract the results using 4 clusters

# Compute k-means clustering with k = 4
set.seed(123)
final <- kmeans(df, 4, nstart = 25)
print(final)
## K-means clustering with 4 clusters of sizes 13, 16, 13, 8
## 
## Cluster means:
##       Murder    Assault   UrbanPop        Rape
## 1 -0.9615407 -1.1066010 -0.9301069 -0.96676331
## 2 -0.4894375 -0.3826001  0.5758298 -0.26165379
## 3  0.6950701  1.0394414  0.7226370  1.27693964
## 4  1.4118898  0.8743346 -0.8145211  0.01927104
## 
## Clustering vector:
##        Alabama         Alaska        Arizona       Arkansas     California 
##              4              3              3              4              3 
##       Colorado    Connecticut       Delaware        Florida        Georgia 
##              3              2              2              3              4 
##         Hawaii          Idaho       Illinois        Indiana           Iowa 
##              2              1              3              2              1 
##         Kansas       Kentucky      Louisiana          Maine       Maryland 
##              2              1              4              1              3 
##  Massachusetts       Michigan      Minnesota    Mississippi       Missouri 
##              2              3              1              4              3 
##        Montana       Nebraska         Nevada  New Hampshire     New Jersey 
##              1              1              3              1              2 
##     New Mexico       New York North Carolina   North Dakota           Ohio 
##              3              3              4              1              2 
##       Oklahoma         Oregon   Pennsylvania   Rhode Island South Carolina 
##              2              2              2              2              4 
##   South Dakota      Tennessee          Texas           Utah        Vermont 
##              1              4              3              2              1 
##       Virginia     Washington  West Virginia      Wisconsin        Wyoming 
##              2              2              1              1              2 
## 
## Within cluster sum of squares by cluster:
## [1] 11.952463 16.212213 19.922437  8.316061
##  (between_SS / total_SS =  71.2 %)
## 
## Available components:
## 
## [1] "cluster"      "centers"      "totss"        "withinss"    
## [5] "tot.withinss" "betweenss"    "size"         "iter"        
## [9] "ifault"

fviz_cluster  # Visualaize the results
  
fviz_cluster(final, data = df)

## Extract the clusters and add to the initial data to do some descriptive statistics at the cluster level:
  
USArrests %>%
mutate(Cluster = final$cluster) %>%
group_by(Cluster) %>%
summarise_all("mean")
## # A tibble: 4 × 5
##   Cluster   Murder   Assault UrbanPop     Rape
##     <int>    <dbl>     <dbl>    <dbl>    <dbl>
## 1       1  3.60000  78.53846 52.07692 12.17692
## 2       2  5.65625 138.87500 73.87500 18.78125
## 3       3 10.81538 257.38462 76.00000 33.19231
## 4       4 13.93750 243.62500 53.75000 21.41250
  