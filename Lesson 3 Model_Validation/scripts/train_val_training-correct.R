set.seed(1000) #Important for checking the answer. Do not change

idx_val <- createDataPartition(y_train,p=0.3,list = FALSE)

X_v <- X_train[idx_val,]
X_t <- X_train[-idx_val,] 

y_v <- y_train[idx_val] 
y_t <- y_train[-idx_val] 

# training the model
# remember that cntrl and grid only simplify the train behaviour for now.
mdl <- train(X_t,y_t,method = 'rpart',trControl = cntrl,tuneGrid = tree_grid)

#predict the target for t and v set and calculate the errors using mean square
#error for which we provided a predefined function mse
y_t_pred <- predict(mdl,X_t)
y_v_pred <- predict(mdl,X_v)

train_error <- mse(y_t,y_t_pred)
val_error <- mse(y_v,y_v_pred)

#Retraining the model on all the training data to make test prediction

mdl <- train(X_train,y_train,method = 'rpart',trControl = cntrl,tuneGrid = tree_grid)

#predict the target for t and v set and calculate the errors using mse
y_test_pred <- predict(mdl,X_test)

test_error <- mse(y_test,y_test_pred)

print(paste('Training error: ',train_error))
print(paste('Validation error: ',val_error))
print(paste('Testing error: ',test_error))
