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
-- INSERT INTO "sector_labels" VALUES('supply');
INSERT INTO "sector_labels" VALUES('electric');
INSERT INTO "sector_labels" VALUES('steam');
-- INSERT INTO "sector_labels" VALUES('chwater');
-- INSERT INTO "sector_labels" VALUES('transport');
-- INSERT INTO "sector_labels" VALUES('commercial');
-- INSERT INTO "sector_labels" VALUES('industrial');

--Tables below correspond to Temoa sets
CREATE TABLE time_periods (
  t_periods integer primary key,
  flag text,
  FOREIGN KEY(flag) REFERENCES time_period_labels(t_period_labels));
  -- We need to know when Abbott PP was most recently renovated.
INSERT INTO "time_periods" VALUES(2005, 'e');
INSERT INTO "time_periods" VALUES(2010, 'e');
INSERT INTO "time_periods" VALUES(2015, 'e');
INSERT INTO "time_periods" VALUES(2020, 'f');
INSERT INTO "time_periods" VALUES(2025, 'f');
-- INSERT INTO "time_periods" VALUES(2030, 'f');
-- INSERT INTO "time_periods" VALUES(2035, 'f');
-- INSERT INTO "time_periods" VALUES(2040, 'f');
-- INSERT INTO "time_periods" VALUES(2045, 'f');
-- INSERT INTO "time_periods" VALUES(2050, 'f');

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
  -- INSERT INTO "technologies" VALUES('IMPCOAL', 'r', 'supply', 'imported coal', 'coal');
INSERT INTO "technologies" VALUES('IMPSOL', 'r', 'supply', 'imported solar', 'solar');
INSERT INTO "technologies" VALUES('IMPWIND', 'r', 'supply', 'imported wind', 'wind');
INSERT INTO "technologies" VALUES('IMPELC', 'r', 'supply', 'imported electricity', 'MISO electricity');
INSERT INTO "technologies" VALUES('IMPNATGAS', 'r', 'supply', 'imported natural gas', 'natural gas');
INSERT INTO "technologies" VALUES('ABBOTT', 'pb', 'steam', 'abbott power plant', 'natural gas');
INSERT INTO "technologies" VALUES('UL', 'p', 'electricity', 'electric needs', 'electricity delivery');
INSERT INTO "technologies" VALUES('HEAT', 'p', 'steam', 'heating', 'steam delivery');
INSERT INTO "technologies" VALUES('COOL', 'p', 'chwater', 'cooling', 'chilled water delivery');
INSERT INTO "technologies" VALUES('CHILL', 'p', 'chwater', 'water chillers', 'chilled water');
INSERT INTO "technologies" VALUES('CWS', 'ps', 'chwater', 'chilled water storage', 'chilled water');
INSERT INTO "technologies" VALUES('WIND', 'p', 'electric', 'rail splitter wind farm', 'renewable');
INSERT INTO "technologies" VALUES('SOLAR', 'p', 'electric', 'south phoenix solar', 'renewable');

CREATE TABLE commodities (
  comm_name text primary key,
  flag text,
  comm_desc text,
  FOREIGN KEY(flag) REFERENCES commodity_labels(comm_labels));
  -- INSERT INTO "commodities" VALUES('COAL','p','# coal');
INSERT INTO "commodities" VALUES('ethos','p','# dummy commodity to supply inputs (makes graph easier to read)');
INSERT INTO "commodities" VALUES('co2','e','#CO2 emissions');
INSERT INTO "commodities" VALUES('GAS','p','# natural gas');
INSERT INTO "commodities" VALUES('ELC','p','# electricity');
INSERT INTO "commodities" VALUES('STM', 'p', '# steam');
INSERT INTO "commodities" VALUES('CHW', 'p', '# chilled water');
INSERT INTO "commodities" VALUES('UELC', 'd', '# university electricity');
INSERT INTO "commodities" VALUES('USTM', 'd', '# university steam');
INSERT INTO "commodities" VALUES('UCHW', 'd', '# university chilled water');
-- INSERT INTO "commodities" VALUES('NUKE', 'p', '# nuclear reactor');
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
INSERT INTO "DemandSpecificDistribution" VALUES('inter','day','USTM',.12,'');
INSERT INTO "DemandSpecificDistribution" VALUES('inter','night','USTM',.06,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','day','USTM',.5467,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','night','USTM',.2733,'');
INSERT INTO "DemandSpecificDistribution" VALUES('inter','day','UELC',.15,'');
INSERT INTO "DemandSpecificDistribution" VALUES('inter','night','UELC',.05,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','day','UELC',.50,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','night','UELC',.05,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','day','UELC',.15,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','night','UELC',.10,'');


