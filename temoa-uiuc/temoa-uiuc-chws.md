# TEMOA's model of the CHWS

* ExistingCapacity [Done]
* Efficiency [Review]
* CostInvest: No Invest Cost because UofI already has it
* CostFixed: To be added in a future PR
* CapacityToActivity [Done]
* CapacityFactorTech [Done]
* Storage duration [Done]
* MinActivity

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

# Efficiency:

* Ideally, we should separate the efficiency of converting electricity into CHW and CHW to electricity.
* The former is probably slightly lower than the latter.
* As both are close to 1 anyway, we will consider an efficiency of 1.

# CapacityToActivity:

* Is this the total capacity?

# CapacityFactorTech:

* 0, 0.5, 1 in the winter, inter, and summer, respectively.
* Maybe we should separate ELEC -> CHWS Charge (CHWSC) -> CHW and CHW -> CHWS Discharge (CHWSD) -> ELEC

# Storage duration

* units: years.
* In our case, it is 12/24/8760 = 5.71e-5

# MinActivity

* need UIUC's CHWS real data.

# References

[1](https://theengineeringmindset.com/refrigeration-ton/)
[2](https://en.wikipedia.org/wiki/Coefficient_of_performance)
[3](https://fs.illinois.edu/docs/default-source/utilities-energy/campus-chilled-water-system.pdf?sfvrsn=c91bfbea_0)
[4] Andrepont, J. Current Trends in Thermal Storage. The Cool Solutions Company. International District Energy Association (IDEA) Campus Energy Conference. New Orleans, Louisiana. February 27, 2019.
