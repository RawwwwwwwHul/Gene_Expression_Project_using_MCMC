# Bayesian Gene Expression Classifier

## Overview

This project uses **Bayesian Logistic Regression (MCMC via Stan)** to classify breast cancer subtypes (**Basal vs Luminal**) from gene expression data.

Unlike standard models, it provides both:

* Predictions
* Uncertainty estimates

---

## Method

* Preprocessing + PCA (reduce 54k genes → 50 features)
* Bayesian model in R (rstan)
* Predictions + visualization in Python
* Compared with sklearn Logistic Regression

---

## Results

* Accurate classification
* Good MCMC convergence (R̂ ≈ 1)
* Higher uncertainty near decision boundary

---

## Dataset

Dataset not included due to size.

Download here:
https://www.kaggle.com/datasets/brunogrisci/breast-cancer-gene-expression-cumida

---

## Tech Stack

* Python (NumPy, sklearn, matplotlib)
* R (rstan, bayesplot)

---

## How to Run

1. Run preprocessing notebook
2. Run `MCMC.R`
3. Run prediction notebook

---

## Key Insight

Bayesian models provide **confidence-aware predictions**, which are valuable in medical applications.
