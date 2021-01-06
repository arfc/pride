# Information collection

[1]

Two types on campus:
* shallow, horizontal ground loop systems
* closed-loop 40 450-foot deep vertical boreholes

Geothermal project installed on campus in FY20 that saves 2,839 MMBTU/year.
In the Campus Instructional Facility, building-scale geothermal project.


[2]

Add campus-wide geothermal enhanced heat recovery chiller plant.
Convert entire campus to hot water heating.

Heat recovery chillers (HRC) and Geothermal


[3]

Geothermal heat pumps: can produced chilled and hot water.

Ball state university: COP = 3.8 for heating and 2.9 for cooling.

A district geothermal system would reduce the use of fossil fuels on campus, but would increase the campus average demand for electricity by about 18 MW over our current average demand of about 52 MW.

2025: similar system to the one at Ball State University
2035: equal size

Each installation will provide 80,000 MWh/year of thermal energy, by using 20,000 MWh/year of electricity (COP of 4).
The system will provide the chilled water needs.
The electricity demand (direct + geothermal) is 290,000 MWh/year.
Biomass burners will cover the remaining 90,000 MWh heating needs.

2015: Heat Demand: 500,000 MWh/year


[4]

Largest project in the US in 2011.
Ball state system has 3600 boreholes.

* Phase 1: 1800, 400-ft. deep, 6-in. in diameter with double 1-in. loops.
* Phase 2: 1800, 500-ft. deep, 6-in. in diameter with single 1 ¼-in. loops.


[4]

3,600 boreholes, 400 to 500 feet deep. 
4 to 5 inches in diameter.
Phase 1: 1,800 boreholes.
Phase 2: 1,800 additional boreholes.
Pipe inserted into a borehole is joined with a U-shaped cross connector at the bottom of the hole, allowing water to circulate through the closed piping system.

The heat pump chillers through a compression cycle moves heat.
Heat can be either pulled from or sank into the ground.
The heat exchange will allow for the simultaneous production of cold water, 42 degree Fahrenheit, and hot water, 150 degrees Fahrenheit.


[5]

Comparison:

|                  | Fossil Fuel Boiler | Natural Gas Boiler | Ground Source Geothermal Heat Pump |
|------------------|--------------------|--------------------|------------------------------------|
| Capital cost     | High               | Low                | Highest                            |
| Maintenance cost | High               | Low                | Low                                |

* Heating Mode: COP = 3.4
* Cooling Mode: COP = 5.93

As of 2014:

1800 - 400 ft Bore Holes
1583 - 500 ft Bore Holes

Heating: 152 MMBTU/h = 0.4455 MW, 150 F
Cooling: 10,000 tons cooling, 42 F

Savings: 500,000 MMBTUs/year = 146,535 MWh/year

Total construction cost: 82.9 M$

Electrical needs increase: 110,000 MWh/year to 125,000 MWh/year and decreased to 120,000 MWh/year


# Cost

[6]

August 2015 to July 2016:
* Heating: 149,738 MMBtu
* Cooling: 140,032 MMBtu

Heating COP = 3.74 +/- 0.2
Cooling COP = 4.28 +/- 0.2

Total electricity consumed = 22,698 MWh
Total installed cost: 17.26 M$ ?

Ground heat exchanger cost $18.7/ft
Average cost in the Midwest ~ $12/ft (Battocletti and Glassley 2013)


Total installed cost: 12.4 M$ ?


[7]

Not much .. double check


[8]

Oregon Institute of Technology

~ 0.05 $/sqf/year




# References

[1] ICAP 2020 https://icap.sustainability.illinois.edu/files/project/5293/iCAP-2020-FINAL-WEB.pdf
[2] F & S Master plan 2020 https://fs.illinois.edu/docs/default-source/utilities-energy/utilities-master-plan_.pdf?sfvrsn=16bbfbea_0
[3] ICAP 2015 https://icap.sustainability.illinois.edu/files/project/2634/2015iCAPweb.pdf
[4] BSU https://www.bsu.edu/About/Geothermal/FAQ.aspx#whatis
[5] BSU Presentation
https://www.districtenergy.org/HigherLogic/System/DownloadDocumentFile.ashx?DocumentFileKey=b0f3ed01-7c78-e7bd-df18-f5a9213efec9&forceDialog=0
[6] https://info.ornl.gov/sites/publications/files/Pub71170.pdf
[7] Battocletti and Glassley 2013 https://www.osti.gov/servlets/purl/1186828
[8] https://www.nwf.org/-/media/PDFs/Campus-Ecology/Reports/Geothermal-Guide-FINAL-3-1-11.ashx

# Analysis of the data

* heat_demand = 500,000 MW(th)h/year ~ 57.1 MW(th)
cop = 4 [3]
electrical_demand = 125,000 MW(e)h/year = 14.3 MW(e)

* now:
2,839 MMBTU/year = 832 MW(th)h/year = 0.095 MW(th)
832 MW(th)h/year = 208 MW(e)h/year = 0.024 MW(e)

* 2025:
80,000 MW(th)h/year
20,000 MW(e)h/year = 2.28 MW(e)

* 2035:
160,000 MW(th)h/year
40,000 MW(e)h/year = 4.56 MW(e)


# TEMOA's model

* technology from ELC to USTM (similar to UH)
* Efficiency: USTM in MWth, COP = 4 [3]
* ExistingCapacity: 0.095 MW(th)
* MinActivity: 2020-2025: 0.832 GW(th), 2025-2030: 80 GW(th)
* CapacityToActivity = 8.76 thermal GWh

* CostInvest:
* CostFixed:


## MinActivity (maybe this should be MaxActivity ?)

INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'GEOT', 0.208, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2022, 'GEOT', 0.208, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2023, 'GEOT', 0.208, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2024, 'GEOT', 0.208, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2025, 'GEOT', 20, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2026, 'GEOT', 20, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2027, 'GEOT', 20, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2028, 'GEOT', 20, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2029, 'GEOT', 20, 'electric GWh','');
INSERT INTO "MinActivity" VALUES('uiuc', 2030, 'GEOT', 20, 'electric GWh','');
