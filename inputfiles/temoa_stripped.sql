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
INSERT INTO "technologies" VALUES('IMPHCO1','r','supply',' imported coal','coal');
INSERT INTO "technologies" VALUES('E01','pb','electric',' coal power plant','coal');
INSERT INTO "technologies" VALUES('RL1','p','residential',' residential lighting','electric');

--can include a column that designates the commodity type (physical, emissions, demand)
CREATE TABLE commodities (
  comm_name text primary key,
  flag text,
  comm_desc text,
  FOREIGN KEY(flag) REFERENCES commodity_labels(comm_labels));
INSERT INTO "commodities" VALUES('ethos','p','# dummy commodity to supply inputs (makes graph easier to read)');
INSERT INTO "commodities" VALUES('ELC','p','# electricity');
INSERT INTO "commodities" VALUES('HCO','p','# coal');
INSERT INTO "commodities" VALUES('RL','d','# residential lighting');

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
INSERT INTO "DemandSpecificDistribution" VALUES('inter','day','RL',.15,'');
INSERT INTO "DemandSpecificDistribution" VALUES('inter','night','RL',.05,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','day','RL',.15,'');
INSERT INTO "DemandSpecificDistribution" VALUES('summer','night','RL',.05,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','day','RL',.50,'');
INSERT INTO "DemandSpecificDistribution" VALUES('winter','night','RL',.10,'');


CREATE TABLE CapacityToActivity (
   tech text primary key,
   c2a real,
   c2a_notes,
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "CapacityToActivity" VALUES('E01',31.54,'');
INSERT INTO "CapacityToActivity" VALUES('RL1',1,'');


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
-- INSERT INTO "EmissionActivity" VALUES('co2','ethos','IMPHCO1',1990,'HCO',0.089,'','');

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
INSERT INTO "Demand" VALUES(1990,'RL',5.6,'','');
INSERT INTO "Demand" VALUES(2000,'RL',8.4,'','');
INSERT INTO "Demand" VALUES(2010,'RL',12.6,'','');


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
INSERT INTO "LifetimeTech" VALUES('E01',40,'');
INSERT INTO "LifetimeTech" VALUES('RL1',10,'');
INSERT INTO "LifetimeTech" VALUES('IMPHCO1',1000,'');


CREATE TABLE LifetimeProcess (
   tech text,
   vintage integer,
   life_process real,
   life_process_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "LifetimeProcess" VALUES('RL1',1980,20,'#forexistingcap');

CREATE TABLE LifetimeLoanTech (
   tech text,
   loan real,
   loan_notes text,
   PRIMARY KEY(tech),
   FOREIGN KEY(tech) REFERENCES technologies(tech) );
INSERT INTO "LifetimeLoanTech" VALUES('E01',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('RL1',10,'');


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
INSERT INTO "CapacityFactorTech" VALUES('inter','day','E01',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('inter','night','E01',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('winter','day','E01',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('winter','night','E01',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('summer','day','E01',0.8,'');
INSERT INTO "CapacityFactorTech" VALUES('summer','night','E01',0.8,'');

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
INSERT INTO "Efficiency" VALUES('ethos','IMPHCO1',1990,'HCO',1.00,'');
INSERT INTO "Efficiency" VALUES('HCO','E01',1960,'ELC',0.32,'# 1/3.125');
INSERT INTO "Efficiency" VALUES('HCO','E01',1970,'ELC',0.32,'# 1/3.125');
INSERT INTO "Efficiency" VALUES('HCO','E01',1980,'ELC',0.32,'# 1/3.125');
INSERT INTO "Efficiency" VALUES('HCO','E01',1990,'ELC',0.32,'# 1/3.125');
 INSERT INTO "Efficiency" VALUES('HCO','E01',2000,'ELC',0.32,'# 1/3.125');
 INSERT INTO "Efficiency" VALUES('HCO','E01',2010,'ELC',0.32,'# 1/3.125');
 INSERT INTO "Efficiency" VALUES('ELC','RL1',1980,'RL',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','RL1',1990,'RL',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','RL1',2000,'RL',1.00,'# direct translation from DMD_EFF');
 INSERT INTO "Efficiency" VALUES('ELC','RL1',2010,'RL',1.00,'# direct translation from DMD_EFF');

CREATE TABLE ExistingCapacity (
   tech text,
   vintage integer,
   exist_cap real,
   exist_cap_units text,
   exist_cap_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
INSERT INTO "ExistingCapacity" VALUES('E01',1960,0.175,'','');
INSERT INTO "ExistingCapacity" VALUES('E01',1970,0.175,'','');
INSERT INTO "ExistingCapacity" VALUES('E01',1980,0.15,'','');
INSERT INTO "ExistingCapacity" VALUES('RL1',1980,5.6,'','');

 CREATE TABLE CostInvest (
   tech text,
   vintage integer,
   cost_invest real,
   cost_invest_units text,
   cost_invest_notes text,
   PRIMARY KEY(tech, vintage),
   FOREIGN KEY(tech) REFERENCES technologies(tech),
   FOREIGN KEY(vintage) REFERENCES time_periods(t_periods) );
 INSERT INTO "CostInvest" VALUES('E01',1990,2000,'','');
 INSERT INTO "CostInvest" VALUES('E01',2000,1300,'','');
 INSERT INTO "CostInvest" VALUES('E01',2010,1200,'','');

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
 INSERT INTO "CostFixed" VALUES(1990,'E01',1960,40,'','');
 INSERT INTO "CostFixed" VALUES(1990,'E01',1970,40,'','');
 INSERT INTO "CostFixed" VALUES(1990,'E01',1980,40,'','');
 INSERT INTO "CostFixed" VALUES(1990,'E01',1990,40,'','');
 INSERT INTO "CostFixed" VALUES(2000,'E01',1970,70,'','');
 INSERT INTO "CostFixed" VALUES(2000,'E01',1980,70,'','');
 INSERT INTO "CostFixed" VALUES(2000,'E01',1990,70,'','');
 INSERT INTO "CostFixed" VALUES(2000,'E01',2000,70,'','');
 INSERT INTO "CostFixed" VALUES(2010,'E01',1980,100,'','');
 INSERT INTO "CostFixed" VALUES(2010,'E01',1990,100,'','');
 INSERT INTO "CostFixed" VALUES(2010,'E01',2000,100,'','');
 INSERT INTO "CostFixed" VALUES(2010,'E01',2010,100,'','');
 INSERT INTO "CostFixed" VALUES(1990,'RL1',1980, 9.46,'','');
 INSERT INTO "CostFixed" VALUES(1990,'RL1',1990, 9.46,'','');
 INSERT INTO "CostFixed" VALUES(2000,'RL1',2000, 9.46,'','');
 INSERT INTO "CostFixed" VALUES(2010,'RL1',2010, 9.46,'','');

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


 INSERT INTO "CostVariable" VALUES(1990,'IMPHCO1',1990,2,'','');
 INSERT INTO "CostVariable" VALUES(2000,'IMPHCO1',1990,2,'','');
 INSERT INTO "CostVariable" VALUES(2010,'IMPHCO1',1990,2,'','');


 INSERT INTO "CostVariable" VALUES(1990,'E01',1960,0.3,'','');
 INSERT INTO "CostVariable" VALUES(1990,'E01',1970,0.3,'','');
 INSERT INTO "CostVariable" VALUES(1990,'E01',1980,0.3,'','');
 INSERT INTO "CostVariable" VALUES(1990,'E01',1990,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2000,'E01',1970,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2000,'E01',1980,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2000,'E01',1990,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2000,'E01',2000,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2010,'E01',1980,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2010,'E01',1990,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2010,'E01',2000,0.3,'','');
 INSERT INTO "CostVariable" VALUES(2010,'E01',2010,0.3,'','');


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
