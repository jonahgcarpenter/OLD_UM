# Jonah Carpenter
# Unit 14 - A
library(readr)
library(dplyr)
library(class)
library(ggplot2)
library(caret)

# Load the data
spamData <- read_csv("data/spamData.csv", col_names = FALSE, skip = 1)

# Assign column names
colnames <- paste0("A", 1:ncol(spamData))
colnames[58] <- "spam"
colnames(spamData) <- colnames

# Convert 'spam' column to a factor with labels "Yes" and "No"
spamData <- spamData %>%
  mutate(spam = ifelse(spam == 0, "No", "Yes")) 

set.seed(1)  # For reproducibility
trainIndex <- createDataPartition(spamData$spam, p = 0.7, list = FALSE)
trainData <- spamData[trainIndex, ]
testData <- spamData[-trainIndex, ]

# Separate predictors and response
train_x <- as.matrix(trainData[, -58])  # Exclude the 'spam' column
test_x <- as.matrix(testData[, -58])
train_y <- trainData$spam
test_y <- testData$spam

# Train KNN model with k = 5
knn_pred <- knn(train = train_x, test = test_x, cl = train_y, k = 5)

# Convert knn_pred and test_y to factors with levels "Yes" and "No"
knn_pred <- factor(knn_pred, levels = c("Yes", "No"))
test_y <- factor(test_y, levels = c("Yes", "No"))

# Confusion matrix
confusionMatrixResults <- confusionMatrix(knn_pred, test_y)
print(confusionMatrixResults)

# Fourfold plot
fourfoldplot(table(Predicted = knn_pred, Actual = test_y), color = c("deepskyblue", "tomato"), main = "KNN Confusion Matrix")

# Traditional confusion matrix heatmap
ggplot(as.data.frame(table(Predicted = knn_pred, Actual = test_y)), aes(x = Actual, y = Predicted, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq)) +
  scale_fill_gradient(low = "lightblue", high = "red") +
  labs(title = "KNN Confusion Matrix", x = "Actual", y = "Predicted") +
  theme_minimal()
