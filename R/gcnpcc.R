#' @title corr
#'
#' @description
#' Calculate the correlation value for a given number of genes and return the correlation matrix
#'
#' @param p number of genes involved in the calculation
#' @param A gene expression matrix of the studied genes
#' @param h a parameter
#' @export
#' @return the correlation matrix
corr = function(p,A,h){
  A<-t(A)
  n = dim(A)[1]; p = dim(A)[2]
  t0 = 2; tau = seq(0, 3.5, 0.01); smax = n / 2; lentau = length(tau); c0 = 0.25
  IndMatrix = matrix(1, p, p) - diag(rep(1, p))
  Eresidual = matrix(0, n, p)
  CoefMatrix = matrix(0, p, p - 1)
  AS = matrix(0, n, p)
  for (i in 1 : p){
    A=scale(A,scale=FALSE)
    AS=scale(A,center=FALSE)
    out = scalreg(X = AS[, -i], y = A[, i], lam0 = sqrt(h * 2.01 * log(p * (log(p))^(1.5) / sqrt(n)) / n))
    Eresidual[, i] = out$residuals
    CoefMatrix[i, ] = out$coefficients / apply(A[, -i], 2, sd)
  }

  CovRes = t(Eresidual) %*% Eresidual / n
  Est = matrix(1, p, p)

  for (i in 1 : (p - 1)){
    for (j in (i + 1) : p){
      temp = Eresidual[, i] * Eresidual[, j] + Eresidual[, i]^2 * CoefMatrix[j, i] + Eresidual[, j]^2 * CoefMatrix[i, j - 1]
      Est[i, j] = mean(temp) / sqrt(diag(CovRes)[i] * diag(CovRes)[j])
      Est[j, i] = Est[i, j]
    }
  }
  return(Est)
}
