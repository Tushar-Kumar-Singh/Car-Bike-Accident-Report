# Car & Bike Accident Dashboard (R Shiny + ggplot2)

## Overview
This project provides an **interactive dashboard** built using **R Shiny** and **ggplot2** to analyze vehicle accident data in the USA for 2023 and nearby years. It visualizes fatalities, crashes, and year-wise comparisons to identify patterns and trends.

## Features
- **Fatalities Trend** – View accident fatalities across years.
- **Crashes Trend** – Visualize approximate crash numbers.
- **Yearly Comparison** – Compare key statistics between 2022 and 2023.
- **Dataset View** – Explore cleaned dataset directly in the dashboard.
- **Interactive Filtering** – Select specific year/period to analyze.

## Project Structure
Car_Bike_Accident_Dashboard/
├── Report.R # Shiny dashboard application
├── Cleaning.R # Cleaning the datset
├── cleaned_accident_data.csv # Cleaned dataset for visualization
└── README.md # Project documentation


## Installation & Setup
### 1. Requirements
- **R (>= 4.0.0)**
- **RStudio** (optional but recommended)
- Required R packages:
```r
install.packages(c("shiny", "ggplot2", "dplyr", "readr", "tidyr"))
