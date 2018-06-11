set.seed(423) #Important for checking the answer. Do not change

idx_val <- createDataPartition(y_train,p=0.3,list = FALSE)

X_v <- X_train[idx_val,]
X_t <- X_train[-idx_val,] #Fill

  
# Create a split for y_train. Remember
# that y is only one dimensional so the "," part is not needed
y_v <- y_train[idx_val] #Fill
y_t <- y_train[-idx_val] #Fill
