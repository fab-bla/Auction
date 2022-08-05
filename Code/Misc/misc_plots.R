# packages
library(ggplot2)

# linear and quadratic loss
x <- seq(-1.5, 1.5, 0.001)
ys <- x^2
ya <- abs(x)
df <- data.frame(x, ys, ya)

# font change
showtext::showtext_auto()
sysfonts::font_add("lmmodern", 
                   "C:/Users/blasc/OneDrive/Documents/R/win-library/4.1/sysfonts/fonts/lmroman10-regular.ttf")
# write into thesis folder
# pdf("./../../Thesis/figures/barplots.pdf", width = 10, height = 6)

# align
#par(mfrow = c(2, 2), mar = c(4, 2.5, 2, 1), family = "lmmodern")

# plot 
ggplot(df, aes(x)) +
  geom_line(aes(y = ys), color = "forestgreen") +
  geom_line(aes(y = ya), color = "cornflowerblue") +
  theme_bw() +
  xlab("") +
  ylab("Loss") 
  
  
  
