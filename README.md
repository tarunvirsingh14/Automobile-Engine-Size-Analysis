# Engine Size Prediction Using Linear Regression (R)

This project analyzes and predicts automobile engine size using vehicle characteristics like price, horsepower, and fuel efficiency. It demonstrates how linear regression models can identify key predictors and how polynomial terms improve prediction accuracy.

## Overview

The goal of this project is to determine which vehicle features best explain variation in engine size. Several regression models are built and compared:

* Single-predictor models (price, horsepower, fuel efficiency)
* Multiple-predictor models (combining top features)
* Polynomial models with quadratic terms for enhanced fit

Model performance is evaluated using:

* **Adjusted R²** – proportion of variance explained
* **AIC** – balances model fit with complexity

## Data

The dataset (`imports-85.csv`) is from the UCI Machine Learning Repository and contains specifications for 205 automobiles from 1985, including:

* Engine size (response variable)
* Price
* Horsepower
* City and highway MPG
* Compression ratio, bore, stroke

## 🧮 How to Run


## 📈 Results

Price emerged as the strongest single predictor. The final model combining price and horsepower with quadratic terms achieved the best performance, explaining 84% of engine size variance while maintaining parsimony.

## 🛠️ Tools

* **R** for statistical computing
* Linear and polynomial regression
* Model diagnostics and comparison

## Author

Tarunvir Singh  
