# Jonah Carpenter - Clustering Activity
library(dplyr)
library(tibble)
library(ggplot2)
library(cluster)
library(factoextra)

data <- mtcars %>% 
  rownames_to_column(var = "model") %>% 
  as_tibble()

scaled_data <- data %>%
  select(-model) %>%
  scale()

dist_matrix <- dist(scaled_data, method = "euclidean")
hc <- hclust(dist_matrix, method = "ward.D2")
plot(hc, labels = data$model, main = "Hierarchical Clustering Dendrogram")

kmeans_result <- kmeans(scaled_data, centers = 3, nstart = 25)

fviz_cluster(kmeans_result, data = scaled_data, geom = "point", label = data$model) +
  ggtitle("K-Means Clustering of Car Models")
