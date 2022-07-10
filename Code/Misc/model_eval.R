
## CV evaluation curves ##

plot.cva.glmnet <- function(x, ..., legend.x = xlim[1], legend.y = xlim[2], 
                            log.x = TRUE, c.legend = 0.7){
  
  n <- length(x$modlist)
  cvm <- sapply(x$modlist, "[[", "cvm", simplify=FALSE)
  oldPal <- palette(topo.colors(n))
  on.exit(palette(oldPal))
  ylab <- x$modlist[[1]]$name
  xlst <- lapply(x$modlist, "[[", "lambda")
  ylst <- lapply(x$modlist, "[[", "cvm")
  xlim <- if(log.x) log(range(xlst)) else range(xlst)
  ylim <- range(ylst)
  xlab <- if(log.x) "log Lambda" else "Lambda"
  plot(NA, xlim=xlim, ylim=ylim, xlab=xlab, ylab=x$modlist[[1]]$name, type="n", ...)
  for(i in seq_along(cvm))
  {
    xvals <- if(log.x) log(xlst[[i]]) else xlst[[i]]
    lines(xvals, ylst[[i]], col=i)
  }
  if(!is.null(legend.x) && !is.null(legend.y))
    graphics::legend(xlim[1], ylim[2], x$alpha, col=seq_along(x$alpha), lty=1,
                     cex = c.legend)
  invisible(x)
}


## performance evaluation curves ##

Eval_Curve_prel <- function(act_label, pred_val){
  
  lapply(act_label, function(x){
    
    # labels
    labels <- as.numeric(pred_val) 

    # order
    labels_ordered <- labels[order(x, decreasing = TRUE)]
    
    # df
    roc_dat <- data.frame(TPR = cumsum(labels_ordered) / sum(labels_ordered),
                          FPR = cumsum(!labels_ordered) / sum(!labels_ordered),
                          PRC = cumsum(labels_ordered) / 1:length(labels_ordered))
    
    # return
    roc_dat
    
  }) 
  
}


Eval_Curve <- function(E_Curve_Prel, col, leg_text, RoC = TRUE, act_label = NULL, diss = FALSE, main = ""){
  
  # RoC
  if(RoC == TRUE){
    
    # plot pane
    plot(E_Curve_Prel[[1]]$FPR, E_Curve_Prel[[1]]$TPR, type = "n", ylab = "Sensitivity",
         xlab = "1 - Specificity", main = main)
    grid()
    
    
    # add RoC lines
    invis.Map(function(x, C){
      
      lines(x$FPR, x$TPR, type = "l", col = C, lwd = 2)
      
    }, E_Curve_Prel, col)
    
    lines(c(0, 1), c(0, 1), lty = "dashed", lwd = 2, col = "grey")
    legend("topleft", legend = leg_text, fill = col, cex = 0.7)
    
    if(diss == TRUE){
      text(x = 0.5,y = 0.52,"Alman vs. Predictor", srt = 33, cex = 0.8, col = "grey")
    }
  } else {
    
    # prel
    noobl <- mean(as.numeric(act_label))
    
    # plot pane
    plot(E_Curve_Prel[[1]]$FPR, E_Curve_Prel[[1]]$TPR, type = "n", ylab = "Precision",
         xlab = "Sensitivity", main = main)
    grid()
    
    # add PS lines
    invis.Map(function(x, c){
      
      lines(x$TPR, x$PRC, type = "l", col = c, lwd = 2)
      
    }, E_Curve_Prel, col)
    
    abline(h = noobl, lty = "dashed", lwd = 2, col = "grey")
    legend("topright", legend = leg_text, fill = col, cex = 0.7)
    
    if(diss == TRUE){
      text(y = noobl + 0.021, x = 0.5, "Alman vs. Predictor", cex = 0.9, col = "grey")
    }                           
  }
}

# Actual vs Predicted
Act_vs_Pred <- \(Act, Pred, bg_alt = FALSE, fill = "cornflowerblue", 
                 outcol = "firebrick", size = 2, shape = 23, 
                 title = "Actual vs. Predicted", alpha = 1){
  
  # init. plot
  ggplot() +
    
    # X = Y line
    geom_abline(slope = 1, intercept = 0, lwd = 1.5, col = "darksalmon") +
    
    # scatterplot 
    geom_point(aes(x = Act, y = Pred),
               shape = shape, fill = fill, color = outcol, size = size,
               alpha = alpha) +
    
    # theme
    theme_bw() +
    
    labs(title = title, x = "Actual", y = "Predicted") +
    
    # add colored grid optionally
    {if(bg_alt) theme(panel.background = element_rect(fill = "#90EE90",
                                                      size = 2, linetype = "solid"),
                      panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                                      colour = "white"), 
                      panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                                      colour = "white"))}
  
}

## Variable Importance ##

varImp <- function (object, lambda = NULL, ...){
  
  if (is.null(lambda)) {
    if (length(lambda) > 1) 
      stop("Only one value of lambda is allowed right now")
    if (!is.null(object$lambdaOpt)) {
      lambda <- object$lambdaOpt
    }
    else stop("must supply a value of lambda")
  }
  beta <- predict.glmnet(object, s = lambda, type = "coef")
  if (is.list(beta)) {
    out <- do.call("cbind", lapply(beta, function(x) x[, 
                                                       1]))
    out <- as.data.frame(out, stringsAsFactors = TRUE)
  }
  else out <- data.frame(Overall = beta[,1])
  out <- abs(out[rownames(out) != "(Intercept)",,drop = FALSE])
  out <- out/max(out)
  out[order(out$Overall, decreasing = TRUE),,drop=FALSE]
}

