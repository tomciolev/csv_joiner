#INNER JOIN

df1 <- read.csv("~/csv_join/Departments.csv", header = T, sep = ",", dec = ".") 
df2 <- read.csv("~/csv_join/Employees.csv", header = T, sep = ",", dec = ".")

inner_join <- function(df1,df2,col_name){
  joined <- data.frame(matrix(ncol = ncol(df1)+ncol(df2), nrow = 0))
  colnames(joined) <- c(colnames(df1), colnames(df2))
  k = 1
  for(i in 1:nrow(df1)){
    for(j in 1:nrow(df2)){
      if(!is.na(df1[i, col_name]) && !is.na(df2[j,col_name]) && df1[i,col_name] == df2[j,col_name]){
        joined[k,] <- c(df1[i,], df2[j,])
        k = k+1
      }
    }
  }
  joined
}
inner_join(df1,df2, "department_id")
inner_join(df2,df1, "department_id")
#LEFT JOIN
df1 <- read.csv("~/csv_joiner/Departments.csv", header = T, sep = ",", dec = ".") 
df2 <- read.csv("~/csv_joiner/Employees.csv", header = T, sep = ",", dec = ".")
df1 <- read.csv("~/csv_joiner/orders.csv", header = T, sep = ",", dec = ".")
k = 1
departments[5,2] <- "HR"
df2[7,2] <- NA
col_name <- "employee_id"
joined <- data.frame(matrix(ncol = ncol(df1)+ncol(df2), nrow = 0))
colnames(joined) <- c(colnames(df1), colnames(df2))



left_join <- function(df1, df2, col_name){
  joined <- data.frame(matrix(ncol = ncol(df1)+ncol(df2), nrow = 0))
  colnames(joined) <- c(colnames(df1), colnames(df2))
  k = 1
  for(i in 1:nrow(df1)){
    if(is.na(df1[i,col_name]) || !df1[i,col_name] %in% df2[,col_name]){
      joined[k,] <- c(df1[i,], NA,NA,NA)
      k = k+1
    }
    else{
      for(j in 1:nrow(df2)){
        if(!is.na(df1[i, col_name]) && !is.na(df2[j,col_name]) && df1[i,col_name] == df2[j,col_name]){
          joined[k,] <- c(df1[i,], df2[j,])
          k = k+1
        }
      }
    }
    
  }
  joined
}
left_join(df1,df2,"department_id")
left_join(df2,df1,"department_id")
