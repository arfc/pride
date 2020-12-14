# Data

This folder contains the following data:
* mtd-fuel-consumption.txt: MTD fuel consumption raw data for every day from July 1st, 2018, to June 30th, 2019. The original file
* mtd.csv: MTD fuel consumption processed data.
* uiuc-fuel-consumption.txt: UIUC fuel consumption raw data for every day from January 1st, 2019, to December 31st, 2019.
* uiuc.csv: UIUC fuel consumption processed data.

# Analysis

The notebook microR.ipynb:
* processes UIUC and MTD's data.
* calculates CO2 savings from replacing UIUC and MTD's fleets by FCEVs.
* estimates different microreactors hydrogen production rates to meet transportation hydrogen demand.

# Temoa's model

Hydrogen cost:
* $13.11/kg [1](https://cafcp.org/content/cost-refill): 2019 price of hydrogen in Californian re-fuelling stations.
* $6/kg [2](https://www.powermag.com/how-much-will-hydrogen-based-power-cost/): hydrogen cost from electrolysis in 2020 (region not specified).
* $4/kg [3](https://www.energy.gov/sites/prod/files/2017/11/f46/HPTT%20Roadmap%20FY17%20Final_Nov%202017.pdf): DOE's target.

EVs capital investment:
* $58,000[1](https://theicct.org/sites/default/files/publications/EV_cost_2020_2030_20190401.pdf): 2018 Sedan, BEV-250 (Battery Electric Vehicles w/ 250-mile range).
* $83,000/vehicle [1](https://theicct.org/sites/default/files/publications/EV_cost_2020_2030_20190401.pdf): 2018 SUV, BEV-250.

Ave: $70,500/vehicle

FCEVs capital investment:
* $57,000/vehicle [1](https://www.hydrogen.energy.gov/pdfs/progress17/v_e_5_james_2017.pdf): 2017 Toyota Mirai, retail price.
* $80,000/vehicle [2](https://www.forbes.com/sites/alanohnsman/2020/06/29/hydrogen-truckmaker-nikola-opens-badger-pickup-reservationsahead-of-production-plans/?sh=259f195332ba): Nikola Motor pickup truck.

Ave: $68,000/vehicle
