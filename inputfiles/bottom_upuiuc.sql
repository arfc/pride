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
-- INSERT INTO "time_periods" VALUES(1960,'e');
-- INSERT INTO "time_periods" VALUES(1970,'e');
-- INSERT INTO "time_periods" VALUES(1980,'e');
-- INSERT INTO "time_periods" VALUES(1990,'f');
INSERT INTO "time_periods" VALUES(2000,'e');
INSERT INTO "time_periods" VALUES(2010,'e');
INSERT INTO "time_periods" VALUES(2020,'f');
INSERT INTO "time_periods" VALUES(2030,'f');
INSERT INTO "time_periods" VALUES(2040,'f');
INSERT INTO "time_periods" VALUES(2050,'f');
INSERT INTO "time_periods" VALUES(2060,'f');

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
INSERT INTO "technologies" VALUES('IMPNATGAS','r','supply', 'imported natural gas','natural gas');
INSERT INTO "technologies" VALUES('ABBOTT','p','electric', 'natural gas power plant','electricity');
INSERT INTO "technologies" VALUES('CHILL','p', 'chilled water', 'water chillers', 'chilled water');
INSERT INTO "technologies" VALUES('NUKE', 'p', 'electric', 'micro nuclear power plant', 'electricity');
INSERT INTO "technologies" VALUES('CWS', 'pb', 'chilled water', 'chilled water storage', 'chilled water');
INSERT INTO "technologies" VALUES('UL', 'p', 'university', 'university lighting', 'electricity');
INSERT INTO "technologies" VALUES('UH', 'p', 'university', 'university heating', 'steam');
INSERT INTO "technologies" VALUES('UC', 'p', 'university', 'university cooling', 'chilled water');
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
INSERT INTO "commodities" VALUES('CHW','p','chilled water');
INSERT INTO "commodities" VALUES('UELC', 'd', 'university electricity');
INSERT INTO "commodities" VALUES('USTM','d','university steam');
INSERT INTO "commodities" VALUES('UCHW','d','university chilled water');
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
-- INSERT INTO "DemandSpecificDistribution" VALUES('inter','day','UELC',.12,'');
-- INSERT INTO "DemandSpecificDistribution" VALUES('inter','night','UELC',.06,'');
-- INSERT INTO "DemandSpecificDistribution" VALUES('winter','day','UELC',.5467,'');
-- INSERT INTO "DemandSpecificDistribution" VALUES('winter','night','UELC',.2733,'');
-- INSERT INTO "DemandSpecificDistribution" VALUES('inter','day','USTM',.12,'');
-- INSERT INTO "DemandSpecificDistribution" VALUES('inter','night','USTM',.06,'');
-- INSERT INTO "DemandSpecificDistribution" VALUES('winter','day','USTM',.5467,'');
-- INSERT INTO "DemandSpecificDistribution" VALUES('winter','night','USTM',.2733,'');

