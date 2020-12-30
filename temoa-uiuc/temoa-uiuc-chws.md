# TEMOA's model of the CHWS

* ExistingCapacity [Done]
* Efficiency [Review]
* CostInvest: [Done]
* CostFixed: To be added in a future PR
* CapacityToActivity [Done]
* CapacityFactorTech [Done]
* Storage duration [Done]
* MinActivity [To do]

# ExistingCapacity

* 1 ton of chilled water ~ 3.5 kWh [1]
* COP ~ 5 [2]
* tons to kg ~ 1000
* [tons]/(1000 * 5) * 3.5 = [MWe]
* for example: 52,000 tons yield 36 MW
* UIUC: 37,500 tons
* UIUC's total capacity: 6.5e6 millon-gallon ~ 24,600 tons
* capacity: 37,500 tons
* time to discharge: 39.4 min
* electrical-power: 37,500 tons/5e3 * 3.5 = 26.2 MW
* total electrical-capacity: 26.2 MW * 39.4 min/60 min * 1h = 17.2 MWh

# Efficiency

* Ideally, we should separate the efficiency of converting electricity into CHW and CHW to electricity.
* for the moment we will consider an efficiency of 1.

# CostInvest

* Average installed capital cost: $240/kW [4]

# CapacityToActivity

* Capacity * 8760 h = 229.5 GWh

# CapacityFactorTech

* 0, 0.5, 1 in the winter, inter, and summer, respectively.
* Maybe we should separate ELEC -> CHWS Charge (CHWSC) -> CHW and CHW -> CHWS Discharge (CHWSD) -> ELEC

# Storage duration

* units: years.
* In our case, it is 2/3/8760 = 7.61e-5

# MinActivity

* MaxCapacity = ExistingCapacity
* MaxActivity ?
* needs UIUC's CHWS real data
* guess: it works at half capacity on average: 26.2 * 0.5 * 8760 = 114.7 GWh
(kinda informed guess from looking at figure in [6])

* about 80 GWh produced chilled water (based on FY14 numbers [8])

# MODEL c

* emissions ?
* CostVariable: guess 0.07

# References

[1](https://theengineeringmindset.com/refrigeration-ton/)
[2](https://en.wikipedia.org/wiki/Coefficient_of_performance)
[3](https://fs.illinois.edu/docs/default-source/utilities-energy/campus-chilled-water-system.pdf?sfvrsn=c91bfbea_0)
[4] Andrepont, J. Current Trends in Thermal Storage. The Cool Solutions Company. International District Energy Association (IDEA) Campus Energy Conference. New Orleans, Louisiana. February 27, 2019.

# Other references

[5](https://fs.illinois.edu/services/utilities-energy/production)
[6](https://www.districtenergy.org/HigherLogic/System/DownloadDocumentFile.ashx?DocumentFileKey=4822a99e-cbcf-734b-39ba-53f57ff94f07&forceDialog=0)
[7](https://www.news-gazette.com/news/ui-asks-employees-on-campus-to-cool-it-with-electricity-use/article_d23297d3-14bf-58d1-b781-205bf383d36d.html)
[8] ICAP 2015 (https://icap.sustainability.illinois.edu/files/project/2634/2015iCAPweb.pdf)
