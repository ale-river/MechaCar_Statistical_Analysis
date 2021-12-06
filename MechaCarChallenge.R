###Challenge 15. R Analysis
###AutosRUs’ newest prototype

# DELIVERABLE 1

# Import libraries
> library(dplyr)
> library(tidyverse)

# Import datasets
> MechaCar_table <- read.csv("MechaCar_mpg.csv", header = TRUE, sep = ",")
> Suspension_table <- read.csv("Suspension_Coil.csv", header = TRUE, sep = ",")

# Result
> View(MechaCar_table)
> View(Suspension_table)

# MPG REGRESSION
# Create a multiple linear regression model
> lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = MechaCar_table)

Call:
lm(formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle + 
    ground_clearance + AWD, data = MechaCar_table)

Coefficients:
     (Intercept)    vehicle_length  
      -1.040e+02         6.267e+00  
  vehicle_weight     spoiler_angle  
       1.245e-03         6.877e-02  
ground_clearance               AWD  
       3.546e+00        -3.411e+00  

# Create summary statistics
> summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = MechaCar_table))

Call:
lm(formula = mpg ~ vehicle_length + vehicle_weight + spoiler_angle + 
    ground_clearance + AWD, data = MechaCar_table)

Residuals:
     Min       1Q   Median       3Q      Max 
-19.4701  -4.4994  -0.0692   5.4433  18.5849 

Coefficients:
                   Estimate Std. Error t value
(Intercept)      -1.040e+02  1.585e+01  -6.559
vehicle_length    6.267e+00  6.553e-01   9.563
vehicle_weight    1.245e-03  6.890e-04   1.807
spoiler_angle     6.877e-02  6.653e-02   1.034
ground_clearance  3.546e+00  5.412e-01   6.551
AWD              -3.411e+00  2.535e+00  -1.346
                 Pr(>|t|)    
(Intercept)      5.08e-08 ***
vehicle_length   2.60e-12 ***
vehicle_weight     0.0776 .  
spoiler_angle      0.3069    
ground_clearance 5.21e-08 ***
AWD                0.1852    
---
Signif. codes:  
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 8.774 on 44 degrees of freedom
Multiple R-squared:  0.7149,	Adjusted R-squared:  0.6825 
F-statistic: 22.07 on 5 and 44 DF,  p-value: 5.35e-11

# DELIVERABLE 2

# Create summary statistics
> total_summary <- Suspension_table %>% summarize(Mean_PSI=mean(PSI),PSI_median = median(PSI),PSI_variance = var(PSI),PSI_sd = sd(PSI))

# Create summary statistics based on Manufacturing Lots
> total_summary2 <- Suspension_table %>% group_by(Manufacturing_Lot) %>% summarize(PSI_mean = mean(PSI),PSI_median = median(PSI),PSI_variance = var(PSI),PSI_sd = sd(PSI))

# SUSPENSION COIL T-TEST
# Generate 50 random sample data points
> sample_table1 <- Suspension_table %>% sample_n(50)
> sample_table2 <- Suspension_table %>% sample_n(50)

# Compare the means of two samples
> t.test(sample_table1$PSI, sample_table2$PSI)

	Welch Two Sample t-test

data:  sample_table1$PSI and sample_table2$PSI
t = 0.82178, df = 87.803, p-value = 0.4134
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.475093  3.555093
sample estimates:
mean of x mean of y 
  1500.22   1499.18 

# DELIVERABLE 3

# Determine if the suspension coil’s PSI results are statistically 
# different from the mean population PSI results of 1,500.
# First:
> t.test(Suspension_table$PSI, mu = 1500)

	One Sample t-test

data:  Suspension_table$PSI
t = -1.8931, df = 149, p-value = 0.06028
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1497.507 1500.053
sample estimates:
mean of x 
  1498.78 

# Second:
> t.test(subset(Suspension_table, Manufacturing_Lot == "Lot1")$PSI, mu = 1500)

	One Sample t-test

data:  subset(Suspension_table, Manufacturing_Lot == "Lot1")$PSI
t = 0, df = 49, p-value = 1
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1499.719 1500.281
sample estimates:
mean of x 
     1500 

# Third:
> t.test(subset(Suspension_table, Manufacturing_Lot == "Lot2")$PSI, mu = 1500)

	One Sample t-test

data:  subset(Suspension_table, Manufacturing_Lot == "Lot2")$PSI
t = 0.51745, df = 49, p-value = 0.6072
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1499.423 1500.977
sample estimates:
mean of x 
   1500.2 

# Fourth:
> t.test(subset(Suspension_table, Manufacturing_Lot == "Lot3")$PSI, mu = 1500)

	One Sample t-test

data:  subset(Suspension_table, Manufacturing_Lot == "Lot3")$PSI
t = -2.0916, df = 49, p-value = 0.04168
alternative hypothesis: true mean is not equal to 1500
95 percent confidence interval:
 1492.431 1499.849
sample estimates:
mean of x 
  1496.14 

# DESIGN MY OWN STUDY
# Use mtcars to compare miles per gallon (mpg) vs. horsepower (hp)
> head(mtcars)
                   mpg cyl disp  hp drat    wt
Mazda RX4         21.0   6  160 110 3.90 2.620
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875
Datsun 710        22.8   4  108  93 3.85 2.320
Hornet 4 Drive    21.4   6  258 110 3.08 3.215
Hornet Sportabout 18.7   8  360 175 3.15 3.440
Valiant           18.1   6  225 105 2.76 3.460
                   qsec vs am gear carb
Mazda RX4         16.46  0  1    4    4
Mazda RX4 Wag     17.02  0  1    4    4
Datsun 710        18.61  1  1    4    1
Hornet 4 Drive    19.44  1  0    3    1
Hornet Sportabout 17.02  0  0    3    2
Valiant           20.22  1  0    3    1

# Create a single linear regression model
> lm(mpg ~ hp, data = mtcars)

Call:
lm(formula = mpg ~ hp, data = mtcars)

Coefficients:
(Intercept)           hp  
   30.09886     -0.06823  

# Create summary linear model
> summary(lm(mpg ~ hp, data = mtcars))

Call:
lm(formula = mpg ~ hp, data = mtcars)

Residuals:
    Min      1Q  Median      3Q     Max 
-5.7121 -2.1122 -0.8854  1.5819  8.2360 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept) 30.09886    1.63392  18.421  < 2e-16
hp          -0.06823    0.01012  -6.742 1.79e-07
               
(Intercept) ***
hp          ***
---
Signif. codes:  
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.863 on 30 degrees of freedom
Multiple R-squared:  0.6024,	Adjusted R-squared:  0.5892 
F-statistic: 45.46 on 1 and 30 DF,  p-value: 1.788e-07


# Create summary statistics for horsepower (hp)
> mtcars %>% summarize(hp_mean= mean(hp),hp_median = median(hp),hp_variance = var(hp),hp_sd = sd(hp))
   
   hp_mean hp_median hp_variance    hp_sd
1 146.6875       123    4700.867 68.56287

# Generate 16 random sample data points 
> sample_mtcars <- mtcars %>% sample_n(16)

# Determine statistical differences using t-test
> t.test(sample_mtcars$hp, mu = 146)
	One Sample t-test

data:  sample_mtcars$hp
t = 0.50106, df = 15, p-value = 0.6236
alternative hypothesis: true mean is not equal to 146
95 percent confidence interval:
 114.4779 196.8971
sample estimates:
mean of x 
 155.6875 

