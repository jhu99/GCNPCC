#' @title gcnpcc
#'
#' @description
#' Calculate partial correlation coefficients for a given set of genes and return the partial correlation matrix, with edges of the gene network estimated through adaptive thresholding
#'
#' @param A gene expression matrix of the studied genes
#' @param p number of genes involved in the calculation
#' @param h a parameter
#' @export
#' @return a matrix representing pairwise gene correlations and a binary adjacency matrix indicating the presence of network edges between genes
gcnpcc <- function(A,p,h){
  A<-t(A)
  n = dim(A)[1]; p = dim(A)[2]
  t0 = 2; tau = seq(0, 3.5, 0.01); smax = n / 2; lentau = length(tau); c0 = 0.25
  IndMatrix = matrix(1, p, p) - diag(rep(1, p))
  Eresidual = matrix(0, n, p)
  CoefMatrix = matrix(0, p, p - 1)
  AS = matrix(0, n, p)
  A=scale(A,scale=FALSE)
  AS=scale(A,center=FALSE)
  for (i in 1 : p){
    out = scalreg::scalreg(X = AS[, -i], y = A[, i], lam0 = sqrt(h * 2.01 * log(p * (log(p))^(1.5) / sqrt(n)) / n))
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

  EstThresh = Est * ( abs(Est) >= (t0 * sqrt(log(p) / n) * IndMatrix) )
  kappa = (n / 3) * mean( colSums(Eresidual^4) / (colSums(Eresidual^2))^2 )
  resprop = list()
  rejectprop = c()
  for (i in 1 : lentau){
    Threshold = tau[i] * sqrt(kappa * log(p) / n) * (1 - EstThresh^2)       #计算阈值
    SRec = 1 * (abs(Est) > Threshold);
    NoNSRec = 1 * (SRec == 0)
    resprop[[i]] = which(SRec == 1, arr.ind = TRUE)
    rejectprop = c(rejectprop, max(1, (sum(SRec) - p)))
  }
  FDPprop = 2 * p * (p - 1) * ( 1 - pnorm( tau * sqrt(log(p)) ) ) / rejectprop

  alpha = 0.05
  if (sum(FDPprop <= alpha) > 0) {
    tauprop = min(c(2, tau[FDPprop <= alpha]))
  } else {
    tauprop = 2
  }
  Threshold = tauprop * sqrt(kappa * log(p) / n) * (1 - EstThresh^2)
  SRec = 1 * (abs(Est) > Threshold)
  NoNSRec = 1 * (SRec == 0)
  FDPresprop = which(SRec == 1, arr.ind = TRUE)
  return(list(Est=Est,SRec=SRec))
}
