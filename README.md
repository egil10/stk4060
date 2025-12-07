# STK4060 – Time Series

[![Course Link](https://img.shields.io/badge/Course-STK4060-blue)](https://www.uio.no/studier/emner/matnat/math/STK4060/index-eng.html)

Repository for **STK4060 – Time Series** course at the University of Oslo. This course covers the main models and techniques for analyzing time-correlated data, including ARMA processes, spectral analysis, and state-space models.

## Course Information

- **Course Code**: STK4060
- **Credits**: 10
- **Level**: Master
- **Teaching Language**: English
- **Course Page**: [STK4060 – Time Series](https://www.uio.no/studier/emner/matnat/math/STK4060/index-eng.html)

### Course Content

- Estimation and testing of hypothesis with autoregressive processes and moving averages (ARMA processes)
- Stationary processes
- Correlogram, periodogram, and spectrum
- State-space models (Kalman filter)
- Illustration on real data

### Learning Outcome

You learn about the main models and techniques to analyze data where the time dimension is important. This is a useful basis to evaluate how time-correlated data should be treated.

### Recommended Previous Knowledge

- STK1100 – Probability and Statistical Modelling
- STK1110 – Statistical Methods and Data Analysis
- One of the following:
  - STK2100 – Machine Learning and Statistical Methods for Prediction and Classification
  - STK3100 – Introduction to Generalized Linear Models

## Repository Structure

```
stk4060/
├── book/              # Textbook examples and plots
│   ├── 01-01.R       # Time series examples (Johnson & Johnson, temperature, speech, DJIA, etc.)
│   ├── 01-02.R       # Moving averages, autoregression, random walk examples
│   └── plots/        # Generated plots from textbook examples
├── oblig1/           # Assignment 1
│   ├── 1.R          # Exercise 1: Autocovariance and trend analysis
│   ├── 2.R          # Exercise 2: AR(1) processes, ML estimation, Whittle estimation
│   ├── 3.R          # Exercise 3: (placeholder)
│   ├── 4.R          # Exercise 4: EUR/NOK exchange rate analysis
│   ├── data/        # Data files for assignments
│   └── plots/       # Generated plots for assignments
├── pamphlet/        # Spectral analysis examples
│   ├── 05-01.R     # Spectral density plots
│   └── plots/      # Generated spectral plots
├── rsc/             # Course resources
│   ├── stk4060 bok - main.pdf          # Course textbook
│   └── stk4060 eksamen 2018-2010.pdf   # Past exam papers
└── README.md        # This file
```

## Setup and Dependencies

This repository uses **R** for all analyses. Required R packages:

```r
# Core packages
library(tidyverse)  # Data manipulation and visualization
library(astsa)      # Applied Statistical Time Series Analysis
library(xts)        # Extended time series objects
library(readr)      # Reading data files
```

### Installation

Install required packages in R:

```r
install.packages(c("tidyverse", "astsa", "xts", "readr"))
```

## Contents Overview

### Textbook Examples (`book/`)

The `book/` directory contains R scripts reproducing examples from the course textbook:

- **01-01.R**: Various time series examples including:
  - Johnson & Johnson quarterly earnings
  - Global temperature anomalies
  - Speech data (pitch period)
  - DJIA returns
  - Southern Oscillation Index and Recruitment
  - Lynx-Hare population dynamics
  - fMRI data
  - Earthquake vs. Explosion data

- **01-02.R**: Fundamental time series concepts:
  - Moving averages
  - Autoregressive processes
  - Random walk with drift
  - Seasonal decomposition (Hawaiian occupancy rate)

### Assignment 1 (`oblig1/`)

**Exercise 1**: Autocovariance analysis
- Simulating time series with exponential autocovariance
- Effect of deterministic trends on autocovariance estimation
- Detrending procedures

**Exercise 2**: AR(1) Process Analysis
- Simulating AR(1) processes
- Maximum likelihood estimation
- Score function and Fisher information
- Whittle estimation
- Comparison of ML vs. Whittle estimators

**Exercise 4**: Real Data Analysis (EUR/NOK Exchange Rate)
- Time series visualization
- AR(1) parameter estimation
- Unit root testing (Dickey-Fuller type tests)
- Volatility modeling with stochastic volatility
- Forecasting comparison (random walk vs. ARIMA)

### Spectral Analysis (`pamphlet/`)

Examples demonstrating spectral analysis techniques:
- Spectral density estimation
- Periodogram analysis
- Frequency domain representations

## 📈 Key Topics Covered

1. **ARMA Processes**
   - Autoregressive (AR) models
   - Moving average (MA) models
   - ARMA model estimation and inference

2. **Stationary Processes**
   - Covariance stationarity
   - Autocovariance and autocorrelation functions
   - Spectral representation

3. **Spectral Analysis**
   - Periodogram
   - Spectral density estimation
   - Frequency domain analysis

4. **State-Space Models**
   - Kalman filtering
   - State estimation and prediction

5. **Real Data Applications**
   - Financial time series (exchange rates, stock returns)
   - Environmental data (temperature, oscillations)
   - Biological systems (population dynamics)

## Notes

- All R scripts use `set.seed(4060)` for reproducibility where applicable
- Generated plots are saved in respective `plots/` directories
- The course has 2 mandatory assignments that must be approved before the final exam

## Resources

- [Course Page](https://www.uio.no/studier/emner/matnat/math/STK4060/index-eng.html)
- Course textbook and exam papers are available in the `rsc/` directory

## License

This repository contains course materials and assignments. Please respect academic integrity policies.

---

**University of Oslo** | Department of Mathematics
