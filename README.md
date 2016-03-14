---
title: "README.md"
author: "JS"
date: "14 March 2016"
output: html_document
---

#Info for run_analysis.R

There is only one script, run_analysis.R, which requires as input the directory in which the UCI data files are stored. 
The directory must contain a "training" directory and "test" directory with subject files within each. The output from this script
will be a data frame containing mean values for each measured variable that was a mean() or std() of the original time series
data. The script also prints the data frame to a text file named "run_analysis_output.txt"