# Code placed in this file fill be executed every time the
      # lesson is started. Any variables created here will show up in
      # the user's working directory and thus be accessible to them
      # throughout the lesson.

library(mlbench)
library(caret)
data("BostonHousing")

set.seed(4)
train_idx <- createDataPartition(BostonHousing$medv,list=FALSE)
training_set <- BostonHousing[train_idx,]
testing_set <- BostonHousing[-train_idx,]

X_train <- BostonHousing[train_idx,1:13]
y_train <- BostonHousing[train_idx,14]

X_test <- BostonHousing[-train_idx,1:13]
y_test <- BostonHousing[-train_idx,14]

cntrl <- trainControl(method = 'none')
tree_grid<- expand.grid(cp=0.0)

mse <- function(y_true,y_pred) {
  mean((y_pred-y_true)^2)
}
