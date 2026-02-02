# ============================================================================
# Stats Project: Predicting Automobile Engine Size
# Author: Tarunvir Singh
# Description: Linear regression analysis using UCI Automobile data to predict 
# engine size from vehicle characteristics, comparing single and multiple 
# predictor models.
# ============================================================================

# Load required libraries
library(ISLR)

# ============================================================================
# DATA IMPORT AND EXPLORATION
# ============================================================================

# Import automobile dataset
imports.85 <- read.csv("~/Documents/UCI_Data_Sets/automobile/imports-85.csv")

# Quick data exploration
head(imports.85)
summary(imports.85)

# Visualize all relationships
plot(imports.85[, c(16, 21, 23:25)])  # Focus on relevant columns

# ============================================================================
# MODEL 1: SINGLE PREDICTOR MODELS
# ============================================================================

# Test four potential predictors against enginesize

# Model 1a: Horsepower
m1.hp <- lm(enginesize ~ horsepower, data = imports.85)
summary(m1.hp)  # R² = 0.7131, AIC = 1749.688

# Model 1b: City MPG
m1.ct <- lm(enginesize ~ citympg, data = imports.85)
summary(m1.ct)  # R² = 0.5106, AIC = 1852.726

# Model 1c: Highway MPG
m1.hw <- lm(enginesize ~ highwaympg, data = imports.85)
summary(m1.hw)  # R² = 0.5416, AIC = 1840.130

# Model 1d: Price (BEST SINGLE PREDICTOR)
m1.pr <- lm(enginesize ~ price, data = imports.85)
summary(m1.pr)  # R² = 0.7888, AIC = 1690.528

# Compare all Model 1 variants
AIC(m1.hp, m1.ct, m1.hw, m1.pr)

# ============================================================================
# VISUALIZATIONS FOR MODEL 1
# ============================================================================

# Create scatter plots with fitted lines for each predictor

# Horsepower
plot(imports.85$horsepower, imports.85$enginesize,
     xlab = "Horsepower", ylab = "Engine Size",
     main = "Engine Size vs Horsepower")
abline(m1.hp, col = "blue", lwd = 2)

# City MPG
plot(imports.85$citympg, imports.85$enginesize,
     xlab = "City MPG", ylab = "Engine Size",
     main = "Engine Size vs City MPG")
abline(m1.ct, col = "blue", lwd = 2)

# Highway MPG
plot(imports.85$highwaympg, imports.85$enginesize,
     xlab = "Highway MPG", ylab = "Engine Size",
     main = "Engine Size vs Highway MPG")
abline(m1.hw, col = "blue", lwd = 2)

# Price (Final Model 1 - for paper)
plot(imports.85$price, imports.85$enginesize,
     xlab = "Price ($)", ylab = "Engine Size",
     main = "Model 1: Engine Size vs Price")
abline(m1.pr, col = "blue", lwd = 2)

# ============================================================================
# MODEL 2: MULTIPLE PREDICTOR MODELS
# ============================================================================

# Model 2a: Price + Horsepower (linear terms)
m2.pr.hp <- lm(enginesize ~ price + horsepower, data = imports.85)
summary(m2.pr.hp)  # R² = 0.8329, AIC = 1646.379

# Model 2b: Price + Highway MPG
m2.pr.hw <- lm(enginesize ~ price + highwaympg, data = imports.85)
summary(m2.pr.hw)  # R² = 0.808, AIC = 1673.186

# Model 2c: Price + Horsepower + Highway MPG + City MPG
m2.pr.hp.hw.ct <- lm(enginesize ~ price + horsepower + highwaympg + citympg,
                      data = imports.85)
summary(m2.pr.hp.hw.ct)  # R² = 0.84, AIC = 1639.909

# Model 2d: Price + Horsepower with quadratic terms (BEST MODEL)
m2.pr.hp.sq <- lm(enginesize ~ price + I(price^2) + horsepower + I(horsepower^2),
                   data = imports.85)
summary(m2.pr.hp.sq)  # R² = 0.8417, AIC = 1637.826

# Compare all Model 2 variants
AIC(m2.pr.hp, m2.pr.hw, m2.pr.hp.hw.ct, m2.pr.hp.sq)

# ============================================================================
# FINAL MODEL COMPARISON
# ============================================================================

# Compare best Model 1 vs best Model 2
cat("\n=== FINAL MODEL COMPARISON ===\n")
cat("Model 1 (Price only):\n")
cat("  Adjusted R² =", summary(m1.pr)$adj.r.squared, "\n")
cat("  AIC =", AIC(m1.pr), "\n\n")

cat("Model 2 (Price² + Horsepower²):\n")
cat("  Adjusted R² =", summary(m2.pr.hp.sq)$adj.r.squared, "\n")
cat("  AIC =", AIC(m2.pr.hp.sq), "\n")

# ============================================================================
# DIAGNOSTIC PLOTS
# ============================================================================

# Check Model 1 assumptions
par(mfrow = c(2, 2))
plot(m1.pr, main = "Model 1 Diagnostics")

# Check Model 2 assumptions
par(mfrow = c(2, 2))
plot(m2.pr.hp.sq, main = "Model 2 Diagnostics")
par(mfrow = c(1, 1))  # Reset plot layout

# ============================================================================
# ADDITIONAL EXPLORATIONS (Not used in final paper)
# ============================================================================

# Quadratic price model (not as good as Model 2d)
m1.pr.sq <- lm(enginesize ~ price + I(price^2), data = imports.85)
summary(m1.pr.sq)  # AIC = 1691.570

# Inverse price model (worse than quadratic)
m1.pr.inv <- lm(enginesize ~ price + I(1/price), data = imports.85)
summary(m1.pr.inv)  # AIC = 1692.056

# Interaction term model
m2.interaction <- lm(enginesize ~ price * horsepower, data = imports.85)
summary(m2.interaction)

# Overfitted model using all variables (for demonstration)
overfit <- lm(enginesize ~ . - name, data = imports.85)
summary(overfit)  # R² = 0.9821 (too high - overfitting!)
