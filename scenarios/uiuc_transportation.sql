BEGIN TRANSACTION;


/*
-------------------------------------------------------
Tables in this section correspond to Sets
-------------------------------------------------------
*/

-- User-defined flags to split set elements into proper subsets
CREATE TABLE time_period_labels (
  t_period_labels text primary key,
  t_period_labels_desc text);
INSERT INTO "time_period_labels" VALUES('e', 'existing vintages');
INSERT INTO "time_period_labels" VALUES('f', 'future');

CREATE TABLE technology_labels (
  tech_labels text primary key,
  tech_labels_desc text);
INSERT INTO "technology_labels" VALUES('r', 'resource technology');
INSERT INTO "technology_labels" VALUES('p', 'production technology');
INSERT INTO "technology_labels" VALUES('pb', 'baseload production technology');
INSERT INTO "technology_labels" VALUES('ps', 'storage production technology');

CREATE TABLE commodity_labels (
  comm_labels text primary key,
  comm_labels_desc text);
INSERT INTO "commodity_labels" VALUES('p', 'physical commodity');
INSERT INTO "commodity_labels" VALUES('e', 'emissions commodity');
INSERT INTO "commodity_labels" VALUES('d', 'demand commodity');

CREATE TABLE sector_labels (
  sector text primary key);
INSERT INTO "sector_labels" VALUES('supply');
INSERT INTO "sector_labels" VALUES('electric');
INSERT INTO "sector_labels" VALUES('transport');
INSERT INTO "sector_labels" VALUES('commercial');
INSERT INTO "sector_labels" VALUES('university');
INSERT INTO "sector_labels" VALUES('industrial');

--Tables below correspond to Temoa sets
CREATE TABLE time_periods (
  t_periods integer primary key,
  flag text,
  FOREIGN KEY(flag) REFERENCES time_period_labels(t_period_labels));
-- INSERT INTO "time_periods" VALUES(2000, 'e');
INSERT INTO "time_periods" VALUES(2016, 'e');
INSERT INTO "time_periods" VALUES(2020, 'e');
INSERT INTO "time_periods" VALUES(2021, 'f');
INSERT INTO "time_periods" VALUES(2022, 'f');
INSERT INTO "time_periods" VALUES(2023, 'f');
INSERT INTO "time_periods" VALUES(2024, 'f');
INSERT INTO "time_periods" VALUES(2025, 'f');
INSERT INTO "time_periods" VALUES(2026, 'f');
INSERT INTO "time_periods" VALUES(2027, 'f');
INSERT INTO "time_periods" VALUES(2028, 'f');
INSERT INTO "time_periods" VALUES(2029, 'f');
INSERT INTO "time_periods" VALUES(2030, 'f');
INSERT INTO "time_periods" VALUES(2031, 'f');
-- INSERT INTO "time_periods" VALUES(, '');

CREATE TABLE time_season (
  t_season text primary key );
INSERT INTO "time_season" VALUES('inter');
INSERT INTO "time_season" VALUES('summer');
INSERT INTO "time_season" VALUES('winter');

CREATE TABLE time_of_day (
  t_day text primary key );
INSERT INTO "time_of_day" VALUES('day');
INSERT INTO "time_of_day" VALUES('night');

CREATE TABLE technologies (
  tech text primary key,
  flag text,
  sector text,
  tech_desc text,
  tech_category text,
  FOREIGN KEY(flag) REFERENCES technology_labels(tech_labels),
  FOREIGN KEY(sector) REFERENCES sector_labels(sector));
INSERT INTO "technologies" VALUES('IMPDSL','r','supply', 'imported unleaded gas','unleaded gas');
INSERT INTO "technologies" VALUES('IMPGSL','r','supply', 'imported unleaded gas','unleaded gas');
INSERT INTO "technologies" VALUES('UTDSL', 'p', 'transport', 'diesel transportation', 'transportation');
INSERT INTO "technologies" VALUES('UTGSL', 'p', 'transport', 'unleaded gas transportation', 'transportation');

