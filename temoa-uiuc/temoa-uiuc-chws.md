Things to be modified to model the CHWS:

* ExistingCapacity
* Efficiency
* CostInvest -- no
* CostFixed -- yes ?
* CapacityToActivity
* CapacityFactorTech
* Storage duration

# Efficiency

* 1 ton of chilled water ~ 3.5 kWh [1]
* COP ~ 5 [2]
* tons to kg ~ 1000
* [tons]/(1000 * 5) * 3.5 = [MWe]
* for example: 52,000 tons yield 36 MW
* UIUC: 37,500 tons

# CapacityToActivity:

* UIUC's total capacity: 6.5e6 millon-gallon ~ 24,600 tons
* capacity: 37,500 tons
* time to discharge: 39.4 min
* electrical-capacity: 37,500 tons/5e3 * 3.5 = 26.2 MW

# References

[1](https://theengineeringmindset.com/refrigeration-ton/)
[2](https://en.wikipedia.org/wiki/Coefficient_of_performance)
[3](https://fs.illinois.edu/docs/default-source/utilities-energy/campus-chilled-water-system.pdf?sfvrsn=c91bfbea_0)
