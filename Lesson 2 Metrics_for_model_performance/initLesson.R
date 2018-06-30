# Code placed in this file fill be executed every time the
      # lesson is started. Any variables created here will show up in
      # the user's working directory and thus be accessible to them
      # throughout the lesson.


library(mlbench)
library(caret)
data("BostonHousing")

set.seed(37)
train_idx <- createDataPartition(BostonHousing$medv,list=FALSE)
training_set <- BostonHousing[train_idx,]
testing_set <- BostonHousing[-train_idx,]

X_train <- BostonHousing[train_idx,1:13]
y_train <- BostonHousing[train_idx,14]

X_test <- BostonHousing[-train_idx,1:13]
y_test <- BostonHousing[-train_idx,14]

cntrl <- trainControl(method = 'none')
tree_grid<- expand.grid(cp=0.0)

mdl_tree<-train(X_train,y_train,method='rpart',trControl = cntrl,tuneGrid = tree_grid)
mdl_tree2<-train(X_train,y_train,method='rpart',trControl = cntrl,tuneGrid = tree_grid,weights=y_train^-2)

mse <- function(y_true,y_pred) {
  mean((y_pred-y_true)^2)
}

pmse <- function(y_true,y_pred) {
  mean(((y_pred-y_true)/y_true)^2)
}

y_pred_tree1 = predict(mdl_tree,X_test)
y_pred_tree2 = predict(mdl_tree2,X_test)

model_comp<- data.frame(mse = c(mse(y_test,y_pred_tree1),
                     mse(y_test,y_pred_tree2)),
            pmse= c(pmse(y_test,y_pred_tree1),
                    pmse(y_test,y_pred_tree2)),
            row.names=c('Tree 1','Tree 2'))
          
