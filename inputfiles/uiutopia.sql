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
INSERT INTO "sector_labels" VALUES('residential');
INSERT INTO "sector_labels" VALUES('industrial');

--Tables below correspond to Temoa sets
CREATE TABLE time_periods (
  t_periods integer primary key,
  flag text,
  FOREIGN KEY(flag) REFERENCES time_period_labels(t_period_labels));
INSERT INTO "time_periods" VALUES(1960,'e');
INSERT INTO "time_periods" VALUES(1970,'e');
INSERT INTO "time_periods" VALUES(1980,'e');
INSERT INTO "time_periods" VALUES(1990,'f');
INSERT INTO "time_periods" VALUES(2000,'f');
INSERT INTO "time_periods" VALUES(2010,'f');
INSERT INTO "time_periods" VALUES(2020,'f');

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
-- INSERT INTO "technologies" VALUES('IMPDSL1','r','supply',' imported diesel','petroleum');
INSERT INTO "technologies" VALUES('IMPELC','r','supply',' imported gasoline','petroleum');
INSERT INTO "technologies" VALUES('IMPSOL','r','supply',' imported coal','coal');
INSERT INTO "technologies" VALUES('IMPNATGAS','r','supply',' imported crude oil','petroleum');
-- INSERT INTO "technologies" VALUES('IMPURN1','r','supply',' imported uranium','uranium');
INSERT INTO "technologies" VALUES('IMPWIND','r','supply',' imported water -- doesnt exist in Utopia','water');
INSERT INTO "technologies" VALUES('SOLARFARM','pb','electric',' coal power plant','coal');
-- INSERT INTO "technologies" VALUES('E21','pb','electric',' nuclear power plant','nuclear');
INSERT INTO "technologies" VALUES('WINDFARM','pb','electric',' WINDro power','WINDro');
INSERT INTO "technologies" VALUES('E51','ps','electric',' electric storage','storage');
-- INSERT INTO "technologies" VALUES('E70','p','electric',' diesel power plant','diesel');
-- INSERT INTO "technologies" VALUES('RHE','p','residential',' electric residential heating','electric');
INSERT INTO "technologies" VALUES('RHO','p','residential',' diesel residential heating','diesel');
INSERT INTO "technologies" VALUES('UL','p','residential',' university lighting','electric');
INSERT INTO "technologies" VALUES('ABBOTT','p','supply',' crude oil processor','petroleum');
INSERT INTO "technologies" VALUES('CHILL','p','supply','chillers','steam and electric');

--can include a column that designates the commodity type (physical, emissions, demand)
CREATE TABLE commodities (
  comm_name text primary key,
  flag text,
  comm_desc text,
  FOREIGN KEY(flag) REFERENCES commodity_labels(comm_labels));