--can include a column that designates the commodity type (physical, emissions, demand)
CREATE TABLE commodities (
  comm_name text primary key,
  flag text,
  comm_desc text,
  FOREIGN KEY(flag) REFERENCES commodity_labels(comm_labels));
INSERT INTO "commodities" VALUES('co2eq','e','co2 equivalent');
INSERT INTO "commodities" VALUES('ethos','p','# dummy commodity');
INSERT INTO "commodities" VALUES('GSL', 'p', 'unleaded gas');
INSERT INTO "commodities" VALUES('DSL', 'p', 'unleaded gas');
INSERT INTO "commodities" VALUES('UTRX','d','university transportation');
-- INSERT INTO "commodities" VALUES('','','');

/*
-------------------------------------------------------
Tables in this section correspond to Parameters
-------------------------------------------------------
*/



CREATE TABLE SegFrac (
   season_name text,
   time_of_day_name text,
   segfrac real check (segfrac>=0 AND segfrac<=1),
   segfrac_notes text,
   PRIMARY KEY(season_name, time_of_day_name), --here's where I define primary key as a combo of columns
   FOREIGN KEY(season_name) REFERENCES time_season(t_season),
   FOREIGN KEY(time_of_day_name) REFERENCES time_of_day(t_day) );
INSERT INTO "SegFrac" VALUES('inter','day',0.1667,'# I-D');
INSERT INTO "SegFrac" VALUES('inter','night',0.0833,'# I-N');
INSERT INTO "SegFrac" VALUES('summer','day',0.1667,'# S-D');
INSERT INTO "SegFrac" VALUES('summer','night',0.0833,'# S-N');
INSERT INTO "SegFrac" VALUES('winter','day',0.3333,'# W-D');
INSERT INTO "SegFrac" VALUES('winter','night',0.1667,'# W-N');

CREATE TABLE DemandSpecificDistribution (
   season_name text,
   time_of_day_name text,
   demand_name text,
   dds real check (dds>=0 AND dds<=1),
   dds_notes text,
   PRIMARY KEY(season_name, time_of_day_name, demand_name),
   FOREIGN KEY(season_name) REFERENCES time_season(t_season),
   FOREIGN KEY(time_of_day_name) REFERENCES time_of_day(t_day),
   FOREIGN KEY(demand_name) REFERENCES commodities(comm_name) );
   -- There is no reason for these numbers right now... Will be updated later.


CREATE TABLE CapacityToActivity (
   tech text primary key,
   c2a real,
   c2a_notes,
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "CapacityToActivity" VALUES('IMPGSL', 1, 'gallons to gallons');
INSERT INTO "CapacityToActivity" VALUES('UTGSL', 26.3, 'miles driven');
INSERT INTO "CapacityToActivity" VALUES('IMPDSL', 1, 'gallons to gallons');
INSERT INTO "CapacityToActivity" VALUES('UTDSL', 14.3, 'miles driven');


CREATE TABLE GlobalDiscountRate (
   rate real );
INSERT INTO "GlobalDiscountRate" VALUES(0.05);


CREATE TABLE DiscountRate (
   tech text,
   vintage integer,
   tech_rate real,
   tech_rate_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods));


CREATE TABLE EmissionActivity  (
   emis_comm text,
   input_comm text,
   tech text,
   vintage integer,
   output_comm text,
   emis_act real,
   emis_act_units text,
   emis_act_notes text,
   PRIMARY KEY(emis_comm, input_comm, tech, vintage, output_comm),
   FOREIGN KEY(emis_comm) REFERENCES commodities(comm_name),
   FOREIGN KEY(input_comm) REFERENCES commodities(comm_name),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods),
   FOREIGN KEY(output_comm) REFERENCES commodities(comm_name) );
-- INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2020,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2021,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2022,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2023,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2024,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2025,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2026,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2027,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2028,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2029,'UTRX',0.000338,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GSL','UTGSL', 2030,'UTRX',0.000338,'tCO2/mile','');

INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2021,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2022,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2023,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2024,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2025,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2026,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2027,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2028,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2029,'UTRX',0.001,'tCO2/mile','');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'DSL','UTDSL', 2030,'UTRX',0.001,'tCO2/mile','');



CREATE TABLE EmissionLimit  (
   periods integer,
   emis_comm text,
   emis_limit real,
   emis_limit_units text,
   emis_limit_notes text,
   PRIMARY KEY(periods, emis_comm),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(emis_comm) REFERENCES commodities(comm_name) );
INSERT INTO "EmissionLimit" VALUES (2021, 'co2eq', 337, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2022, 'co2eq', 329, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2023, 'co2eq', 317, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2024, 'co2eq', 304, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2025, 'co2eq', 297, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2026, 'co2eq', 290, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2027, 'co2eq', 282, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2028, 'co2eq', 268, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2029, 'co2eq', 256, 'tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2030, 'co2eq', 247, 'tCO2', 'projection from iCAP');

-- There must be a demand for every year in "future," listed in time_periods
-- Should not include years listed as "existing."
CREATE TABLE Demand (
   periods integer,
   demand_comm text,
   demand real,
   demand_units text,
   demand_notes text,
   PRIMARY KEY(periods, demand_comm),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(demand_comm) REFERENCES commodities(comm_name) );
INSERT INTO "Demand" VALUES(2021, 'UTRX', 2418, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2022, 'UTRX', 2456, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2023, 'UTRX', 2480, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2024, 'UTRX', 2502, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2025, 'UTRX', 2530, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2026, 'UTRX', 2560, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2027, 'UTRX', 2595, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2028, 'UTRX', 2621, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2029, 'UTRX', 2647, 'thousand miles driven', 'from FS data');
INSERT INTO "Demand" VALUES(2030, 'UTRX', 2683, 'thousand miles driven', 'from FS data');

-- TechInputSplit and TechOutputSplit should only include "future" time_periods.
CREATE TABLE TechInputSplit (
   periods integer,
   input_comm text,
   tech text,
   ti_split real,
   ti_split_notes text,
   PRIMARY KEY(periods, input_comm, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(input_comm) REFERENCES commodities(comm_name),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );


CREATE TABLE TechOutputSplit (
   periods integer,
   tech text,
   output_comm text,
   to_split real,
   to_split_notes text,
   PRIMARY KEY(periods, tech, output_comm),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(output_comm) REFERENCES commodities(comm_name) );


-- possibly need a min capacity?
CREATE TABLE MinCapacity (
   periods integer,
   tech text,
   mincap real,
   mincap_units text,
   mincap_notes text,
   PRIMARY KEY(periods, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );

CREATE TABLE MaxCapacity (
   periods integer,
   tech text,
   maxcap real,
   maxcap_units text,
   maxcap_notes text,
   PRIMARY KEY(periods, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );


CREATE TABLE MinActivity (
   periods integer,
   tech text,
   minact real,
   minact_units text,
   minact_notes text,
   PRIMARY KEY(periods, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "MinActivity" VALUES(2030, 'UTDSL', 300, 'miles driven', '');

CREATE TABLE MaxActivity (
   periods integer,
   tech text,
   maxact real,
   maxact_units text,
   maxact_notes text,
   PRIMARY KEY(periods, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );


CREATE TABLE GrowthRateMax (
   tech text,
   growthrate_max real,
   growthrate_max_notes text,
   FOREIGN KEY(tech) REFERENCES technologies(tech) );


CREATE TABLE GrowthRateSeed (
   tech text,
   growthrate_seed real,
   growthrate_seed_units text,
   growthrate_seed_notes text,
   FOREIGN KEY(tech) REFERENCES technologies(tech) );


CREATE TABLE  LifetimeTech (
   tech text,
   life real,
   life_notes text,
   PRIMARY KEY(tech),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
-- INSERT INTO "LifetimeTech" VALUES('IMPURN',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPGSL',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPDSL',1000,'');


CREATE TABLE LifetimeProcess (
   tech text,
   vintage integer,
   life_process real,
   life_process_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
-- INSERT INTO "LifetimeProcess" VALUES('UTGSL',2020,60,'#forexistingcap');
-- INSERT INTO "LifetimeProcess" VALUES('UTDSL',2020,60,'#forexistingcap');


CREATE TABLE LifetimeLoanTech (
   tech text,
   loan real,
   loan_notes text,
   PRIMARY KEY(tech),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
-- INSERT INTO "LifetimeLoanTech" VALUES('UTGSL',40,'');

CREATE TABLE CapacityFactorTech (
   season_name text,
   time_of_day_name text,
   tech text,
   cf_tech real check (cf_tech >=0 AND cf_tech <=1),
   cf_tech_notes text,
   PRIMARY KEY(season_name, time_of_day_name, tech),
   FOREIGN KEY(season_name) REFERENCES time_season(t_season),
   FOREIGN KEY(time_of_day_name) REFERENCES time_of_day(t_day),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );

CREATE TABLE CapacityFactorProcess (
   season_name text,
   time_of_day_name text,
   tech text,
   vintage integer,
   cf_process real check (cf_process >=0 AND cf_process <=1),
   cf_process_notes text,
   PRIMARY KEY(season_name, time_of_day_name, tech, vintage),
   FOREIGN KEY(season_name) REFERENCES time_season(t_season),
   FOREIGN KEY(time_of_day_name) REFERENCES time_of_day(t_day),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );

-- If a Tech has existing capacity, it should have an efficiency for that year
CREATE TABLE Efficiency (
  input_comm text,
  tech text,
  vintage integer,
  output_comm text,
  efficiency real check (efficiency>0),
  eff_notes text,
  PRIMARY KEY(input_comm, tech, vintage, output_comm),
  FOREIGN KEY(input_comm) REFERENCES commodities(comm_name),
  FOREIGN KEY(tech) REFERENCES technologies(tech),
  FOREIGN KEY(vintage) REFERENCES time_periods(t_periods),
  FOREIGN KEY(output_comm) REFERENCES commodities(comm_name) );

-- Define transportation here
-- INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2020, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2021, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2022, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2023, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2024, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2025, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2026, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2027, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2028, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2029, 'GSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPGSL', 2030, 'GSL', 1.00,'direct from cap to activity');

-- INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2020, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2021, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2022, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2023, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2024, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2025, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2026, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2027, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2028, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2029, 'DSL', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPDSL', 2030, 'DSL', 1.00,'direct from cap to activity');

-- INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2020, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2021, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2022, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2023, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2024, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2025, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2026, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2027, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2028, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2029, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('GSL', 'UTGSL', 2030, 'UTRX', 1.00,'direct from cap to activity');

-- INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2020, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2021, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2022, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2023, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2024, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2025, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2026, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2027, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2028, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2029, 'UTRX', 1.00,'direct from cap to activity');
INSERT INTO "Efficiency" VALUES('DSL', 'UTDSL', 2030, 'UTRX', 1.00,'direct from cap to activity');

CREATE TABLE ExistingCapacity (
   tech text,
   vintage integer,
   exist_cap real,
   exist_cap_units text,
   exist_cap_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
-- INSERT INTO "ExistingCapacity" VALUES('UTGSL', 2020, 200, 'number of cars', 'if 100% to electricity');
-- INSERT INTO "ExistingCapacity" VALUES('UTDSL', 2020, 70, 'number of cars', 'if 100% to electricity');


 CREATE TABLE CostInvest (
   tech text,
   vintage integer,
   cost_invest real,
   cost_invest_units text,
   cost_invest_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "CostInvest" VALUES('UTGSL', 2021, 0.03, 'M$/Car', 'cost of buying a new vehicle');
INSERT INTO "CostInvest" VALUES('UTDSL', 2021, 0.04, 'M$/Car', 'cost of buying a new vehicle');

  CREATE TABLE CostFixed (
   periods integer NOT NULL,
   tech text NOT NULL,
   vintage integer NOT NULL,
   cost_fixed real,
   cost_fixed_units text,
   cost_fixed_notes text,
   PRIMARY KEY(periods, tech, vintage),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );


-- Only add cost for each vintage...
 CREATE TABLE CostVariable (
   periods integer NOT NULL,
   tech text NOT NULL,
   vintage integer NOT NULL,
   cost_variable real,
   cost_variable_units text,
   cost_variable_notes text,
   PRIMARY KEY(periods, tech, vintage),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "CostVariable" VALUES(2021, 'UTGSL', 2021, 2.25, '$/Gallon', 'current Illinois prices');
INSERT INTO "CostVariable" VALUES(2021, 'UTDSL', 2021, 1.25, '$/Gallon', 'current Illinois prices');

/*
-------------------------------------------------------
Tables in this section store model outputs
-------------------------------------------------------
*/


CREATE TABLE Output_VFlow_Out (
   scenario text,
   sector text,
   t_periods integer,
   t_season text,
   t_day text,
   input_comm text,
   tech text,
   vintage integer,
   output_comm text,
   vflow_out real,
   PRIMARY KEY(scenario, t_periods, t_season, t_day, input_comm, tech, vintage, output_comm),
   FOREIGN KEY(sector) REFERENCES sector_labels(sector),
   FOREIGN KEY(t_periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(t_season) REFERENCES time_periods(t_periods),
   FOREIGN KEY(t_day) REFERENCES time_of_day(t_day),
   FOREIGN KEY(input_comm) REFERENCES commodities(comm_name),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods),
   FOREIGN KEY(output_comm) REFERENCES commodities(comm_name));



CREATE TABLE Output_VFlow_In (
   scenario text,
   sector text,
   t_periods integer,
   t_season text,
   t_day text,
   input_comm text,
   tech text,
   vintage integer,
   output_comm text,
   vflow_in real,
   PRIMARY KEY(scenario, t_periods, t_season, t_day, input_comm, tech, vintage, output_comm),
   FOREIGN KEY(sector) REFERENCES sector_labels(sector),
   FOREIGN KEY(t_periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(t_season) REFERENCES time_periods(t_periods),
   FOREIGN KEY(t_day) REFERENCES time_of_day(t_day),
   FOREIGN KEY(input_comm) REFERENCES commodities(comm_name),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods),
   FOREIGN KEY(output_comm) REFERENCES commodities(comm_name));


CREATE TABLE Output_V_Capacity (
   scenario text,
   sector text,
   tech text,
   vintage integer,
   capacity real,
   PRIMARY KEY(scenario, tech, vintage),
   FOREIGN KEY(sector) REFERENCES sector_labels(sector),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods));



CREATE TABLE Output_CapacityByPeriodAndTech (
   scenario text,
   sector text,
   t_periods integer,
   tech text,
   capacity real,
   PRIMARY KEY(scenario, t_periods, tech),
   FOREIGN KEY(sector) REFERENCES sector_labels(sector),
   FOREIGN KEY(t_periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech));



CREATE TABLE Output_Emissions (
   scenario text,
   sector text,
   t_periods integer,
   emissions_comm text,
   tech text,
   vintage integer,
   emissions real,
   PRIMARY KEY(scenario, t_periods, emissions_comm, tech, vintage),
   FOREIGN KEY(sector) REFERENCES sector_labels(sector),
   FOREIGN KEY(emissions_comm) REFERENCES EmissionActivity(emis_comm),
   FOREIGN KEY(t_periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech)
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods));

CREATE TABLE Output_Costs (
   scenario text,
   sector text,
   output_name text,
   tech text,
   vintage integer,
   output_cost real,
   PRIMARY KEY(scenario, output_name, tech, vintage),
   FOREIGN KEY(sector) REFERENCES sector_labels(sector),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods));

CREATE TABLE Output_Objective (
   scenario text,
   objective_name text,
   total_system_cost real );


COMMIT;
