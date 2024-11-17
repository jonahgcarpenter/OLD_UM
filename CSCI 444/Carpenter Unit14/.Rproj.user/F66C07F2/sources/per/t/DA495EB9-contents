# Jonah Carpenter
# Unit 14 - B
library(readr)
library(dplyr)
library(class)
library(ggplot2)
library(caret)
library(rpart)
library(rpart.plot)

# Load the data
spamData <- read_csv("data/spamDataW.csv")

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

# Train a decision tree with specific control parameters to match the structure
dt_model_rpart <- rpart(
  spam ~ .,
  data = trainData,
  method = "class",
  control = rpart.control(cp = 0.005, maxdepth = 5, minsplit = 20)
)

# Plot the decision tree with custom styling to match the example
rpart.plot(
  dt_model_rpart,
  type = 3,
  extra = 104,
  under = TRUE,
  box.palette = "GnBu",
  shadow.col = "gray",
  nn = FALSE,
  fallen.leaves = TRUE,
  cex = 0.8,
)

# Train the decision tree using rpart2 with caret
dt_model_rpart2 <- train(
  spam ~ .,
  data = trainData,
  method = "rpart2",
  trControl = trainControl(method = "cv", number = 10),
  tuneGrid = data.frame(maxdepth = 5)
)

# Plot the decision tree using prp (rpart.plot) for rpart2 model
rpart.plot(
  dt_model_rpart2$finalModel,
  type = 3,
  extra = 104,
  under = TRUE,
  box.palette = "GnBu",
  shadow.col = "gray",
  nn = FALSE,
  fallen.leaves = TRUE,
  cex = 0.8
)
