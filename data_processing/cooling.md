
COP [1]:
* Heating: 3.74
* Cooling: 4.28

Energy output [1]:
* Heating: 149,738 MMBTU/year
* Cooling: 140,032 MMBTU/year
* Total electricity consumed: 22,698 MWh

System would have consumed [1]:
* Heating: 212,806 MMBTU
* Cooling: 10,970 MW(e)h

Capacity [?]:
* Cooling 10,000 tons = 7 MWe

# References

[1] https://info.ornl.gov/sites/publications/files/Pub71170.pdf


# Data analysis

* Heating:
149,738 MMBTU/year ~ 0.0438838759 x 10^6 MW(th)h/year = 43,884 MW(th)h/year
COP = 3.74
11,733 MW(e)h/year


* Cooling:
140,032 MMBTU/year ~ 0.0410393281 x 10^6 MW(th)h/year = 41,039 MW(th)h/year
COP = 4.28
9,588 MW(e)h/year


* Total = 22,698 MW(e)h/year
My total = 11,733 MW(e)h/year + 9,588 MW(e)h/year = 21,321 MW(e)h/year (my calculation) ~ 22,698 MW(e)h/year (from [1]])


# TechOutputSplit

* Heating: 11,733/21,321 = 0.55
* Cooling: 9,588/21,321 = 0.45


# Efficiency

* Heating: COP = 3.74
* Cooling: what it would have consumed/9,588 = 10,970 / 9,588 ~ 1.14


# Not sure about the following:

* Existing Capacity, right now it considers only the heating capacity
* CostInvest: cost/capacity, right now it considers only the heating capacity 
* CostFixed: cost/capacity, right now it considers only the heating capacity



# In PR

GEOT input is ELC.
GEOT has two outputs: USTM and ELC.
The outputs have different units.
Normally the capacity is calculated with the output capacity of the technology.
In this case, there would be two output capacities, one for heating (produces USTM) and one for cooling (produces ELC).
How should the capacity be calculated in this case?
Maybe I should divide GEOT into two technologies, one for heating and one for cooling.
What do you think @samdotson?