CREATE TABLE CapacityToActivity (
   tech text primary key,
   c2a real,
   c2a_notes,
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "CapacityToActivity" VALUES('ABBOTT',8.76, 'thermal GWh');
INSERT INTO "CapacityToActivity" VALUES('CHILL',8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('NUKE', 8.76, 'thermal GWh');
INSERT INTO "CapacityToActivity" VALUES('UL', 1, '');
INSERT INTO "CapacityToActivity" VALUES('UH', 1, '');
INSERT INTO "CapacityToActivity" VALUES('UC', 1, '');


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
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2000,'STM',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2000,'ELC',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2010,'STM',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2010,'ELC',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2020,'STM',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2020,'ELC',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2030,'STM',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2030,'ELC',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2040,'STM',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2040,'ELC',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2050,'STM',0.192,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('co2eq', 'GAS','ABBOTT', 2050,'ELC',0.192,'tCO2/MWth','from iCAP');


CREATE TABLE EmissionLimit  (
   periods integer,
   emis_comm text,
   emis_limit real,
   emis_limit_units text,
   emis_limit_notes text,
   PRIMARY KEY(periods, emis_comm),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(emis_comm) REFERENCES commodities(comm_name) );
INSERT INTO "EmissionLimit" VALUES (2020, 'co2eq', 347, 'tCO2', 'projection from iCAP');

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
INSERT INTO "Demand" VALUES(2020, 'UELC', 375.6, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2020, 'USTM', 564.5, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2020, 'UCHW', 80, 'electric GWh', 'from iCAP report 2015');
INSERT INTO "Demand" VALUES(2030, 'UELC', 476.1, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2030, 'USTM', 715.6, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2030, 'UCHW', 101.4, 'electric GWh', 'from iCAP report 2015');
INSERT INTO "Demand" VALUES(2040, 'UELC', 603.6, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2040, 'USTM', 907.1, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2040, 'UCHW', 128.55, 'electric GWh', 'from iCAP report 2015');
INSERT INTO "Demand" VALUES(2050, 'UELC', 765.1, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2050, 'USTM', 1149.9, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES(2050, 'UCHW', 163.0, 'electric GWh', 'from iCAP report 2015');


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
INSERT INTO "TechInputSplit" VALUES('2020','ELC','CHILL',0.81,'NOTES');
INSERT INTO "TechInputSplit" VALUES('2020','STM','CHILL',0.19,'NOTES');
INSERT INTO "TechInputSplit" VALUES('2030','ELC','CHILL',0.81,'NOTES');
INSERT INTO "TechInputSplit" VALUES('2030','STM','CHILL',0.19,'NOTES');
INSERT INTO "TechInputSplit" VALUES('2040','ELC','CHILL',0.81,'NOTES');
INSERT INTO "TechInputSplit" VALUES('2040','STM','CHILL',0.19,'NOTES');
INSERT INTO "TechInputSplit" VALUES('2050','ELC','CHILL',0.81,'NOTES');
INSERT INTO "TechInputSplit" VALUES('2050','STM','CHILL',0.19,'NOTES');


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
INSERT INTO "TechOutputSplit" VALUES('2020','ABBOTT','ELC',0.65,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2020','ABBOTT','STM',0.35,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2030','ABBOTT','ELC',0.65,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2030','ABBOTT','STM',0.35,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2040','ABBOTT','ELC',0.65,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2040','ABBOTT','STM',0.35,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2050','ABBOTT','ELC',0.65,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2050','ABBOTT','STM',0.35,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2020','NUKE','ELC',0.65,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2020','NUKE','STM',0.35,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2030','NUKE','ELC',0.65,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2030','NUKE','STM',0.35,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2040','NUKE','ELC',0.65,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2040','NUKE','STM',0.35,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2050','NUKE','ELC',0.65,'NOTES');
INSERT INTO "TechOutputSplit" VALUES('2050','NUKE','STM',0.35,'NOTES');


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
-- INSERT INTO "MinCapacity" VALUES(2000,'ABBOTT',88,'','');


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
INSERT INTO "LifetimeTech" VALUES('IMPNATGAS',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPWIND',20,'');
INSERT INTO "LifetimeTech" VALUES('IMPSOL',20,'');
INSERT INTO "LifetimeTech" VALUES('UL',40,'');
INSERT INTO "LifetimeTech" VALUES('UH',40,'');
INSERT INTO "LifetimeTech" VALUES('UC',40,'');
INSERT INTO "LifetimeTech" VALUES('CWS',40,'');
INSERT INTO "LifetimeTech" VALUES('CHILL',40,'');
INSERT INTO "LifetimeTech" VALUES('ABBOTT',40,'');
INSERT INTO "LifetimeTech" VALUES('NUKE',40,'');


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
INSERT INTO "LifetimeProcess" VALUES('UC',2000,1000,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('CWS',2000,60,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('CHILL',2000,60,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('ABBOTT',2000,60,'#forexistingcap');

CREATE TABLE LifetimeLoanTech (
   tech text,
   loan real,
   loan_notes text,
   PRIMARY KEY(tech),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "LifetimeLoanTech" VALUES('ABBOTT',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('CHILL',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('NUKE',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('CWS',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('UC',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('UL',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('UH',40,'');

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
INSERT INTO "Efficiency" VALUES('ethos', 'IMPNATGAS', 2000, 'GAS', 1.00,'pure gas import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPNATGAS', 2010, 'GAS', 1.00,'pure gas import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPNATGAS', 2020, 'GAS', 1.00,'pure gas import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPNATGAS', 2030, 'GAS', 1.00,'pure gas import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPNATGAS', 2040, 'GAS', 1.00,'pure gas import');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPNATGAS', 2050, 'GAS', 1.00,'pure gas import');

INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2000, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2010, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2020, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2030, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2040, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPWIND', 2050, 'ELC', 1.00,'pure electricity imports');

INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2000, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2010, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2020, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2030, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2040, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('ethos', 'IMPSOL', 2050, 'ELC', 1.00,'pure electricity imports');

INSERT INTO "Efficiency" VALUES('ethos', 'NUKE', 2020, 'ELC', 0.33, 'generates electricity, no refueling');
INSERT INTO "Efficiency" VALUES('ethos', 'NUKE', 2030, 'ELC', 0.33, 'generates electricity, no refueling');
INSERT INTO "Efficiency" VALUES('ethos', 'NUKE', 2040, 'ELC', 0.33, 'generates electricity, no refueling');
INSERT INTO "Efficiency" VALUES('ethos', 'NUKE', 2050, 'ELC', 0.33, 'generates electricity, no refueling');

INSERT INTO "Efficiency" VALUES('ethos', 'NUKE', 2020, 'STM', 1.00, 'generates steam, no refueling');
INSERT INTO "Efficiency" VALUES('ethos', 'NUKE', 2030, 'STM', 1.00, 'generates steam, no refueling');
INSERT INTO "Efficiency" VALUES('ethos', 'NUKE', 2040, 'STM', 1.00, 'generates steam, no refueling');
INSERT INTO "Efficiency" VALUES('ethos', 'NUKE', 2050, 'STM', 1.00, 'generates steam, no refueling');

INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2000, 'ELC', 0.33, '');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2010, 'ELC', 0.33, '');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2020, 'ELC', 0.33, '');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2030, 'ELC', 0.33, '');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2040, 'ELC', 0.33, '');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2050, 'ELC', 0.33, '');

INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2000, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2010, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2020, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2030, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2040, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('GAS', 'ABBOTT', 2050, 'STM', 1.00, 'Converts steam to steam? Unsure.');

INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2000, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2010, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2020, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2030, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2040, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2050, 'CHW', 1.00,'');

INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2000, 'CHW', 0.33,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2010, 'CHW', 0.33,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2020, 'CHW', 0.33,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2030, 'CHW', 0.33,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2040, 'CHW', 0.33,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2050, 'CHW', 0.33,'');

INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2000, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2010, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2020, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2030, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2040, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2050, 'UELC', 1.00,'');

INSERT INTO "Efficiency" VALUES('STM', 'UH', 2000, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2010, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2020, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2030, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2040, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'UH', 2050, 'USTM', 1.00,'');

INSERT INTO "Efficiency" VALUES('CHW', 'UC', 2000, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'UC', 2010, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'UC', 2020, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'UC', 2030, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'UC', 2040, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'UC', 2050, 'UCHW', 1.00,'');

INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2000, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2010, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2020, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2030, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2040, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2050, 'CHW', 1.00,'');



-- I think each additional year might just ADD to existing capacity...
-- in which case I shouldn't have APP building anything in 2010
CREATE TABLE ExistingCapacity (
   tech text,
   vintage integer,
   exist_cap real,
   exist_cap_units text,
   exist_cap_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "ExistingCapacity" VALUES('IMPWIND', 2010, 8.6, 'units: MWe', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('IMPSOL', 2010, 4.8, 'units: MWe', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('ABBOTT', 2000, 257, 'units: MWth', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('CHILL', 2000, 36, 'units: MWe', 'creates chilled water');
-- INSERT INTO "ExistingCapacity" VALUES('UL', 2000, 88, 'units: MWe', 'moves output from APP to UIUC');
-- INSERT INTO "ExistingCapacity" VALUES('UH', 2000, 266, 'units: MWe', 'moves output from APP to UIUC');
-- INSERT INTO "ExistingCapacity" VALUES('UC', 2000, 36, 'units: MWe', 'creates chilled water');
INSERT INTO "ExistingCapacity" VALUES('CWS', 2000, 8, 'units: MWe', 'shaves 8 MWe off of peak load');

-- need to add an existing capacity for the heating system!


-- Let's add some investment costs, consider ABBOTT first.
-- We need one entry for each optimization year, thus only 2020.
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
INSERT INTO "CostInvest" VALUES('ABBOTT', 2020, 83.70, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('ABBOTT', 2030, 83.70, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('ABBOTT', 2040, 83.70, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('ABBOTT', 2050, 83.70, 'M$/MWth', 'cost of installing a natural gas unit');

INSERT INTO "CostInvest" VALUES('NUKE', 2020, 8, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('NUKE', 2030, 8, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('NUKE', 2040, 8, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('NUKE', 2050, 8, 'M$/MWth', 'cost of installing a natural gas unit');

INSERT INTO "CostInvest" VALUES('CHILL', 2020, 2.24, 'M$/MWe', 'cost of installing a new cooling tower');
INSERT INTO "CostInvest" VALUES('CHILL', 2030, 2.24, 'M$/MWe', 'cost of installing a new cooling tower');
INSERT INTO "CostInvest" VALUES('CHILL', 2040, 2.24, 'M$/MWe', 'cost of installing a new cooling tower');
INSERT INTO "CostInvest" VALUES('CHILL', 2050, 2.24, 'M$/MWe', 'cost of installing a new cooling tower');


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
INSERT INTO "CostVariable" VALUES(2020, 'NUKE', 2020, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2030, 'NUKE', 2030, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2040, 'NUKE', 2040, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2050, 'NUKE', 2050, 0.027, 'M$/GWh', '');

INSERT INTO "CostVariable" VALUES(2020, 'ABBOTT', 2000, 0.08, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2030, 'ABBOTT', 2030, 0.08, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2040, 'ABBOTT', 2040, 0.08, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2050, 'ABBOTT', 2050, 0.08, 'M$/GWh', '');

INSERT INTO "CostVariable" VALUES(2020, 'IMPSOL', 2010, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2030, 'IMPSOL', 2020, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2040, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2050, 'IMPSOL', 2040, 0.196, 'M$/GWh', '');

INSERT INTO "CostVariable" VALUES(2020, 'IMPWIND', 2010, 0.0384, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2030, 'IMPWIND', 2020, 0.0384, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2040, 'IMPWIND', 2030, 0.0384, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES(2050, 'IMPWIND', 2040, 0.0384, 'M$/GWh', '');


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