CREATE TABLE CapacityToActivity (
   tech text primary key,
   c2a real,
   c2a_notes,
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "CapacityToActivity" VALUES('ABBOTT', 1, '');
INSERT INTO "CapacityToActivity" VALUES('CHILL', 1, '');
INSERT INTO "CapacityToActivity" VALUES('CWS', 1, 'chilled water storage');
INSERT INTO "CapacityToActivity" VALUES('UL', 1, 'electricity not used for cooling');
INSERT INTO "CapacityToActivity" VALUES('HEAT', 1, 'steam used for heating');
INSERT INTO "CapacityToActivity" VALUES('COOL', 1, 'chilled water for cooling');


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


CREATE TABLE EmissionLimit  (
   periods integer,
   emis_comm text,
   emis_limit real,
   emis_limit_units text,
   emis_limit_notes text,
   PRIMARY KEY(periods, emis_comm),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(emis_comm) REFERENCES commodities(comm_name) );


CREATE TABLE Demand (
   periods integer,
   demand_comm text,
   demand real,
   demand_units text,
   demand_notes text,
   PRIMARY KEY(periods, demand_comm),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(demand_comm) REFERENCES commodities(comm_name) );
INSERT INTO "Demand" VALUES (2005, 'UELC', 763.7,'thermal GWh','');
INSERT INTO "Demand" VALUES (2010, 'UELC', 783.3,'thermal GWh','');
INSERT INTO "Demand" VALUES (2015, 'UELC', 803.4,'thermal GWh','');
INSERT INTO "Demand" VALUES (2020, 'UELC', 823.5,'thermal GWh','');
INSERT INTO "Demand" VALUES (2025, 'UELC', 844.1,'thermal GWh','');
INSERT INTO "Demand" VALUES (2005, 'USTM', 393.9,'thermal GWh','');
INSERT INTO "Demand" VALUES (2010, 'USTM', 404.3,'thermal GWh','');
INSERT INTO "Demand" VALUES (2015, 'USTM', 414.7,'thermal GWh','');
INSERT INTO "Demand" VALUES (2020, 'USTM', 425.1,'thermal GWh','');
INSERT INTO "Demand" VALUES (2025, 'USTM', 435.6,'thermal GWh','');
INSERT INTO "Demand" VALUES (2005, 'UCHW', 807.0,'thermal GWh','');
INSERT INTO "Demand" VALUES (2010, 'UCHW', 826.0,'thermal GWh','');
INSERT INTO "Demand" VALUES (2015, 'UCHW', 830.0,'thermal GWh','');
INSERT INTO "Demand" VALUES (2020, 'UCHW', 847.0,'thermal GWh','');
INSERT INTO "Demand" VALUES (2025, 'UCHW', 858.0,'thermal GWh','');

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
INSERT INTO "TechInputSplit" VALUES(2005,'ELC','CHILL',0.8072,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2010,'ELC','CHILL',0.8072,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2015,'ELC','CHILL',0.8072,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2020,'ELC','CHILL',0.8072,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2025,'ELC','CHILL',0.8072,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2005,'STM','CHILL',0.1928,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2010,'STM','CHILL',0.1928,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2015,'STM','CHILL',0.1928,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2020,'STM','CHILL',0.1928,'NOTES');
INSERT INTO "TechInputSplit" VALUES(2025,'STM','CHILL',0.1928,'NOTES');
-- ========================================================================
-- Add H2 capacity later
-- ========================================================================
-- INSERT INTO "TechInputSplit" VALUES(2005,'ELC','H2',0.8072,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2010,'ELC','H2',0.8072,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2015,'ELC','H2',0.8072,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2020,'ELC','H2',0.8072,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2025,'ELC','H2',0.8072,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2005,'STM','H2',0.1928,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2010,'STM','H2',0.1928,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2015,'STM','H2',0.1928,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2020,'STM','H2',0.1928,'NOTES');
-- INSERT INTO "TechInputSplit" VALUES(2025,'STM','H2',0.1928,'NOTES');


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
INSERT INTO "TechOutputSplit" VALUES(2005,'ABBOTT','ELC',0.6543,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2010,'ABBOTT','ELC',0.6543,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2015,'ABBOTT','ELC',0.6543,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2020,'ABBOTT','ELC',0.6543,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2025,'ABBOTT','ELC',0.6543,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2005,'ABBOTT','STM',0.3457,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2010,'ABBOTT','STM',0.3457,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2015,'ABBOTT','STM',0.3457,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2020,'ABBOTT','STM',0.3457,'NOTES');
INSERT INTO "TechOutputSplit" VALUES(2025,'ABBOTT','STM',0.3457,'NOTES');


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
INSERT INTO "MaxCapacity" VALUES(2015, 'IMPSOL', 0.00468, '# GW', '');
INSERT INTO "MaxCapacity" VALUES(2020, 'IMPSOL', 0.01678, '# GW', '');
INSERT INTO "MaxCapacity" VALUES(2025, 'IMPSOL', 0.01678, '# GW', '');
INSERT INTO "MaxCapacity" VALUES(2015, 'IMPWIND', 0.00468, '# GW', '');
INSERT INTO "MaxCapacity" VALUES(2020, 'IMPWIND', 0.01678, '# GW', '');
INSERT INTO "MaxCapacity" VALUES(2025, 'IMPWIND', 0.01678, '# GW', '');
INSERT INTO "MaxCapacity" VALUES(2005, 'ABBOTT', 0.274, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2010, 'ABBOTT', 0.274, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2015, 'ABBOTT', 0.274, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2020, 'ABBOTT', 0.274, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2025, 'ABBOTT', 0.274, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2005, 'CWS', 0.0258, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2010, 'CWS', 0.0258, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2015, 'CWS', 0.0258, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2020, 'CWS', 0.0258, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2025, 'CWS', 0.0258, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2005, 'CHILL', 0.1758, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2010, 'CHILL', 0.1758, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2015, 'CHILL', 0.1758, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2020, 'CHILL', 0.1758, '# GWth', '');
INSERT INTO "MaxCapacity" VALUES(2025, 'CHILL', 0.1758, '# GWth', '');


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
INSERT INTO "LifetimeTech" VALUES ('ABBOTT', 30, '');
INSERT INTO "LifetimeTech" VALUES ('CHILL', 40, '');
INSERT INTO "LifetimeTech" VALUES ('CWS', 40, '');
INSERT INTO "LifetimeTech" VALUES('IMPWIND', 25, '');
INSERT INTO "LifetimeTech" VALUES('IMPSOL', 25, '');
INSERT INTO "LifetimeTech" VALUES('IMPELC', 1000, '');
INSERT INTO "LifetimeTech" VALUES('IMPNATGAS', 1000, '');
INSERT INTO "LifetimeTech" VALUES('UL', 1000, '');
INSERT INTO "LifetimeTech" VALUES('HEAT', 1000, '');
INSERT INTO "LifetimeTech" VALUES('COOL', 1000, '');
-- INSERT INTO "LifetimeTech" VALUES('IMPURN', 1000, '');


CREATE TABLE LifetimeProcess (
   tech text,
   vintage integer,
   life_process real,
   life_process_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );


CREATE TABLE LifetimeLoanTech (
   tech text,
   loan real,
   loan_notes text,
   PRIMARY KEY(tech),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );


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
INSERT INTO "CapacityFactorTech" VALUES('inter', 'day', 'ABBOTT',0.55 ,'');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'night', 'ABBOTT',0.55 ,'');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'day', 'ABBOTT',0.55 ,'');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'night', 'ABBOTT',0.55 ,'');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'day', 'ABBOTT',0.55 ,'');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'night', 'ABBOTT',0.55 ,'');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'day', 'IMPWIND', 0.32,'');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'night', 'IMPWIND', 0.32,'');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'day', 'IMPWIND', 0.32,'');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'night', 'IMPWIND', 0.32,'');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'day', 'IMPWIND', 0.32,'');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'night', 'IMPWIND', 0.32,'');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'day', 'IMPSOL', 0.168,'');
INSERT INTO "CapacityFactorTech" VALUES('inter', 'night', 'IMPSOL', 0.168,'');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'day', 'IMPSOL', 0.168,'');
INSERT INTO "CapacityFactorTech" VALUES('winter', 'night', 'IMPSOL', 0.168,'');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'day', 'IMPSOL', 0.168,'');
INSERT INTO "CapacityFactorTech" VALUES('summer', 'night', 'IMPSOL', 0.168,'');



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
INSERT INTO "Efficiency" VALUES('ethos','IMPNATGAS',2005,'GAS',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPNATGAS',2010,'GAS',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPNATGAS',2015,'GAS',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPNATGAS',2020,'GAS',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPNATGAS',2025,'GAS',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPSOL',2015,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPSOL',2020,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPSOL',2025,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPWIND',2015,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPWIND',2020,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPWIND',2025,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPELC',2005,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPELC',2010,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPELC',2015,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPELC',2020,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPELC',2025,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2005,'ELC',0.33,'# Efficiency 33%');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2010,'ELC',0.33,'# Efficiency 33%');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2015,'ELC',0.33,'# Efficiency 33%');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2020,'ELC',0.33,'# Efficiency 33%');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2025,'ELC',0.33,'# Efficiency 33%');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2005,'STM',1.00,'# Direct to STM');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2010,'STM',1.00,'# Direct to STM');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2015,'STM',1.00,'# Direct to STM');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2020,'STM',1.00,'# Direct to STM');
INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2025,'STM',1.00,'# Direct to STM');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2005, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2010, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2015, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2020, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'CHILL', 2025, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('STM', 'HEAT', 2005, 'USTM', .2,'');
INSERT INTO "Efficiency" VALUES('STM', 'HEAT', 2010, 'USTM', .2,'');
INSERT INTO "Efficiency" VALUES('STM', 'HEAT', 2015, 'USTM', .2,'');
INSERT INTO "Efficiency" VALUES('STM', 'HEAT', 2020, 'USTM', .2,'');
INSERT INTO "Efficiency" VALUES('STM', 'HEAT', 2025, 'USTM', .2,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2005, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2010, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2015, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2020, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'UL', 2025, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2005, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2010, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2015, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2020, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('ELC', 'CHILL', 2025, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2005, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2010, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2015, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2020, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'CWS', 2025, 'CHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'COOL', 2005, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'COOL', 2010, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'COOL', 2015, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'COOL', 2020, 'UCHW', 1.00,'');
INSERT INTO "Efficiency" VALUES('CHW', 'COOL', 2025, 'UCHW', 1.00,'');
-- ========================================================================
-- Add H2 capacity later
-- ========================================================================
-- INSERT INTO "Efficiency" VALUES('STM', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('STM', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('STM', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('STM', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('STM', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('ELC', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('ELC', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('ELC', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('ELC', 'H2', 2005, '', 0.3);
-- INSERT INTO "Efficiency" VALUES('ELC', 'H2', 2005, '', 0.3);

CREATE TABLE ExistingCapacity (
   tech text,
   vintage integer,
   exist_cap real,
   exist_cap_units text,
   exist_cap_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "ExistingCapacity" VALUES('ABBOTT', 2005, 0.274,'','');
INSERT INTO "ExistingCapacity" VALUES('ABBOTT', 2010, 0.274,'','');
INSERT INTO "ExistingCapacity" VALUES('ABBOTT', 2015, 0.274,'','');
INSERT INTO "ExistingCapacity" VALUES('IMPSOL', 2015, 0.00468,'','');
-- INSERT INTO "ExistingCapacity" VALUES('IMPSOL', 2020, 0.00468,'','');
INSERT INTO "ExistingCapacity" VALUES('IMPWIND', 2015, 0.00864,'','');
-- INSERT INTO "ExistingCapacity" VALUES('IMPWIND', 2020, 0.00864,'','');

-- I'm noticing that this lacks existing capacity for several technologies...

 CREATE TABLE CostInvest (
   tech text,
   vintage integer,
   cost_invest real,
   cost_invest_units text,
   cost_invest_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );


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
INSERT INTO "CostVariable" VALUES(2015, 'IMPSOL', 2015, 196000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2020, 'IMPSOL', 2020, 196000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2015, 'IMPWIND', 2015, 130000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2020, 'IMPWIND', 2020, 130000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2015, 'IMPELC', 2005, 130000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2020, 'IMPELC', 2010, 130000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2015, 'IMPELC', 2015, 130000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2020, 'IMPELC', 2020, 130000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2020, 'IMPELC', 2025, 130000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2005, 'ABBOTT', 2005, 80000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2010, 'ABBOTT', 2005, 80000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2015, 'ABBOTT', 2005, 80000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2020, 'ABBOTT', 2005, 80000, '$/GWh','');
INSERT INTO "CostVariable" VALUES(2025, 'ABBOTT', 2005, 80000, '$/GWh','');


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
