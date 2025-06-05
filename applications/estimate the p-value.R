#estimating the p-value of each edge
n_permutations <- 1000
p_values <- vector("numeric", nrow(res))
permuted_cor <- matrix(NA, nrow = nrow(res), ncol = n_permutations)
for (i in 1:nrow(res)) {
  actual_cor <- res[i, "data"]
  permuted_cor_row <- vector("numeric", n_permutations)
  for (j in 1:n_permutations) {
    shuffled_data <- sample(res$data, replace = FALSE)
    permuted_cor_row[j] <- shuffled_data[i]
  }
  permuted_cor[i, ] <- permuted_cor_row
  p_value <- sum(permuted_cor_row >= actual_cor) / n_permutations
  res[i, "p-value"] <- p_value
}
