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
INSERT INTO "time_periods" VALUES(2000, 'e');
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
INSERT INTO "technologies" VALUES('IMPWIND','r','electric', 'imported wind energy','electricity');
INSERT INTO "technologies" VALUES('IMPSOL','r','electric', 'imported solar energy','electricity');
INSERT INTO "technologies" VALUES('IMPELC','r','electric', 'imported electricity','MISO');
INSERT INTO "technologies" VALUES('IMPNATGAS','r','supply', 'imported natural gas','natural gas');
INSERT INTO "technologies" VALUES('ABBOTT','pb','industrial', 'natural gas power plant','steam');
INSERT INTO "technologies" VALUES('TURBINE', 'p', 'electric', 'turbine that converts steam to elc', 'electricity');
INSERT INTO "technologies" VALUES('UL', 'p', 'university', 'university lighting', 'electricity');
INSERT INTO "technologies" VALUES('UH', 'p', 'university', 'university heating', 'steam');
INSERT INTO "technologies" VALUES('NUCLEAR', 'pb', 'steam', 'micro nuclear power plant', 'electricity');
-- INSERT INTO "technologies" VALUES('CWS', 'ps', 'electric', 'chilled water storage', 'chilled water');
-- INSERT INTO "technologies" VALUES('', '', '', '', '');

--can include a column that designates the commodity type (physical, emissions, demand)
CREATE TABLE commodities (
  comm_name text primary key,
  flag text,
  comm_desc text,
  FOREIGN KEY(flag) REFERENCES commodity_labels(comm_labels));
INSERT INTO "commodities" VALUES('co2eq','e','co2 equivalent');
INSERT INTO "commodities" VALUES('ethos','p','# dummy commodity');
INSERT INTO "commodities" VALUES('GAS', 'p', 'natural gas');
INSERT INTO "commodities" VALUES('ELC', 'p', 'electricity');
INSERT INTO "commodities" VALUES('STM','p','steam');
INSERT INTO "commodities" VALUES('UELC', 'd', 'university electricity');
INSERT INTO "commodities" VALUES('USTM','d','university steam');
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
INSERT INTO "DemandSpecificDistribution" VALUES('inter','day','UELC',0.25,'');
INSERT INTO "DemandSpecificDistribution" VALUES('inter','night','UELC',0.24,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','day','UELC',0.112,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','night','UELC',0.108,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','day','UELC',0.148,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','night','UELC',0.142,'');

INSERT INTO "DemandSpecificDistribution" VALUES('inter','day','USTM',0.219,'');
INSERT INTO "DemandSpecificDistribution" VALUES('inter','night','USTM',0.218,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','day','USTM',0.19,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','night','USTM',0.189,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','day','USTM',0.092,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','night','USTM',0.092,'');


