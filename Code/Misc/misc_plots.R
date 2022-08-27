# packages
library(ggplot2)
setwd("./GitHub/Auction")
# linear and quadratic loss
x <- seq(-2, 2, 0.001)
ys <- x^2
ya <- abs(x)
df <- data.frame(x, ys, ya)

# font change
showtext::showtext_auto()
sysfonts::font_add("lmmodern", 
                   "C:/Users/blasc/OneDrive/Documents/R/win-library/4.1/sysfonts/fonts/lmroman10-regular.ttf")

# write into thesis folder
pdf("./Thesis/figures/Lossfun.pdf", width = 10, height = 6)

# align
par(mar = c(4, 4, 2, 1), family = "lmmodern")

plot(x, ys, type = "n", xlab = "Error", ylab = "Loss")
grid(lwd = 1.5)
lines(x,ys, col = "forestgreen", lwd = 2)
lines(x,ya, col = "cornflowerblue", lwd = 2)
legend("top", legend = c("Quadratic Loss", "Linear Loss"), 
       col = c("forestgreen", "cornflowerblue"), lty = 1, lwd = 2)
dev.off()

  
  