# GIAP Reports

This folder contains the code to create the GIAP reports for NYU NICHE. 

## Introduction

NICHE (Nurses Improving Care for Healthsystem Elders) conducts the GIAP (Geriatric Institutional Assessment Profile) which was initiated in the 1990’s to quantify staff knowledge, attitudes and perceptions in the care of older adult patients at NICHE designated acute care sites.

Skilled nursing facilities that use the LTC GIAP will be able to assess baseline data, trending over time, and comparison to peer sites. The development of the new assessment tool involved extensive research and consultation with long term care facilities and subject matter experts.

Through the years we have iterated through various versions of GIAP reports. `\Pilot` marked the beginning of Version 2 with Tanmay Gupta and `\Cohort 5` marked the start of Version 3 of GIAP reports.

## Repo Structure

The project is mostly written in R and has a few elements of HTML and Markdown for aesthetic tuning. 

This repo contains a folder for each Cohort that the GIAP project has been active. Each folder contains `generate_report.R` that should be run to generate the reports. They use data in the `\data` folder and save the reports in `\report` folder. Extra features such as pictures and tables will be saved in corresponding folders `pics` and `tables`. 

## Acknowledgments

The project is headed by Dr Mattia Gilmartin who is the Director at NICHE and Tanmay Gupta, who was studying at NYU in 2019-2020. Starting with the pilot, the program has really developed a lot in just a year. Conducting almost 3 surveys every year - winter, summer, and fall - we have delivered 130 reports and surveyed thousands of nurses. 