INSERT INTO "commodities" VALUES('ethos','p','# dummy commodity to supply inputs (makes graph easier to read)');
INSERT INTO "commodities" VALUES('DSL','p','# diesel');
INSERT INTO "commodities" VALUES('ELC','p','# electricity');
INSERT INTO "commodities" VALUES('SOL','p','# solar');
INSERT INTO "commodities" VALUES('WIND','p','# wind');
INSERT INTO "commodities" VALUES('GAS','p','# natural gas');
-- INSERT INTO "commodities" VALUES('URN','p','# uranium');
INSERT INTO "commodities" VALUES('co2','e','#CO2 emissions');
INSERT INTO "commodities" VALUES('nox','e','#NOX emissions');
INSERT INTO "commodities" VALUES('USTM','d','# university steam');
INSERT INTO "commodities" VALUES('UELC','d','# university electricity');
INSERT INTO "commodities" VALUES('UCHW','d','# university chilled water');

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
INSERT INTO "DemandSpecificDistribution" VALUES('summer','day','UELC',.15,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','night','UELC',.05,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','day','UELC',.50,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','night','UELC',.10,'');


CREATE TABLE CapacityToActivity (
   tech text primary key,
   c2a real,
   c2a_notes,
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "CapacityToActivity" VALUES('SOLARFARM',31.54,'');
-- INSERT INTO "CapacityToActivity" VALUES('E21',31.54,'');
INSERT INTO "CapacityToActivity" VALUES('WINDFARM',31.54,'');
INSERT INTO "CapacityToActivity" VALUES('E51',31.54,'');
-- INSERT INTO "CapacityToActivity" VALUES('E70',31.54,'');
-- INSERT INTO "CapacityToActivity" VALUES('RHE',1,'');
INSERT INTO "CapacityToActivity" VALUES('RHO',1,'');
INSERT INTO "CapacityToActivity" VALUES('UL',1,'');
INSERT INTO "CapacityToActivity" VALUES('ABBOTT',1,'');
INSERT INTO "CapacityToActivity" VALUES('CHILL',1,'');


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
-- INSERT INTO "EmissionActivity" VALUES('co2','ethos','IMPDSL1',1990,'DSL',0.075,'','');
-- INSERT INTO "EmissionActivity" VALUES('co2','ethos','IMPELC',1990,'ELC',0.075,'','');
INSERT INTO "EmissionActivity" VALUES('co2','ethos','IMPSOL',1990,'SOL',0.089,'','');
INSERT INTO "EmissionActivity" VALUES('co2','ethos','IMPNATGAS',1990,'GAS',0.075,'','');

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
INSERT INTO "Demand" VALUES(1990,'USTM',25.2,'','');
INSERT INTO "Demand" VALUES(2000,'USTM',37.8,'','');
INSERT INTO "Demand" VALUES(2010,'USTM',56.7,'','');
INSERT INTO "Demand" VALUES(1990,'UELC',5.6,'','');
INSERT INTO "Demand" VALUES(2000,'UELC',8.4,'','');
INSERT INTO "Demand" VALUES(2010,'UELC',12.6,'','');
INSERT INTO "Demand" VALUES(1990,'UCHW',5.2,'','');
INSERT INTO "Demand" VALUES(2000,'UCHW',7.8,'','');
INSERT INTO "Demand" VALUES(2010,'UCHW',11.69,'','');


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
 INSERT INTO "TechInputSplit" VALUES(1990,'ELC','CHILL',0.8072,'NOTES');
 INSERT INTO "TechInputSplit" VALUES(2000,'ELC','CHILL',0.8072,'NOTES');
 INSERT INTO "TechInputSplit" VALUES(2010,'ELC','CHILL',0.8072,'NOTES');
 -- INSERT INTO "TechInputSplit" VALUES(2020,'ELC','CHILL',0.8072,'NOTES');
 -- INSERT INTO "TechInputSplit" VALUES(2025,'ELC','CHILL',0.8072,'NOTES');
 INSERT INTO "TechInputSplit" VALUES(1990,'DSL','CHILL',0.1928,'NOTES');
 INSERT INTO "TechInputSplit" VALUES(2000,'DSL','CHILL',0.1928,'NOTES');
 INSERT INTO "TechInputSplit" VALUES(2010,'DSL','CHILL',0.1928,'NOTES');
 -- INSERT INTO "TechInputSplit" VALUES(2020,'DSL','CHILL',0.1928,'NOTES');
 -- INSERT INTO "TechInputSplit" VALUES(2025,'DSL','CHILL',0.1928,'NOTES');

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
 INSERT INTO "TechOutputSplit" VALUES(1990,'ABBOTT','DSL',0.7,'');
 INSERT INTO "TechOutputSplit" VALUES(2000,'ABBOTT','DSL',0.7,'');
 INSERT INTO "TechOutputSplit" VALUES(2010,'ABBOTT','DSL',0.7,'');
 INSERT INTO "TechOutputSplit" VALUES(1990,'ABBOTT','ELC',0.3,'');
 INSERT INTO "TechOutputSplit" VALUES(2000,'ABBOTT','ELC',0.3,'');
 INSERT INTO "TechOutputSplit" VALUES(2010,'ABBOTT','ELC',0.3,'');

CREATE TABLE MinCapacity (
   periods integer,
   tech text,
   mincap real,
   mincap_units text,
   mincap_notes text,
   PRIMARY KEY(periods, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "MinCapacity" VALUES(1990,'WINDFARM',0.13,'','');
INSERT INTO "MinCapacity" VALUES(2000,'WINDFARM',0.13,'','');
INSERT INTO "MinCapacity" VALUES(2010,'WINDFARM',0.13,'','');
INSERT INTO "MinCapacity" VALUES(1990,'ABBOTT',0.1,'','');


CREATE TABLE MaxCapacity (
   periods integer,
   tech text,
   maxcap real,
   maxcap_units text,
   maxcap_notes text,
   PRIMARY KEY(periods, tech),
   FOREIGN KEY(periods) REFERENCES time_periods(t_periods),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
 INSERT INTO "MaxCapacity" VALUES(1990,'WINDFARM',0.13,'','');
 INSERT INTO "MaxCapacity" VALUES(2000,'WINDFARM',0.17,'','');
 INSERT INTO "MaxCapacity" VALUES(2010,'WINDFARM',0.21,'','');
 -- INSERT INTO "MaxCapacity" VALUES(1990,'RHE',0.0,'','');
 INSERT INTO "MaxCapacity" VALUES(1990,'CHILL',0.6,'','');
 INSERT INTO "MaxCapacity" VALUES(2000,'CHILL',1.76,'','');
 INSERT INTO "MaxCapacity" VALUES(2010,'CHILL',4.76,'','');

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
INSERT INTO "LifetimeTech" VALUES('SOLARFARM',40,'');
-- INSERT INTO "LifetimeTech" VALUES('E21',40,'');
INSERT INTO "LifetimeTech" VALUES('WINDFARM',100,'');
INSERT INTO "LifetimeTech" VALUES('E51',100,'');
-- INSERT INTO "LifetimeTech" VALUES('E70',40,'');
-- INSERT INTO "LifetimeTech" VALUES('RHE',30,'');
INSERT INTO "LifetimeTech" VALUES('RHO',30,'');
INSERT INTO "LifetimeTech" VALUES('UL',10,'');
INSERT INTO "LifetimeTech" VALUES('ABBOTT',50,'');
INSERT INTO "LifetimeTech" VALUES('CHILL',15,'');
-- INSERT INTO "LifetimeTech" VALUES('IMPDSL1',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPELC',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPSOL',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPNATGAS',1000,'');
-- INSERT INTO "LifetimeTech" VALUES('IMPURN1',1000,'');
INSERT INTO "LifetimeTech" VALUES('IMPWIND',1000,'');


CREATE TABLE LifetimeProcess (
   tech text,
   vintage integer,
   life_process real,
   life_process_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "LifetimeProcess" VALUES('UL',1980,20,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('CHILL',1970,30,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('CHILL',1980,30,'#forexistingcap');

CREATE TABLE LifetimeLoanTech (
   tech text,
   loan real,
   loan_notes text,
   PRIMARY KEY(tech),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "LifetimeLoanTech" VALUES('SOLARFARM',40,'');
-- INSERT INTO "LifetimeLoanTech" VALUES('E21',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('WINDFARM',100,'');
INSERT INTO "LifetimeLoanTech" VALUES('E51',100,'');
-- INSERT INTO "LifetimeLoanTech" VALUES('E70',40,'');
-- INSERT INTO "LifetimeLoanTech" VALUES('RHE',30,'');
INSERT INTO "LifetimeLoanTech" VALUES('RHO',30,'');
INSERT INTO "LifetimeLoanTech" VALUES('UL',10,'');
INSERT INTO "LifetimeLoanTech" VALUES('ABBOTT',50,'');
INSERT INTO "LifetimeLoanTech" VALUES('CHILL',15,'');


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
INSERT INTO "CapacityFactorTech" VALUES('inter','day','SOLARFARM',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('inter','night','SOLARFARM',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('winter','day','SOLARFARM',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('winter','night','SOLARFARM',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('summer','day','SOLARFARM',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('summer','night','SOLARFARM',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('inter','day','E21',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('inter','night','E21',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('winter','day','E21',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('winter','night','E21',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('summer','day','E21',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('summer','night','E21',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('inter','day','WINDFARM',0.275,'');
INSERT INTO "CapacityFactorTech" VALUES('inter','night','WINDFARM',0.275,'');
INSERT INTO "CapacityFactorTech" VALUES('winter','day','WINDFARM',0.275,'');
INSERT INTO "CapacityFactorTech" VALUES('winter','night','WINDFARM',0.275,'');
INSERT INTO "CapacityFactorTech" VALUES('summer','day','WINDFARM',0.275,'');
INSERT INTO "CapacityFactorTech" VALUES('summer','night','WINDFARM',0.275,'');
INSERT INTO "CapacityFactorTech" VALUES('inter','day','E51',0.17,'');
INSERT INTO "CapacityFactorTech" VALUES('inter','night','E51',0.17,'');
INSERT INTO "CapacityFactorTech" VALUES('winter','day','E51',0.17,'');
INSERT INTO "CapacityFactorTech" VALUES('winter','night','E51',0.17,'');
INSERT INTO "CapacityFactorTech" VALUES('summer','day','E51',0.17,'');
INSERT INTO "CapacityFactorTech" VALUES('summer','night','E51',0.17,'');
-- INSERT INTO "CapacityFactorTech" VALUES('inter','day','E70',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('inter','night','E70',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('winter','day','E70',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('winter','night','E70',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('summer','day','E70',0.8,'');
-- INSERT INTO "CapacityFactorTech" VALUES('summer','night','E70',0.8,'');


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
INSERT INTO "CapacityFactorProcess" VALUES('inter','day','WINDFARM',2000,0.2753,'');
INSERT INTO "CapacityFactorProcess" VALUES('inter','night','WINDFARM',2000,0.2753,'');
INSERT INTO "CapacityFactorProcess" VALUES('winter','day','WINDFARM',2000,0.2753,'');
INSERT INTO "CapacityFactorProcess" VALUES('winter','night','WINDFARM',2000,0.2753,'');
INSERT INTO "CapacityFactorProcess" VALUES('summer','day','WINDFARM',2000,0.2753,'');
INSERT INTO "CapacityFactorProcess" VALUES('summer','night','WINDFARM',2000,0.2753,'');
INSERT INTO "CapacityFactorProcess" VALUES('inter','day','WINDFARM',2010,0.2756,'');
INSERT INTO "CapacityFactorProcess" VALUES('inter','night','WINDFARM',2010,0.2756,'');
INSERT INTO "CapacityFactorProcess" VALUES('winter','day','WINDFARM',2010,0.2756,'');
INSERT INTO "CapacityFactorProcess" VALUES('winter','night','WINDFARM',2010,0.2756,'');
INSERT INTO "CapacityFactorProcess" VALUES('summer','day','WINDFARM',2010,0.2756,'');
INSERT INTO "CapacityFactorProcess" VALUES('summer','night','WINDFARM',2010,0.2756,'');


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
-- INSERT INTO "Efficiency" VALUES('ethos','IMPDSL1',1990,'DSL',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPELC',1990,'ELC',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPSOL',1990,'SOL',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPNATGAS',1990,'GAS',1.00,'');
-- INSERT INTO "Efficiency" VALUES('ethos','IMPURN1',1990,'URN',1.00,'');
INSERT INTO "Efficiency" VALUES('ethos','IMPWIND',1990,'WIND',1.00,'');
INSERT INTO "Efficiency" VALUES('SOL','SOLARFARM',1960,'ELC',0.32,'# 1/3.125');
INSERT INTO "Efficiency" VALUES('SOL','SOLARFARM',1970,'ELC',0.32,'# 1/3.125');
INSERT INTO "Efficiency" VALUES('SOL','SOLARFARM',1980,'ELC',0.32,'# 1/3.125');
INSERT INTO "Efficiency" VALUES('SOL','SOLARFARM',1990,'ELC',0.32,'# 1/3.125');
 INSERT INTO "Efficiency" VALUES('SOL','SOLARFARM',2000,'ELC',0.32,'# 1/3.125');
 INSERT INTO "Efficiency" VALUES('SOL','SOLARFARM',2010,'ELC',0.32,'# 1/3.125');
 -- INSERT INTO "Efficiency" VALUES('URN','E21',1990,'ELC',0.40,'# 1/2.5');
 -- INSERT INTO "Efficiency" VALUES('URN','E21',2000,'ELC',0.40,'# 1/2.5');
 -- INSERT INTO "Efficiency" VALUES('URN','E21',2010,'ELC',0.40,'# 1/2.5');
 INSERT INTO "Efficiency" VALUES('WIND','WINDFARM',1980,'ELC',0.32,'# 1/3.125');
 INSERT INTO "Efficiency" VALUES('WIND','WINDFARM',1990,'ELC',0.32,'# 1/3.125');
 INSERT INTO "Efficiency" VALUES('WIND','WINDFARM',2000,'ELC',0.32,'# 1/3.125');
 INSERT INTO "Efficiency" VALUES('WIND','WINDFARM',2010,'ELC',0.32,'# 1/3.125');
 -- INSERT INTO "Efficiency" VALUES('DSL','E70',1960,'ELC',0.294,'# 1/3.4');
 -- INSERT INTO "Efficiency" VALUES('DSL','E70',1970,'ELC',0.294,'# 1/3.4');
 -- INSERT INTO "Efficiency" VALUES('DSL','E70',1980,'ELC',0.294,'# 1/3.4');
 -- INSERT INTO "Efficiency" VALUES('DSL','E70',1990,'ELC',0.294,'# 1/3.4');
 -- INSERT INTO "Efficiency" VALUES('DSL','E70',2000,'ELC',0.294,'# 1/3.4');
 -- INSERT INTO "Efficiency" VALUES('DSL','E70',2010,'ELC',0.294,'# 1/3.4');
 INSERT INTO "Efficiency" VALUES('ELC','E51',1980,'ELC',0.720,'# 1/1.3889');
 INSERT INTO "Efficiency" VALUES('ELC','E51',1990,'ELC',0.720,'# 1/1.3889');
 INSERT INTO "Efficiency" VALUES('ELC','E51',2000,'ELC',0.720,'# 1/1.3889');
 INSERT INTO "Efficiency" VALUES('ELC','E51',2010,'ELC',0.720,'# 1/1.3889');
 INSERT INTO "Efficiency" VALUES('ELC','CHILL',1990,'UCHW',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','CHILL',2000,'UCHW',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','CHILL',2010,'UCHW',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','RHO',1970,'USTM',0.7,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','RHO',1980,'USTM',0.7,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','RHO',1990,'USTM',0.7,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','RHO',2000,'USTM',0.7,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','RHO',2010,'USTM',0.7,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','UL',1980,'UELC',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','UL',1990,'UELC',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','UL',2000,'UELC',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','UL',2010,'UELC',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',1990,'DSL',1.00,'# direct translation from PRC_INP2, PRC_OUT');
 INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2000,'DSL',1.00,'# direct translation from PRC_INP2, PRC_OUT');
 INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2010,'DSL',1.00,'# direct translation from PRC_INP2, PRC_OUT');
 INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',1990,'ELC',1.00,'# direct translation from PRC_INP2, PRC_OUT');
 INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2000,'ELC',1.00,'# direct translation from PRC_INP2, PRC_OUT');
 INSERT INTO "Efficiency" VALUES('GAS','ABBOTT',2010,'ELC',1.00,'# direct translation from PRC_INP2, PRC_OUT');
 INSERT INTO "Efficiency" VALUES('DSL','CHILL',1970,'UCHW',0.231,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','CHILL',1980,'UCHW',0.231,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','CHILL',1990,'UCHW',0.231,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','CHILL',2000,'UCHW',0.231,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('DSL','CHILL',2010,'UCHW',0.231,'# direct translation from DMD_EFF');

CREATE TABLE ExistingCapacity (
   tech text,
   vintage integer,
   exist_cap real,
   exist_cap_units text,
   exist_cap_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "ExistingCapacity" VALUES('SOLARFARM',1960,0.175,'','');
INSERT INTO "ExistingCapacity" VALUES('SOLARFARM',1970,0.175,'','');
INSERT INTO "ExistingCapacity" VALUES('SOLARFARM',1980,0.15,'','');
INSERT INTO "ExistingCapacity" VALUES('WINDFARM',1980,0.1,'','');
INSERT INTO "ExistingCapacity" VALUES('E51',1980,0.5,'','');
-- INSERT INTO "ExistingCapacity" VALUES('E70',1960,0.05,'','');
-- INSERT INTO "ExistingCapacity" VALUES('E70',1970,0.05,'','');
-- INSERT INTO "ExistingCapacity" VALUES('E70',1980,0.2,'','');
INSERT INTO "ExistingCapacity" VALUES('RHO',1970,12.5,'','');
INSERT INTO "ExistingCapacity" VALUES('RHO',1980,12.5,'','');
INSERT INTO "ExistingCapacity" VALUES('UL',1980,5.6,'','');
INSERT INTO "ExistingCapacity" VALUES('CHILL',1970,0.4,'','');
INSERT INTO "ExistingCapacity" VALUES('CHILL',1980,0.2,'','');

 CREATE TABLE CostInvest (
   tech text,
   vintage integer,
   cost_invest real,
   cost_invest_units text,
   cost_invest_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
 INSERT INTO "CostInvest" VALUES('SOLARFARM',1990,2000,'','');
 INSERT INTO "CostInvest" VALUES('SOLARFARM',2000,1300,'','');
 INSERT INTO "CostInvest" VALUES('SOLARFARM',2010,1200,'','');
 -- INSERT INTO "CostInvest" VALUES('E21',1990,5000,'','');
 -- INSERT INTO "CostInvest" VALUES('E21',2000,5000,'','');
 -- INSERT INTO "CostInvest" VALUES('E21',2010,5000,'','');
 INSERT INTO "CostInvest" VALUES('WINDFARM',1990,3000,'','');
 INSERT INTO "CostInvest" VALUES('WINDFARM',2000,3000,'','');
 INSERT INTO "CostInvest" VALUES('WINDFARM',2010,3000,'','');
 INSERT INTO "CostInvest" VALUES('E51',1990,900,'','');
 INSERT INTO "CostInvest" VALUES('E51',2000,900,'','');
 INSERT INTO "CostInvest" VALUES('E51',2010,900,'','');
 -- INSERT INTO "CostInvest" VALUES('E70',1990,1000,'','');
 -- INSERT INTO "CostInvest" VALUES('E70',2000,1000,'','');
 -- INSERT INTO "CostInvest" VALUES('E70',2010,1000,'','');
 -- INSERT INTO "CostInvest" VALUES('RHE',1990,90,'','');
 -- INSERT INTO "CostInvest" VALUES('RHE',2000,90,'','');
 -- INSERT INTO "CostInvest" VALUES('RHE',2010,90,'','');
 INSERT INTO "CostInvest" VALUES('RHO',1990,100,'','');
 INSERT INTO "CostInvest" VALUES('RHO',2000,100,'','');
 INSERT INTO "CostInvest" VALUES('RHO',2010,100,'','');
 INSERT INTO "CostInvest" VALUES('ABBOTT',1990,100,'','');
 INSERT INTO "CostInvest" VALUES('ABBOTT',2000,100,'','');
 INSERT INTO "CostInvest" VALUES('ABBOTT',2010,100,'','');
 INSERT INTO "CostInvest" VALUES('CHILL',1990,1044,'','');
 INSERT INTO "CostInvest" VALUES('CHILL',2000,1044,'','');
 INSERT INTO "CostInvest" VALUES('CHILL',2010,1044,'','');

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
 INSERT INTO "CostFixed" VALUES(1990,'SOLARFARM',1960,40,'','');
 INSERT INTO "CostFixed" VALUES(1990,'SOLARFARM',1970,40,'','');
 INSERT INTO "CostFixed" VALUES(1990,'SOLARFARM',1980,40,'','');
 INSERT INTO "CostFixed" VALUES(1990,'SOLARFARM',1990,40,'','');
 INSERT INTO "CostFixed" VALUES(2000,'SOLARFARM',1970,70,'','');
 INSERT INTO "CostFixed" VALUES(2000,'SOLARFARM',1980,70,'','');
 INSERT INTO "CostFixed" VALUES(2000,'SOLARFARM',1990,70,'','');
 INSERT INTO "CostFixed" VALUES(2000,'SOLARFARM',2000,70,'','');
 INSERT INTO "CostFixed" VALUES(2010,'SOLARFARM',1980,100,'','');
 INSERT INTO "CostFixed" VALUES(2010,'SOLARFARM',1990,100,'','');
 INSERT INTO "CostFixed" VALUES(2010,'SOLARFARM',2000,100,'','');
 INSERT INTO "CostFixed" VALUES(2010,'SOLARFARM',2010,100,'','');
 -- INSERT INTO "CostFixed" VALUES(1990,'E21',1990,500,'','');
 -- INSERT INTO "CostFixed" VALUES(2000,'E21',1990,500,'','');
 -- INSERT INTO "CostFixed" VALUES(2010,'E21',1990,500,'','');
 -- INSERT INTO "CostFixed" VALUES(2000,'E21',2000,500,'','');
 -- INSERT INTO "CostFixed" VALUES(2010,'E21',2000,500,'','');
 -- INSERT INTO "CostFixed" VALUES(2010,'E21',2010,500,'','');
 INSERT INTO "CostFixed" VALUES(1990,'WINDFARM',1980,75,'','');
 INSERT INTO "CostFixed" VALUES(1990,'WINDFARM',1990,75,'','');
 INSERT INTO "CostFixed" VALUES(2000,'WINDFARM',1980,75,'','');
 INSERT INTO "CostFixed" VALUES(2000,'WINDFARM',1990,75,'','');
 INSERT INTO "CostFixed" VALUES(2000,'WINDFARM',2000,75,'','');
 INSERT INTO "CostFixed" VALUES(2010,'WINDFARM',1980,75,'','');
 INSERT INTO "CostFixed" VALUES(2010,'WINDFARM',1990,75,'','');
 INSERT INTO "CostFixed" VALUES(2010,'WINDFARM',2000,75,'','');
 INSERT INTO "CostFixed" VALUES(2010,'WINDFARM',2010,75,'','');
 INSERT INTO "CostFixed" VALUES(1990,'E51',1980,30,'','');
 INSERT INTO "CostFixed" VALUES(1990,'E51',1990,30,'','');
 INSERT INTO "CostFixed" VALUES(2000,'E51',1980,30,'','');
 INSERT INTO "CostFixed" VALUES(2000,'E51',1990,30,'','');
 INSERT INTO "CostFixed" VALUES(2000,'E51',2000,30,'','');
 INSERT INTO "CostFixed" VALUES(2010,'E51',1980,30,'','');
 INSERT INTO "CostFixed" VALUES(2010,'E51',1990,30,'','');
 INSERT INTO "CostFixed" VALUES(2010,'E51',2000,30,'','');
 INSERT INTO "CostFixed" VALUES(2010,'E51',2010,30,'','');
 -- INSERT INTO "CostFixed" VALUES(1990,'E70',1960,30,'','');
 -- INSERT INTO "CostFixed" VALUES(1990,'E70',1970,30,'','');
 -- INSERT INTO "CostFixed" VALUES(1990,'E70',1980,30,'','');
 -- INSERT INTO "CostFixed" VALUES(1990,'E70',1990,30,'','');
 -- INSERT INTO "CostFixed" VALUES(2000,'E70',1970,30,'','');
 -- INSERT INTO "CostFixed" VALUES(2000,'E70',1980,30,'','');
 -- INSERT INTO "CostFixed" VALUES(2000,'E70',1990,30,'','');
 -- INSERT INTO "CostFixed" VALUES(2000,'E70',2000,30,'','');
 -- INSERT INTO "CostFixed" VALUES(2010,'E70',1980,30,'','');
 -- INSERT INTO "CostFixed" VALUES(2010,'E70',1990,30,'','');
 -- INSERT INTO "CostFixed" VALUES(2010,'E70',2000,30,'','');
 -- INSERT INTO "CostFixed" VALUES(2010,'E70',2010,30,'','');
 INSERT INTO "CostFixed" VALUES(1990,'RHO',1970,1,'','');
 INSERT INTO "CostFixed" VALUES(1990,'RHO',1980,1,'','');
 INSERT INTO "CostFixed" VALUES(1990,'RHO',1990,1,'','');
 INSERT INTO "CostFixed" VALUES(2000,'RHO',1980,1,'','');
 INSERT INTO "CostFixed" VALUES(2000,'RHO',1990,1,'','');
 INSERT INTO "CostFixed" VALUES(2000,'RHO',2000,1,'','');
 INSERT INTO "CostFixed" VALUES(2010,'RHO',1990,1,'','');
 INSERT INTO "CostFixed" VALUES(2010,'RHO',2000,1,'','');
 INSERT INTO "CostFixed" VALUES(2010,'RHO',2010,1,'','');
 INSERT INTO "CostFixed" VALUES(1990,'UL',1980, 9.46,'','');
 INSERT INTO "CostFixed" VALUES(1990,'UL',1990, 9.46,'','');
 INSERT INTO "CostFixed" VALUES(2000,'UL',2000, 9.46,'','');
 INSERT INTO "CostFixed" VALUES(2010,'UL',2010, 9.46,'','');
 INSERT INTO "CostFixed" VALUES(1990,'CHILL',1970,52,'','');
 INSERT INTO "CostFixed" VALUES(1990,'CHILL',1980,52,'','');
 INSERT INTO "CostFixed" VALUES(1990,'CHILL',1990,52,'','');
 INSERT INTO "CostFixed" VALUES(2000,'CHILL',1980,52,'','');
 INSERT INTO "CostFixed" VALUES(2000,'CHILL',1990,52,'','');
 INSERT INTO "CostFixed" VALUES(2000,'CHILL',2000,52,'','');
 INSERT INTO "CostFixed" VALUES(2010,'CHILL',2000,52,'','');
 INSERT INTO "CostFixed" VALUES(2010,'CHILL',2010,52,'','');


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
 -- INSERT INTO "CostVariable" VALUES(1990,'IMPDSL1',1990,10,'','');
 -- INSERT INTO "CostVariable" VALUES(2000,'IMPDSL1',1990,10,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'IMPDSL1',1990,10,'','');
 INSERT INTO "CostVariable" VALUES(1990,'IMPELC',1990,15,'','');
 INSERT INTO "CostVariable" VALUES(2000,'IMPELC',1990,15,'','');
 INSERT INTO "CostVariable" VALUES(2010,'IMPELC',1990,15,'','');
 INSERT INTO "CostVariable" VALUES(1990,'IMPSOL',1990,2,'','');
 INSERT INTO "CostVariable" VALUES(2000,'IMPSOL',1990,2,'','');
 INSERT INTO "CostVariable" VALUES(2010,'IMPSOL',1990,2,'','');
 INSERT INTO "CostVariable" VALUES(1990,'IMPNATGAS',1990,8,'','');
 INSERT INTO "CostVariable" VALUES(2000,'IMPNATGAS',1990,8,'','');
 INSERT INTO "CostVariable" VALUES(2010,'IMPNATGAS',1990,8,'','');
 -- INSERT INTO "CostVariable" VALUES(1990,'IMPURN1',1990,2,'','');
 -- INSERT INTO "CostVariable" VALUES(2000,'IMPURN1',1990,2,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'IMPURN1',1990,2,'','');
 INSERT INTO "CostVariable" VALUES(1990,'SOLARFARM',1960,0.3,'','');
 INSERT INTO "CostVariable" VALUES(1990,'SOLARFARM',1970,0.3,'','');
 INSERT INTO "CostVariable" VALUES(1990,'SOLARFARM',1980,0.3,'','');
 INSERT INTO "CostVariable" VALUES(1990,'SOLARFARM',1990,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2000,'SOLARFARM',1970,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2000,'SOLARFARM',1980,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2000,'SOLARFARM',1990,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2000,'SOLARFARM',2000,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2010,'SOLARFARM',1980,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2010,'SOLARFARM',1990,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2010,'SOLARFARM',2000,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2010,'SOLARFARM',2010,0.3,'','');
 -- INSERT INTO "CostVariable" VALUES(1990,'E21',1990,1.5,'','');
 -- INSERT INTO "CostVariable" VALUES(2000,'E21',1990,1.5,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'E21',1990,1.5,'','');
 -- INSERT INTO "CostVariable" VALUES(2000,'E21',2000,1.5,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'E21',2000,1.5,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'E21',2010,1.5,'','');
 -- INSERT INTO "CostVariable" VALUES(1990,'E70',1960,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(1990,'E70',1970,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(1990,'E70',1980,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(1990,'E70',1990,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(2000,'E70',1970,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(2000,'E70',1980,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(2000,'E70',1990,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(2000,'E70',2000,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'E70',1980,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'E70',1990,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'E70',2000,0.4,'','');
 -- INSERT INTO "CostVariable" VALUES(2010,'E70',2010,0.4,'','');
 INSERT INTO "CostVariable" VALUES(1990,'ABBOTT',1990,10,'','');
 INSERT INTO "CostVariable" VALUES(2000,'ABBOTT',1990,10,'','');
 INSERT INTO "CostVariable" VALUES(2000,'ABBOTT',2000,10,'','');
 INSERT INTO "CostVariable" VALUES(2010,'ABBOTT',1990,10,'','');
 INSERT INTO "CostVariable" VALUES(2010,'ABBOTT',2000,10,'','');
 INSERT INTO "CostVariable" VALUES(2010,'ABBOTT',2010,10,'','');

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
