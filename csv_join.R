#Reading arguments from cmd

#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

#INNNER JOIN

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

#LEFT JOIN

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

#GENERAL FUNCTION FOR JOINING

join <- function(file_path1, file_path2, column_name, join_type){
  df1 <- read.csv(file = file_path1, header = T, sep = ",", dec = ".")
  df2 <- read.csv(file = file_path2, header = T, sep = ",", dec = ".")
  if(!column_name %in% colnames(df1) || !column_name %in% colnames(df2)){
    print("Podaj nazwę kolumny znajdującą się w obu plikach!")
  }
  else{
    switch(join_type,
           inner={
             inner_join(df1, df2, column_name)
           },
           left={
             left_join(df1, df2, column_name)
           },
           right={
             help = df1
             df1 = df2
             df2 = help
             left_join(df1, df2, column_name)
           })
  }
}

#JOIN FUNCTION with arguments from cmd
join(args[1], args[2], args[3], args[4])