CREATE TABLE CapacityToActivity (
   tech text primary key,
   c2a real,
   c2a_notes,
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "CapacityToActivity" VALUES('ABBOTT',8.76, 'thermal GWh');
INSERT INTO "CapacityToActivity" VALUES('TURBINE', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('UL', 1, '');
INSERT INTO "CapacityToActivity" VALUES('UH', 1, '');
INSERT INTO "CapacityToActivity" VALUES('IMPELC', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('NUCLEAR', 8.76, 'thermal GWh');
-- INSERT INTO "CapacityToActivity" VALUES('CWS', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('IMPSOL', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('IMPWIND', 8.76, 'electric GWh');


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
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2000,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2020,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2021,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2022,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2023,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2024,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2025,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2026,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2027,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2028,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2029,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2030,'STM',0.192,'kilo-tCO2/MWth','from iCAP');
--
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2000,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2020,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2021,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2022,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2023,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2024,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2025,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2026,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2027,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2028,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2029,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'ethos','IMPELC', 2030,'ELC',0.825,'kilo-tCO2/MWe','from iCAP');

CREATE TABLE EmissionLimit  (
   periods integer,
   emis_comm text,
   emis_limit real,
   emis_limit_units text,
   emis_limit_notes text,
   PRIMARY KEY(periods, emis_comm),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(emis_comm) REFERENCES commodities(comm_name) );
INSERT INTO "EmissionLimit" VALUES (2021, 'co2eq', 391.031, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2022, 'co2eq', 379.500, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2023, 'co2eq', 367.968, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2024, 'co2eq', 356.437, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2025, 'co2eq', 344.906, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2026, 'co2eq', 331.110, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2027, 'co2eq', 317.314, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2028, 'co2eq', 303.517, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2029, 'co2eq', 289.721, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES (2030, 'co2eq', 275.925, 'kilo-tCO2', 'projection from iCAP');

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
INSERT INTO "Demand" VALUES(2021, 'UELC', 478.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2022, 'UELC', 482.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2023, 'UELC', 486.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2024, 'UELC', 490.8, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2025, 'UELC', 494.9, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2026, 'UELC', 499.0, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2027, 'UELC', 503.2, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2028, 'UELC', 507.5, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2029, 'UELC', 511.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2030, 'UELC', 516.1, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2021, 'USTM', 599.2, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2022, 'USTM', 605.2, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2023, 'USTM', 611.2, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2024, 'USTM', 617.4, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2025, 'USTM', 623.5, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2026, 'USTM', 629.8, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2027, 'USTM', 636.1, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2028, 'USTM', 642.4, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2029, 'USTM', 648.8, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2030, 'USTM', 655.3, 'thermal GWh', 'from 2015 eDNA data');




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
INSERT INTO "MaxCapacity" VALUES(2021, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2022, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2023, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2024, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2025, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2026, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2027, 'IMPWIND', 100.5, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2028, 'IMPWIND', 100.5, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2029, 'IMPWIND', 100.5, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES(2030, 'IMPWIND', 100.5, 'MWe', 'wind PPA, unless increased');

-- We are assuming that we can add 12.1 MWe capacity every 6 years.
-- This should be constrained because we can't add an arbitrary amount of solar
-- power.
INSERT INTO "MaxCapacity" VALUES(2021, 'IMPSOL', 4.68, 'MWe', 'after Solar Farm 2.0');
INSERT INTO "MaxCapacity" VALUES(2022, 'IMPSOL', 16.78, 'MWe', 'solar PPA');
INSERT INTO "MaxCapacity" VALUES(2023, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES(2024, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES(2025, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES(2026, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES(2027, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES(2028, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES(2029, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES(2030, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
--
INSERT INTO "MaxCapacity" VALUES(2021, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES(2022, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES(2023, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES(2024, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES(2025, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES(2026, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES(2027, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES(2028, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES(2029, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');

-- Abbott should be capped at its current capacity because we are trying to
-- retire part of its capacity
INSERT INTO "MaxCapacity" VALUES(2021, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2022, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2023, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2024, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2025, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2026, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2027, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2028, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2029, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2030, 'ABBOTT', 350, 'MWth', 'Max capacity of abbott');

INSERT INTO "MaxCapacity" VALUES(2021, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2022, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2023, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2024, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2025, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2026, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2027, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2028, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2029, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES(2030, 'NUCLEAR', 100, 'MWth', 'max smr capacity');


INSERT INTO "MaxCapacity" VALUES(2021, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2022, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2023, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2024, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2025, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2026, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2027, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2028, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2029, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');
INSERT INTO "MaxCapacity" VALUES(2030, 'TURBINE', 85, 'MWe', 'Max electric capacity of abbott');


CREATE TABLE MinActivity (
   periods integer,
   tech text,
   minact real,
   minact_units text,
   minact_notes text,
   PRIMARY KEY(periods, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "MinActivity" VALUES(2021, 'IMPSOL', 6.88, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2022, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2023, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2024, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2025, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2026, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2027, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2028, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2029, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2030, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');

-- until 2026 because that's when the PPA ends, then we can buy more if we choose.
INSERT INTO "MinActivity" VALUES(2021, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2022, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2023, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2024, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2025, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES(2026, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');

CREATE TABLE MaxActivity (
   periods integer,
   tech text,
   maxact real,
   maxact_units text,
   maxact_notes text,
   PRIMARY KEY(periods, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "MaxActivity" VALUES(2021, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2022, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2023, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2024, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2025, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2026, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2027, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2028, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2029, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES(2030, 'ABBOTT', 1661.8, 'thermal GWh', 'based on 0.568 average CapFactor');

INSERT INTO "MaxActivity" VALUES(2021, 'IMPELC', 525.6, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2022, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2023, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2024, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2025, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2026, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2027, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2028, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2029, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES(2030, 'IMPELC', 1051.2, 'electric GWh', '120 MWe imp limit met year round');



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
INSERT INTO "LifetimeTech" VALUES('IMPELC',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPNATGAS',1000,'');
INSERT INTO "LifetimeTech" VALUES('TURBINE',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPWIND',10,'');
INSERT INTO "LifetimeTech" VALUES('IMPSOL',25,'');
INSERT INTO "LifetimeTech" VALUES('UL',40,'');
INSERT INTO "LifetimeTech" VALUES('UH',40,'');
-- INSERT INTO "LifetimeTech" VALUES('CWS',40,'');
INSERT INTO "LifetimeTech" VALUES('NUCLEAR',40,'');
INSERT INTO "LifetimeTech" VALUES('ABBOTT',40,'');


CREATE TABLE LifetimeProcess (
   tech text,
   vintage integer,
   life_process real,
   life_process_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "LifetimeProcess" VALUES('UL',2000,1000,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('UH',2000,1000,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('ABBOTT',2000,60,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('TURBINE',2000,60,'#forexistingcap');
-- INSERT INTO "LifetimeProcess" VALUES('CWS',2000,60,'#forexistingcap');


CREATE TABLE LifetimeLoanTech (
   tech text,
   loan real,
   loan_notes text,
   PRIMARY KEY(tech),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "LifetimeLoanTech" VALUES('UL',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('UH',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('ABBOTT',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('TURBINE',40,'');
-- INSERT INTO "LifetimeLoanTech" VALUES('CWS',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('NUCLEAR',40,'');

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
INSERT INTO "CapacityFactorTech" VALUES('inter', 'day', 'IMPSOL',0.336,'average CF for UIUC farm');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'night', 'IMPSOL',0,'no solar at night');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'day', 'IMPSOL',0.336,'average CF for UIUC farm');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'night', 'IMPSOL',0,'no solar at night');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'day', 'IMPSOL',0.336,'average CF for UIUC farm');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'night', 'IMPSOL',0,'no solar at night');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'day', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'night', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'day', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'night', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'day', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'night', 'IMPWIND', 0.31,'average annual CF');

-- The nuclear capacity factor is a parameter of interest if it's also used for resarch!
INSERT INTO "CapacityFactorTech" VALUES('inter', 'day', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'night', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'day', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'night', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'day', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'night', 'NUCLEAR', 0.92,'average nuclear CF');

-- INSERT INTO "CapacityFactorTech" VALUES('inter', 'day', '', ,'');
-- INSERT INTO "CapacityFactorTech" VALUES('inter', 'night', '', ,'');
-- INSERT INTO "CapacityFactorTech" VALUES('winter', 'day', '', ,'');
-- INSERT INTO "CapacityFactorTech" VALUES('winter', 'night', '', ,'');
-- INSERT INTO "CapacityFactorTech" VALUES('summer', 'day', '', ,'');
-- INSERT INTO "CapacityFactorTech" VALUES('summer', 'night', '', ,'');


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

INSERT INTO "Efficiency" VALUES('ethos', 'IMPNATGAS', 2021, 'GAS', 1.00,'pure gas import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2000, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2020, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2021, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2022, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2023, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2024, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2025, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2026, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2027, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2028, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2029, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPELC', 2030, 'ELC', 1.00,'pure electricity import');

--Defines the ABBOTT parameters
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2000, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2020, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2021, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2022, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2023, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2024, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2025, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2026, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2027, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2028, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2029, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2030, 'STM', 1.00, 'Converts steam to steam');

INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2000, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2020, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2021, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2022, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2023, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2024, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2025, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2026, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2027, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2028, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2029, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('STM', 'TURBINE', 2030, 'ELC', 0.33, 'converts STM to ELC');

-- Define nuclear here
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2000, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2020, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2021, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2022, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2023, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2024, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2025, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2026, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2027, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2028, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2029, 'STM', 1.00, 'Converts steam to steam');
INSERT INTO "Efficiency" VALUES('ethos', 'NUCLEAR', 2030, 'STM', 1.00, 'Converts steam to steam');


-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2000, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2020, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2021, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2022, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2023, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2024, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2025, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2026, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2027, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2028, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2029, 'ELC', 0.72, 'converts STM to ELC');
-- INSERT INTO "Efficiency" VALUES('ELC', 'CWS', 2030, 'ELC', 0.72, 'converts STM to ELC');


  -- Define renewables here
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2016, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2020, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2021, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2022, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2023, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2024, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2025, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2026, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2027, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2028, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2029, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2030, 'ELC', 1.00,'pure electricity imports');

INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2016, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2020, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2021, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2022, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2023, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2024, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2025, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2026, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2027, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2028, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2029, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2030, 'ELC', 1.00,'pure electricity imports');

-- Define what happens to intermediate commodities here
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2000, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2020, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2021, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2022, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2023, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2024, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2025, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2026, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2027, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2028, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2029, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2030, 'UELC', 1.00,'');

INSERT INTO "Efficiency" VALUES('STM', 'UH', 2000, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2020, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2021, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2022, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2023, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2024, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2025, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2026, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2027, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2028, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2029, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2030, 'USTM', 1.00,'');

  -- Defines Chilled Water parameters. We are ignoring for now.
  -- If I want to add CHW later, I need to adjust electric demand accordingly.



-- I think each additional year might just ADD to existing capacity...
-- in which case I shouldn't have APP building anything in 2020
CREATE TABLE ExistingCapacity (
   tech text,
   vintage integer,
   exist_cap real,
   exist_cap_units text,
   exist_cap_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "ExistingCapacity" VALUES('IMPELC', 2020, 60, 'units: MWe', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('ABBOTT', 2000, 334, 'units: MWth', '');
INSERT INTO "ExistingCapacity" VALUES('TURBINE', 2000, 85, 'units: MWe','');
INSERT INTO "ExistingCapacity" VALUES('IMPWIND', 2016, 8.6, 'units: MWe', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('IMPSOL', 2016, 4.68, 'units: MWe', 'if 100% to electricity');
-- INSERT INTO "ExistingCapacity" VALUES('CWS', 2000, 8, 'units: MWe', 'shaves 8 MWe off of peak load');
-- INSERT INTO "ExistingCapacity" VALUES('UL', 2000, 88, 'units: MWe', 'moves output from APP to UIUC');
-- INSERT INTO "ExistingCapacity" VALUES('UH', 2000, 266, 'units: MWe', 'moves output from APP to UIUC');

-- need to add an existing capacity for the heating system!


-- Let's add some investment costs, consider ABBOTT first.
-- We need one entry for each optimization year, thus only 2021.
-- It ran, but didn't change anything because existing capacity was sufficient
 CREATE TABLE CostInvest (
   tech text,
   vintage integer,
   cost_invest real,
   cost_invest_units text,
   cost_invest_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "CostInvest" VALUES('ABBOTT', 2021, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('IMPSOL', 2021, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('IMPWIND', 2021, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('NUCLEAR', 2021, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');



-- By not adding anything to this table, I am assuming everything is paid off.
-- I.E. if TEMOA doesn't use a technology, it won't be penalized, besides the investment cost.
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


-- Let's add a variable cost to APP
-- The vintage is specified in existing capacity...
-- nat gas at APP is 8 cents/ kWh
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
INSERT INTO "CostVariable" VALUES(2021, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2021, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2021, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2021, 'IMPELC', 2020, 0.13, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES(2021, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES(2021, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
-- INSERT INTO "CostVariable" VALUES(2022, 'IMPSOL', 2022, 0.046, 'M$/GWh', '');


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
