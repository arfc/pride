# Lit review

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

A district geothermal system would reduce the use of fossil fuels on campus, but would increase the campus average demand for electricity by about 18 MW over our current average demand of about 52 MW.

2025: similar system to the one at Ball State University
2035: equal size

Each installation will provide 80,000 MWh/year of thermal energy, by using 20,000 MWh/year of electricity (COP of 4).
The system will provide the chilled water needs.
The electricity demand (direct + geothermal) is 290,000 MWh/year.
Biomass burners will cover the remaining 90,000 MWh heating needs.

2015: Heat Demand: 500,000 MWh/year


# Data

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


[1] ICAP 2020 https://icap.sustainability.illinois.edu/files/project/5293/iCAP-2020-FINAL-WEB.pdf
[2] F & S Master plan 2020 https://fs.illinois.edu/docs/default-source/utilities-energy/utilities-master-plan_.pdf?sfvrsn=16bbfbea_0
[3] ICAP 2015 https://icap.sustainability.illinois.edu/files/project/2634/2015iCAPweb.pdf
