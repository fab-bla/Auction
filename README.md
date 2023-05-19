Procurement Auctions
================

This repository contains my [master
thesis](https://github.com/Base-R-Best-R/Auction/blob/main/Thesis/Thesis_FPSBPA.pdf)
on first-price sealed-bid procurement auctions. In particular, the aim is to predict
award prices of auctions held by the [Colorado Department of
Transportation](https://codot.gov/business/bidding/bid-tab-archives). To
date, the following models with varying preprocessing schedules have
been compared:

-   [Elastic
    Net](https://github.com/Base-R-Best-R/Auction/blob/main/Code/Models/Colab/CV_elastic_net.ipynb)
-   Ordinary Least Squares
    -   [with logistic PCA preprocessing (parallel
        CV)](https://github.com/Base-R-Best-R/Auction/blob/main/Code/Models/Colab/CV_PreProcess_LM.ipynb)
-   Random Forest
    -   [with recursive feature elimination (parallel
        CV)](https://github.com/Base-R-Best-R/Auction/blob/main/Code/Models/Colab/CV_RecursiveFeatureElimination_RF.ipynb)
    -   [with logistic PCA
        preprocessing](https://github.com/Base-R-Best-R/Auction/blob/main/Code/Models/Colab/Nested_CV_PCA_RF.ipynb)
    -   [with logistic PCA preprocessing (parallel
        CV)](https://github.com/Base-R-Best-R/Auction/blob/main/Code/Models/Colab/Parallel_NestedCV_RF.ipynb)
-   [XGBoost](https://github.com/Base-R-Best-R/Auction/blob/main/Code/Models/Colab/XGboost.ipynb)

# Best Model (09/26/22)

The boxplots below display the out of sample predicted values for the
models that have been trained so far. Further, as the Engineer's Estimate
may be considered as a benchmark for prediction it is also included in
the plot.

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

The boxplot shows that the Lasso regression seems to be able to predict
the outliers the best when compared to the remaining models and the
Engineer’s Estimate.

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

The plots above display the actual vs. predicted values. These plots may
be used to assess, whether certain models just predict the outliers
better, which is evident from the boxplots of predicted values. We
observe that the Lasso model seems to outperform the other models across
most of the observations in the validation set.

|      |    Lasso | logPCA_LM | logPCA_RF |   rfe_RF |      XGB | Eng. Est. |
|:-----|---------:|----------:|----------:|---------:|---------:|----------:|
| RMSE | 326.1261 |  609.4673 |  509.7934 | 560.7600 | 671.6634 |  497.0567 |
| MAE  | 241.7894 |  448.2662 |  348.2869 | 373.1132 | 376.3191 |  327.9388 |

The performance comparison utilizing linear and quadratic loss functions
further emphasizes the dominance of the Lasso model.
