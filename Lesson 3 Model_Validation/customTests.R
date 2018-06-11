# Put custom tests in this file.
      
      # Uncommenting the following line of code will disable
      # auto-detection of new variables and thus prevent swirl from
      # executing every command twice, which can slow things down.
      
      # AUTO_DETECT_NEWVAR <- FALSE
      
      # However, this means that you should detect user-created
      # variables when appropriate. The answer test, creates_new_var()
      # can be used for for the purpose, but it also re-evaluates the
      # expression which the user entered, so care must be taken.

test_train_val_split <- function() {
try ({
  X_v <- get('X_v',globalenv())
  X_t <- get('X_t',globalenv())
  y_v <- get('y_v',globalenv())
  y_t <- get('y_t',globalenv())
  
  set.seed(423) 
  
  idx_val <- createDataPartition(y_train,p=0.3,list = FALSE)
  X_v_true <- X_train[idx_val,]
  X_t_true <- X_train[-idx_val,] 
  
  y_v_true <- y_train[idx_val] 
  y_t_true <- y_train[-idx_val] 
  
  t1 <- identical(X_v,X_v_true) 
  t2 <- identical(X_t,X_t_true) 
  t3 <- identical(y_v,y_v_true) 
  t4 <- identical(y_t,y_t_true) 
  ok <- all(t1,t2,t3,t4)
},silent = TRUE)
  exists('ok') && isTRUE(ok)
}

test_train_val_training <- function() {
try ({
  student_train_error <- get('train_error',globalenv())
  student_val_error <- get('val_error',globalenv())
  student_test_error <- get('test_error',globalenv())
  
  set.seed(1000) #Important for checking the answer. Do not change
  
  idx_val <- createDataPartition(y_train,p=0.3,list = FALSE)
  
  X_v <- X_train[idx_val,]
  X_t <- X_train[-idx_val,] 
  y_v <- y_train[idx_val] 
  y_t <- y_train[-idx_val] 
  
  mdl <- train(X_t,y_t,method = 'rpart',trControl = cntrl,tuneGrid = tree_grid)
  y_t_pred <- predict(mdl,X_t)
  y_v_pred <- predict(mdl,X_v)
  train_error <- mse(y_t,y_t_pred)
  val_error <- mse(y_v,y_v_pred)
  
  
  mdl <- train(X_train,y_train,method = 'rpart',trControl = cntrl,tuneGrid = tree_grid)
  y_test_pred <- predict(mdl,X_test)
  test_error <- mse(y_test,y_test_pred)
  
  
  t1 <- identical(student_train_error,train_error) 
  t2 <- identical(student_val_error,val_error) 
  t3 <- identical(student_test_error,test_error) 
  ok <- all(t1,t2,t3)
},silent = TRUE)
  exists('ok') && isTRUE(ok)
}
