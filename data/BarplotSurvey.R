# Function for plotting
BarplotSurvey <- function(variable = dataVars[3], 
                          selected = selectVars,
                          data.db  = lapop,
                          main     = dataQuestions2[grep(variable, dataVars)[1]]){
  
  # Subset
  subset.db <- data.db[data.db$q2 %in% levels(data.db$q2)[selected$q2] &
                         data.db$q1 %in% levels(data.db$q1)[selected$q1] &
                         data.db$etid %in% levels(data.db$etid)[selected$etid] &
                         data.db$ur %in% levels(data.db$ur)[selected$ur], ] 
  # Survey design 
  require(survey)
  subset.svy <- svydesign(ids     = ~cluster, 
                          weights = ~wt, 
                          strata  = ~estratopri, 
                          data    = subset.db)
  # Extract labels 
  tbNames <- levels(subset.db[, variable])
  
  # Create confidence intervals 
  tb      <- svymean(~get(variable), design = subset.svy, na.rm = T)
  CI.l    <- tb - (qnorm(0.975) * sqrt(diag(attr(tb, "var"))))
  CI.u    <- tb + (qnorm(0.975) * sqrt(diag(attr(tb, "var"))))
  tb2     <- as.data.frame(cbind(tb, CI.l, CI.u))
  # xlim    <- c(0, .05 * (round(0.22/0.05) + 2))
  
  # Create plot and store y coordinates
  linesTitle <- length(strsplit(main,"\n")[[1]]) + 1
  par(mar = c(c(6, 9, linesTitle, 2) + 0.1), xpd = NA)
  bPlot <- barplot(tb2$tb, 
                   horiz = T,
                   las = 1, 
                   col = "antiquewhite",
                   names.arg = tbNames,
                   main = main,
                   xlim = c(0,1),
                   xlab = "Porcentaje (%)") 
  # Add error bars 
  arrows(x0 = tb2[,"CI.l"], y0 = bPlot, 
         x1 = tb2[,"CI.u"], y1 = bPlot,
         length = bPlot[1]/15, angle = 90, code = 3)
  # Add legend
  mtext(text = "Fuente: elaborado por @javierbrolo y @d_alburez, con datos de LAPOP 2016/17",
        side = 1, cex = 0.75, line = 4)
  
}