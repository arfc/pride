This file summarizes all the values in the .sql files and where they were calculated in the repo.

# MinCapacity

`MinCapacity` doesn't have any entries.
It should remain like that.

# MinActivity

* IMPSOL:
	* 2021: 6.88 GWh
	* 2022-2045: 24.69 GWh

These numbers are not explicitly calculated anywhere in the repo.
Where did these numbers come from?

# MaxCapacity

* IMPELC: 120 MWe. I [Roberto] believe this should be removed.
* TURBINE: 85 MWe. This is Abbott's max electrical capacity [1]. Is it specified anywhere in the repo? This is a valid constraint.
* NBINE: 300 MWe. I [Roberto] believe this should be removed.

# MaxActivity

`MaxActivity` doesn't have any entries.
It should remain like that.

# LifetimeTech

* this table should be analyzed together with `CostInvest`
* `IMPELC`, `IMPNATGAS`, `IMPGSL`, `IMPE85`, `IMPH2` are entries with no assocaited investment cost, so for simplicity, a lifetime of 1000 years is given to them.
* `IMPWIND`: wind turbine expected lifespan of 30 years. Where is this in the repo? References?
* `IMPSOL`: solar panel expected lifespan of 25 years. Where is this in the repo? References?
* `TURBINE`, `NBINE`, `UL`, `UH` are entries with no assocaited investment cost, so for simplicity, a lifetime of 1000 years is given to them.
* `GSLVCL`, `DSLVCL`, `E85VCL`: 25 years [2]
* `ELCVCL`, `H2VCL`: 8 years [2]
* `GEOT` is an entry with no assocaited investment cost, so for simplicity, a lifetime of 1000 years is given to it.
* `NUCLEAR`: 60 years (based on current LWRs)
* `ABBOT`: 40 years, it is longer to what the simulation lasts, it is a fair assumption
* `ELECTROL` has a lifetime of 1000 years, but it has an associated investment cost. This value should be updated.
* `GH`, `GC`, and `CHWS`, I have no idea, more research is needed here.


# LifetimeProcess

* entries for `ABBOTT`
* without that entry, the simulation fails.
* What does this table mean?


# LifetimeLoanTech

* entries for `UL`, `UH`, `ABBOTT`, `TURBINE`, `NBINE`, `NUCLEAR`.
* What do these entries mean?


# Demand

* UELC:

Taking the 2015 demand of 455.64 GWh from [grid_demand.ipynb](https://github.com/arfc/pride/blob/master/data_processing/grid_demand.ipynb), a 1% annual growth yields the following values:

```
2021: 483.67
2022: 488.51
2023: 493.39
2024: 498.33
2025: 503.31
2026: 508.34
2027: 513.43
2028: 518.56
2029: 523.75
2030: 528.98
2031: 534.27
2032: 539.62
2033: 545.01
2034: 550.46
2035: 555.97
2036: 561.53
2037: 567.14
2038: 572.81
2039: 578.54
2040: 584.33
2041: 590.17
2042: 596.07
2043: 602.03
2044: 608.05
2045: 614.13
2046: 620.28
2047: 626.48
2048: 632.74
2049: 639.07
2050: 645.46
```

These numbers are not explicitly calculated anywhere in the repo.


* USTM:

Taking the 2015 demand of 564.52 GWh from [steam_demand.ipynb](https://github.com/arfc/pride/blob/master/data_processing/steam_demand.ipynb), a 1% annual growth yields the following values:

```
2021: 599.25
2022: 605.24
2023: 611.29
2024: 617.41
2025: 623.58
2026: 629.82
2027: 636.12
2028: 642.48
2029: 648.9
2030: 655.39
2031: 661.94
2032: 668.56
2033: 675.25
2034: 682.0
2035: 688.82
2036: 695.71
2037: 702.67
2038: 709.69
2039: 716.79
2040: 723.96
2041: 731.2
2042: 738.51
2043: 745.9
2044: 753.35
2045: 760.89
2046: 768.5
2047: 776.18
2048: 783.94
2049: 791.78
2050: 799.7
```

These numbers are not explicitly calculated anywhere in the repo.


* UCWS:

Values are calculated in [cws_power.ipynb](https://github.com/arfc/pride/blob/master/data_processing/cws_power.ipynb).


* UVCL:

Based on (2019grossfueldata.csv)[https://github.com/arfc/pride/blob/master/fuel-analysis/2019grossfueldata.csv]:

unleaded = 408.713
diesel = 116.828
e85 = 25.727
uvcl = unleaded + diesel * 1.155 + e85 * 0.734 = 562.53 kilo-gallons.

These numbers are not explicitly calculated anywhere in the repo.

# References:

[1] ABBOTT Brochure. [link](https://fs.illinois.edu/docs/default-source/utilities-energy/abbottbrofinal.pdf?sfvrsn=90b1f9ea_4)

[2] Pride/data_processing/[fuel-analysis](https://github.com/arfc/pride/blob/master/data_processing/fuel-analysis.ipynb)
