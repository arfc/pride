## Scenario 11: Addition of fixed costs
by Olek Yardas

Fixed costs for non-automobile technologies came from Report SL-014940, a capital cost study by Sargent & Lundy commissioned by USEIA. Fixed costs for automobile technologies comes from averaging MSRP data for cars from fueleconomy.gov.

### General Assumptions for fixed costs for each technology

#### Capital costs
Capital costs for a given technology are divided into owner's costs, and engineering, procurenent, and construction (EPC) contractor costs. Capitcal costs account for all costs incurred during construction of the power plant before coming online.
The S&L report makes the following assumptions for the capital costs:
 - The power plant developer/owner hires an EPC contractor for construction.
 - EPC contractor cost includes procurement of equipment, materials, and all construction labor.
 - The owner costs includes project development, permitting, legal, outside-the-fence-line costs (electrical/gas interconnection), contingency, etc
 - Electrical interconnecction does not require substation upgrades.

Locational and environmental adjustment factors are in the appendices of the paper.

#### Operating and maintenance costs.
Fixec O&M costs include routine labor, materials and contract services, and administrative and general expenses. For solar and wind all O&M costs are treated as fixed costs.

#### Electrolysis plant (ELECTROL)
The capital investment cost for electrolysis cells comes from the 2018 paper "The investment cost of electrolysis - A comparison of cost studies from the past 30 years". In this paper, the estimated investment cost of alkaline electrolyzers for the future (2030) is between 787 and 906 euros/kW output. According to the "Technology Roadmap Hydrogen and Fuel Cells", the efficienty of alkaline electrolyser cells is between 65 and 82%. The average of these costs is 846.5 euros/kW output. In USD this is $1030.19 $/kW

The fixed cost is much trickier to determine, and I have not found a good estimate for this yet.


#### Nuclear power plant (NUCLEAR)
#####         Sources:
#####         https://www.eia.gov/outlooks/aeo/assumptions/pdf/table_8.2.pdf

In lieu of good data on operating and variable cost of small modular reactors, we will use cost estimates for advanced nuclear technology.

This case uses two Westinghouse AP1000 reactors as a model plant.
Fixed O&M costs come from those listed at the top of this document.

The fixed O&M cost for nuclear from the S&L report is 121.64 $/kW annually. This is comparable to the value of 121.13 $/kW annually for advanced nuclear in the Cost and Performance Charactersitics of New Generating Technologies tables from the 2020 EIA Annual Energy Outlook.

The variable O&M cost for nuclear from the S&L report 2.37 $/MWh. This is comparable to the value of 2.36 $/MWh for variable cost for advanced nuclear in the Cost and Performance Charactersitics of New Generating Technologies tables from the 2020 EIA Annual Energy Outlook.



#### Wind power (IMPWIND)
##### Source: https://icap.sustainability.illinois.edu/project/wind-power-purchase-agreement-ppa
#####         https://www.eia.gov/outlooks/aeo/assumptions/pdf/table_8.2.pdf

This case is a 200MW capacity onshore wind farm located in the Great Plains region. Land is abundant and suitable for turbine siting.

Assume 71 turbines with nominal rating of 2.8MW, 125-meter rotor diameter, 90-meter hub height.

Fixed O&M cost estimates assume full-service arrangement wiht O&M contractor that provides labor, management, parts replacement, collection system, and substation. The estimate does not include land lease royalties, property taxes, or insurance.

The University of Illinois has a Power Purchase Agreement with Rail Splitter Wind Farm. The Rail Splitter Wind Farm is a 100.5 MW wind farm consisting of 67 1.5MW wind turbines, and it comparable and consistent with the S&L case. 

According to the PPA Factsheet, the University will purchagse 8.6% of the wind farm's annual generation, estimated to be 25,000 MWh, over 10 years. Because the University is not a maintainer of the wind farm, it has no fixed costs associated with its operation and maintenance. 

Fixed O&M cost estimates assume full-service arrangement wiht O&M contractor that provides labor, management, parts replacement, collection system, and substation. The estimate does not include land lease royalties, property taxes, or insurance.

The fixed O&M cost for the S&L wind farm case is 26.34 $/kW annually. This is comparable to the value of 26.22 $/kW for fixed operating cost of onshore wind power in the Cost and Performance Charactersitics of New Generating Technologies tables from the 2020 EIA Annual Energy Outlook.

The variable O&M costs for renwable wind is generally given to be 0.00 $/MWh due to renewable generation consuming a negligible amount of resources.


#### Solar plant (IMPSOLAR)
##### Sources: https://icap.sustainability.illinois.edu/project/solar-farm-10
#####          https://fs.illinois.edu/services/utilities-energy/production/solar-farms
#####          https://www.eia.gov/outlooks/aeo/assumptions/pdf/table_8.2.pdf

This scenario details a 150 MW AC solar PV facility w/ single axis tracking, and uses 195 MW DC of 1500 V monocrystalline PERC modules with independent row trackers that are placed in a north south orientation with east west tracking.
Facility uses 150MW AC of central inverters.

The University of Illinois hired Phoenix Solar South Farms LLC to design, build, operate, and maintain Solar Farm 1.0, a 5.87 MW DC fixed solar array. Solar Far, 1.0 has been operating since late 2015. The University buys all the electricity generated by Solar Farm 1.0 under a 10 year PPA, along with a 10-year land lease agreement of $1 per year. Solar Farm 1.0

The University has recently hired Sol Systems LLC to design, build, operate, and maintain Solar Farm 2.0, a 12.32 MW DC single-axis tracking bifacial solar panel array. Solar Farm 2.0 will begn operation this year. The University will purchase all energy generated by Solar Farm 2.0 under a 20 year PPA.
Single axis tracking requires large land useage.

The scenario detailed in the S&L report is mostly technologcally consistent with Solar Farm 2.0, however it is a much larger plant. The scenario is not consistent with Solar Farm 1.0.

Fixed O&M cost estimate includes preventative and unscheduled maintenance, module cleaing, inverter maintenance reserve, and land lease.

The fixed O&M cost from the S&L report for this scenario is 15.25 $/kW annually. This is comparable to the value of 15.19 $/kW annually for tracking solar photovoltaic in the Cost and Performance Charactersitics of New Generating Technologies tables from the 2020 EIA Annual Energy Outlook.

The variable O&M costs for renwable solar is generally given to be 0.00 $/MWh due to renewable generation consuming a negligible amount of resources.

#### Automobiles
##### Sources: fueleconomy.gov

The fixed cost for automobile technology is based on paying off the principal cost of the vehicle over the vehicle's lifetime. This currently does not account for interest rate on a car loan.

I obtained the principal costs for diesel, electric, and E85 vehicles by averaging MSRP values from fueleconomy.gov. The code for doing this is in data_processing/automobile_data_scraping.ipynb

There are very few hydrogen vehicles available on the market right now. Obtaining values for these is an ongoing process
