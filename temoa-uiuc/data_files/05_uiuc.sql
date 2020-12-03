/*
This scenario adds a transportation sector to UIUC.
All transportation demand is measured by the energy equivalent of gasoline.
*/
BEGIN TRANSACTION;
CREATE TABLE "time_season" (
	"t_season"	text,
	PRIMARY KEY("t_season")
);
INSERT INTO "time_season" VALUES ('inter');
INSERT INTO "time_season" VALUES ('summer');
INSERT INTO "time_season" VALUES ('winter');


CREATE TABLE "time_periods" (
	"t_periods"	integer,
	"flag"	text,
	FOREIGN KEY("flag") REFERENCES "time_period_labels"("t_period_labels"),
	PRIMARY KEY("t_periods")
);
-- UIUC Data
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


CREATE TABLE "time_period_labels" (
	"t_period_labels"	text,
	"t_period_labels_desc"	text,
	PRIMARY KEY("t_period_labels")
);
INSERT INTO "time_period_labels" VALUES ('e','existing vintages');
INSERT INTO "time_period_labels" VALUES ('f','future');


CREATE TABLE "time_of_day" (
	"t_day"	text,
	PRIMARY KEY("t_day")
);
INSERT INTO "time_of_day" VALUES ('day');
INSERT INTO "time_of_day" VALUES ('night');


CREATE TABLE "technology_labels" (
	"tech_labels"	text,
	"tech_labels_desc"	text,
	PRIMARY KEY("tech_labels")
);
INSERT INTO "technology_labels" VALUES ('r','resource technology');
INSERT INTO "technology_labels" VALUES ('p','production technology');
INSERT INTO "technology_labels" VALUES ('pb','baseload production technology');
INSERT INTO "technology_labels" VALUES ('ps','storage production technology');


CREATE TABLE "technologies" (
	"tech"	text,
	"flag"	text,
	"sector"	text,
	"tech_desc"	text,
	"tech_category"	text,
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("flag") REFERENCES "technology_labels"("tech_labels"),
	PRIMARY KEY("tech")
);
-- UIUC Data
INSERT INTO "technologies" VALUES('IMPWIND','p','electric', 'imported wind energy','electricity');
INSERT INTO "technologies" VALUES('IMPSOL','p','electric', 'imported solar energy','electricity');
INSERT INTO "technologies" VALUES('IMPELC','r','electric', 'imported electricity','MISO');
INSERT INTO "technologies" VALUES('IMPNATGAS','r','supply', 'imported natural gas','natural gas');
INSERT INTO "technologies" VALUES('ABBOTT','pb','industrial', 'natural gas power plant','steam');
INSERT INTO "technologies" VALUES('TURBINE', 'p', 'electric', 'turbine that converts steam to elc', 'electricity');
INSERT INTO "technologies" VALUES('UL', 'p', 'electric', 'university lighting', 'electricity');
INSERT INTO "technologies" VALUES('UH', 'p', 'industrial', 'university heating', 'steam');
INSERT INTO "technologies" VALUES('NUCLEAR', 'pb', 'steam', 'micro nuclear power plant', 'electricity');
INSERT INTO "technologies" VALUES('IMPGSL','r','supply', 'imported gasoline','gasoline');
INSERT INTO "technologies" VALUES('GSLVCL','r','transport', 'imported gasoline','gasoline');



CREATE TABLE "sector_labels" (
	"sector"	text,
	PRIMARY KEY("sector")
);
INSERT INTO "sector_labels" VALUES ('supply');
INSERT INTO "sector_labels" VALUES ('electric');
INSERT INTO "sector_labels" VALUES ('transport');
INSERT INTO "sector_labels" VALUES ('commercial');
INSERT INTO "sector_labels" VALUES ('residential');
INSERT INTO "sector_labels" VALUES ('industrial');


CREATE TABLE "regions" (
	"regions"	TEXT,
	"region_note"	TEXT,
	PRIMARY KEY("regions")
);
INSERT INTO "regions" VALUES ('uiuc', 'the University of Illinois');


CREATE TABLE "commodity_labels" (
	"comm_labels"	text,
	"comm_labels_desc"	text,
	PRIMARY KEY("comm_labels")
);
INSERT INTO "commodity_labels" VALUES ('p','physical commodity');
INSERT INTO "commodity_labels" VALUES ('e','emissions commodity');
INSERT INTO "commodity_labels" VALUES ('d','demand commodity');


CREATE TABLE "commodities" (
	"comm_name"	text,
	"flag"	text,
	"comm_desc"	text,
	FOREIGN KEY("flag") REFERENCES "commodity_labels"("comm_labels"),
	PRIMARY KEY("comm_name")
);
-- UIUC Data
INSERT INTO "commodities" VALUES('spent-fuel','e','spent nuclear fuel');
INSERT INTO "commodities" VALUES('ewaste','e','waste from solar and wind');
INSERT INTO "commodities" VALUES('co2eq','e','co2 equivalent');
INSERT INTO "commodities" VALUES('ethos','p','# dummy commodity');
INSERT INTO "commodities" VALUES('GAS', 'p', 'natural gas');
INSERT INTO "commodities" VALUES('GSL', 'p', 'gasoline');
INSERT INTO "commodities" VALUES('ELC', 'p', 'electricity');
INSERT INTO "commodities" VALUES('STM','p','steam');
INSERT INTO "commodities" VALUES('UELC', 'd', 'university electricity');
INSERT INTO "commodities" VALUES('USTM','d','university steam');
INSERT INTO "commodities" VALUES('UVCL','d','university vehicle fleet');

CREATE TABLE "TechOutputSplit" (
	"regions"	TEXT,
	"periods"	integer,
	"tech"	TEXT,
	"output_comm"	text,
	"to_split"	real,
	"to_split_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech","output_comm")
);


CREATE TABLE "TechInputSplit" (
	"regions"	TEXT,
	"periods"	integer,
	"input_comm"	text,
	"tech"	text,
	"ti_split"	real,
	"ti_split_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","input_comm","tech")
);



CREATE TABLE "SegFrac" (
	"season_name"	text,
	"time_of_day_name"	text,
	"segfrac"	real CHECK("segfrac" >= 0 AND "segfrac" <= 1),
	"segfrac_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	PRIMARY KEY("season_name","time_of_day_name")
);
INSERT INTO "SegFrac" VALUES ('inter','day',0.1667,'# I-D');
INSERT INTO "SegFrac" VALUES ('inter','night',0.0833,'# I-N');
INSERT INTO "SegFrac" VALUES ('summer','day',0.1667,'# S-D');
INSERT INTO "SegFrac" VALUES ('summer','night',0.0833,'# S-N');
INSERT INTO "SegFrac" VALUES ('winter','day',0.3333,'# W-D');
INSERT INTO "SegFrac" VALUES ('winter','night',0.1667,'# W-N');

CREATE TABLE "MinCapacity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"mincap"	real,
	"mincap_units"	text,
	"mincap_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);


CREATE TABLE "MinActivity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"minact"	real,
	"minact_units"	text,
	"minact_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);
--UIUC Data
INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'IMPSOL', 6.88, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2022, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2023, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2024, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2025, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2026, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2027, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2028, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2029, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2030, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
-- until 2026 because that's when'uiuc',  the PPA ends, then we can buy more if we choose.
INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2022, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2023, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2024, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2025, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2026, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');


CREATE TABLE "MaxCapacity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"maxcap"	real,
	"maxcap_units"	text,
	"maxcap_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);
--UIUC Data
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- We are assuming that we can ad'uiuc', d 12.1 MWe capacity every 6 years.
-- This should be constrained bec'uiuc', ause we can't add an arbitrary amount of solar
-- power.
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'IMPSOL', 4.68, 'MWe', 'after Solar Farm 2.0');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'IMPSOL', 16.78, 'MWe', 'solar PPA');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
--'uiuc',
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
-- Abbott should be capped at its'uiuc',  current capacity because we are trying to
-- retire part of its capacity
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
--
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'TURBINE', 85, 'MWth', 'Max capacity of abbott');
--
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'NUCLEAR', 100, 'MWth', 'max smr capacity');

CREATE TABLE "MaxActivity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"maxact"	real,
	"maxact_units"	text,
	"maxact_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","periods","tech")
);
INSERT INTO "MaxActivity" VALUES('uiuc', 2021, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2022, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2023, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2024, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2025, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2026, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2027, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2028, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2029, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
INSERT INTO "MaxActivity" VALUES('uiuc', 2030, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- -- Previous value: 1051 GWh imported.
-- -- Imports have never exceeded 60% of demand.
INSERT INTO "MaxActivity" VALUES('uiuc', 2021, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2022, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2023, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2024, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2025, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2026, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2027, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2028, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2029, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
INSERT INTO "MaxActivity" VALUES('uiuc', 2030, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');

-- INSERT INTO "MaxActivity" VALUES('uiuc', 2021, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2022, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2023, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2024, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2025, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2026, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2027, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2028, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2029, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2030, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');



CREATE TABLE "LifetimeTech" (
	"regions"	text,
	"tech"	text,
	"life"	real,
	"life_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
--UIUC data
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPELC',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPNATGAS',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPGSL',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'TURBINE',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPWIND',10,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPSOL',25,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'UL',40,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'UH',40,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'ABBOTT',40,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'GSLVCL',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'NUCLEAR',60,'');


CREATE TABLE "LifetimeProcess" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"life_process"	real,
	"life_process_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);
--UIUC data
-- INSERT INTO "LifetimeProcess" VALUES('uiuc', 'UL',2000,1000,'#forexistingcap');
-- INSERT INTO "LifetimeProcess" VALUES('uiuc', 'UH',2000,1000,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('uiuc', 'ABBOTT',2000,60,'#forexistingcap');
INSERT INTO "LifetimeProcess" VALUES('uiuc', 'TURBINE',2000,60,'#forexistingcap');

CREATE TABLE "LifetimeLoanTech" (
	"regions"	text,
	"tech"	text,
	"loan"	real,
	"loan_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
--UIUC data
INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'UL',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'UH',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'ABBOTT',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'TURBINE',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'NUCLEAR',40,'');


CREATE TABLE "GrowthRateSeed" (
	"regions"	text,
	"tech"	text,
	"growthrate_seed"	real,
	"growthrate_seed_units"	text,
	"growthrate_seed_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);


CREATE TABLE "GrowthRateMax" (
	"regions"	text,
	"tech"	text,
	"growthrate_max"	real,
	"growthrate_max_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);


CREATE TABLE "GlobalDiscountRate" (
	"rate"	real
);
INSERT INTO "GlobalDiscountRate" VALUES (0.05);


CREATE TABLE "ExistingCapacity" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"exist_cap"	real,
	"exist_cap_units"	text,
	"exist_cap_notes"	text,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech","vintage")
);
--UIUC data
-- INSERT INTO "ExistingCapacity" VALUES('uiuc', 'IMPGSL', 2020, 1000, 'gallons','');
-- INSERT INTO "ExistingCapacity" VALUES('uiuc', 'GSLVCL', 2020, 1000, 'gallons','');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'IMPELC', 2020, 60, 'units: MWe', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'ABBOTT', 2000, 257, 'units: MWth', '');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'TURBINE', 2000, 85, 'units: MWe','');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'IMPWIND', 2016, 8.6, 'units: MWe', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'IMPSOL', 2016, 4.68, 'units: MWe', 'if 100% to electricity');


CREATE TABLE "EmissionLimit" (
	"regions"	text,
	"periods"	integer,
	"emis_comm"	text,
	"emis_limit"	real,
	"emis_limit_units"	text,
	"emis_limit_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("emis_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","periods","emis_comm")
);
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2021, 'co2eq', 391.031, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2022, 'co2eq', 379.500, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2023, 'co2eq', 367.968, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2024, 'co2eq', 356.437, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2025, 'co2eq', 344.906, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2026, 'co2eq', 331.110, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2027, 'co2eq', 317.314, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2028, 'co2eq', 303.517, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2029, 'co2eq', 289.721, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2030, 'co2eq', 275.925, 'kilo-tCO2', 'projection from iCAP');

CREATE TABLE "EmissionActivity" (
	"regions"	text,
	"emis_comm"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"emis_act"	real,
	"emis_act_units"	text,
	"emis_act_notes"	text,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("emis_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","emis_comm","input_comm","tech","vintage","output_comm")
);
-- UIUC data
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2000,'STM',0.26,'tCO2/MWth','from iCAP');
-- INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2020,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2021,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2022,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2023,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2024,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2025,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2026,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2027,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2028,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2029,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2030,'STM',0.26,'tCO2/MWth','from iCAP');
--'uiuc',
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2000,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2020,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2021,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2022,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2023,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2024,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2025,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2026,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2027,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2028,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2029,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2030,'ELC',0.825,'tCO2/MWe','from iCAP');
--
-- INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2020,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2021,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2022,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2023,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2024,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2025,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2026,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2027,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2028,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2029,'UVCL',0.00889,'tCO2/Gal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2030,'UVCL',0.00889,'tCO2/Gal','from F&S');
-- Solar Panel and Wind Turbine Waste
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2016,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2021,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2022,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2023,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2024,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2025,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2026,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2027,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2028,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2029,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2030,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2016,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2021,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2022,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2023,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2024,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2025,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2026,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2027,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2028,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2029,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2030,'ELC',0.2104,'kg/MWe','from waste calc');
-- Nuclear Reactor Waste
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2021,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2022,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2023,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2024,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2025,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2026,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2027,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2028,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2029,'STM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2030,'STM',0.000815,'kg/MWth','from waste calc');



CREATE TABLE "Efficiency" (
	"regions"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"efficiency"	real CHECK("efficiency" > 0),
	"eff_notes"	text,
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","input_comm","tech","vintage","output_comm")
);
--UIUC data
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPNATGAS', 2021, 'GAS', 1.00,'pure gas import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2000, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2020, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2021, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2022, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2023, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2024, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2025, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2026, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2027, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2028, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2029, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2030, 'ELC', 1.00,'pure electricity import');
-- Vehicle demand
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPGSL', 2021, 'GSL', 1.00,'pure gasoline import');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2021, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2022, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2023, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2024, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2025, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2026, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2027, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2028, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2029, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2030, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
--Defines the ABBOTT parameters
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2000, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2021, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2022, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2023, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2024, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2025, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2026, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2027, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2028, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2029, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2030, 'STM', 1.00, 'Converts steam to steam? Unsure.');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2000, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2021, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2022, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2023, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2024, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2025, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2026, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2027, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2028, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2029, 'ELC', 0.33, 'converts STM to ELC');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2030, 'ELC', 0.33, 'converts STM to ELC');
-- Define nuclear here
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2021, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2022, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2023, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2024, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2025, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2026, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2027, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2028, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2029, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2030, 'STM', 1.00, 'Converts steam to steam? Unsure.');
-- Define renewables here
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2016, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2021, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2022, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2023, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2024, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2025, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2026, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2027, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2028, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2029, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2030, 'ELC', 1.00,'pure electricity imports');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2016, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2021, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2022, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2023, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2024, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2025, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2026, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2027, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2028, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2029, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2030, 'ELC', 1.00,'pure electricity imports');
-- Define what happens to intermediate commodities here
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2021, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2022, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2023, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2024, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2025, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2026, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2027, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2028, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2029, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2030, 'UELC', 1.00,'');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2021, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2022, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2023, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2024, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2025, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2026, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2027, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2028, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2029, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2030, 'USTM', 1.00,'');

CREATE TABLE "DiscountRate" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"tech_rate"	real,
	"tech_rate_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);


CREATE TABLE "DemandSpecificDistribution" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"demand_name"	text,
	"dds"	real CHECK("dds" >= 0 AND "dds" <= 1),
	"dds_notes"	text,
	FOREIGN KEY("demand_name") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	PRIMARY KEY("regions","season_name","time_of_day_name","demand_name")
);
--UIUC Data
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','inter','day','UELC',0.25,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','inter','night','UELC',0.24,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','winter','day','UELC',0.112,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','winter','night','UELC',0.108,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','summer','day','UELC',0.148,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','summer','night','UELC',0.142,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','inter','day','USTM',0.219,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','inter','night','USTM',0.218,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','winter','day','USTM',0.19,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','winter','night','USTM',0.189,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','summer','day','USTM',0.092,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','summer','night','USTM',0.092,'');


CREATE TABLE "Demand" (
	"regions"	text,
	"periods"	integer,
	"demand_comm"	text,
	"demand"	real,
	"demand_units"	text,
	"demand_notes"	text,
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("demand_comm") REFERENCES "commodities"("comm_name"),
	PRIMARY KEY("regions","periods","demand_comm")
);
--UIUC Data: Assumes 1% growth
INSERT INTO "Demand" VALUES('uiuc',2021, 'UELC', 478.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2022, 'UELC', 482.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2023, 'UELC', 486.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2024, 'UELC', 490.8, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2025, 'UELC', 494.9, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2026, 'UELC', 499.0, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2027, 'UELC', 503.2, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2028, 'UELC', 507.5, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2029, 'UELC', 511.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2030, 'UELC', 516.1, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2021, 'USTM', 599.2, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2022, 'USTM', 605.2, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2023, 'USTM', 611.2, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2024, 'USTM', 617.4, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2025, 'USTM', 623.5, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2026, 'USTM', 629.8, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2027, 'USTM', 636.1, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2028, 'USTM', 642.4, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2029, 'USTM', 648.8, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2030, 'USTM', 655.3, 'thermal GWh', 'from 2015 eDNA data');
-- Assumes 1% growth
INSERT INTO "Demand" VALUES('uiuc',2021, 'UVCL', 129.3, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2022, 'UVCL', 130.6, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2023, 'UVCL', 131.9, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2024, 'UVCL', 133.2, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2025, 'UVCL', 134.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2026, 'UVCL', 135.8, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2027, 'UVCL', 137.0, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2028, 'UVCL', 138.3, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2029, 'UVCL', 139.6, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2030, 'UVCL', 140.9, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');


CREATE TABLE "CostVariable" (
	"regions"	text NOT NULL,
	"periods"	integer NOT NULL,
	"tech"	text NOT NULL,
	"vintage"	integer NOT NULL,
	"cost_variable"	real,
	"cost_variable_units"	text,
	"cost_variable_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","tech","vintage")
);
--uiuc data
INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPGSL', 2021, 0.0025, 'M$/k_GAL', 'typical gasoline price');


CREATE TABLE "CostInvest" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"cost_invest"	real,
	"cost_invest_units"	text,
	"cost_invest_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","tech","vintage")
);
--UIUC Data
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2021, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2021, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2021, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2021, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');


CREATE TABLE "CostFixed" (
	"regions"	text NOT NULL,
	"periods"	integer NOT NULL,
	"tech"	text NOT NULL,
	"vintage"	integer NOT NULL,
	"cost_fixed"	real,
	"cost_fixed_units"	text,
	"cost_fixed_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","periods","tech","vintage")
);


CREATE TABLE "CapacityToActivity" (
	"regions"	text,
	"tech"	text,
	"c2a"	real,
	"c2a_notes"	TEXT,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
--UIUC data
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'ABBOTT',8.76, 'thermal GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'TURBINE', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'UL', 1, '');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'UH', 1, '');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPGSL', 1, 'k_gal');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPELC', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPSOL', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPWIND', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'NUCLEAR', 8.76, 'thermal GWh');

CREATE TABLE "CapacityFactorTech" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"tech"	text,
	"cf_tech"	real CHECK("cf_tech" >= 0 AND "cf_tech" <= 1),
	"cf_tech_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","season_name","time_of_day_name","tech")
);
--uiuc data
INSERT INTO "CapacityFactorTech" VALUES('uiuc','inter', 'day', 'IMPSOL',0.336,'average CF for UIUC farm');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','inter', 'night', 'IMPSOL',0,'no solar at night');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','winter', 'day', 'IMPSOL',0.336,'average CF for UIUC farm');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','winter', 'night', 'IMPSOL',0,'no solar at night');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','summer', 'day', 'IMPSOL',0.336,'average CF for UIUC farm');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','summer', 'night', 'IMPSOL',0,'no solar at night');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','inter', 'day', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','inter', 'night', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','winter', 'day', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','winter', 'night', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','summer', 'day', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','summer', 'night', 'IMPWIND', 0.31,'average annual CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','inter', 'day', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','inter', 'night', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','winter', 'day', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','winter', 'night', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','summer', 'day', 'NUCLEAR', 0.92,'average nuclear CF');
INSERT INTO "CapacityFactorTech" VALUES('uiuc','summer', 'night', 'NUCLEAR', 0.92,'average nuclear CF');

CREATE TABLE "CapacityFactorProcess" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"tech"	text,
	"vintage"	integer,
	"cf_process"	real CHECK("cf_process" >= 0 AND "cf_process" <= 1),
	"cf_process_notes"	text,
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	PRIMARY KEY("regions","season_name","time_of_day_name","tech","vintage")
);


/*
-------------------------------------------------------
Extra Tables
-------------------------------------------------------
*/

CREATE TABLE "PlanningReserveMargin" (
	"regions"	text,
	"reserve_margin"	REAL,
	PRIMARY KEY(regions),
	FOREIGN KEY("regions") REFERENCES regions
);

CREATE TABLE "MyopicBaseyear" (
	"year"	real
	"notes"	text
);
CREATE TABLE "MinGenGroupWeight" (
	"regions"	text,
	"tech"	text,
	"group_name"	text,
	"act_fraction"	REAL,
	"tech_desc"	text,
	PRIMARY KEY("tech","group_name","regions")
);
CREATE TABLE "MinGenGroupTarget" (
	"regions"	text,
	"periods"	integer,
	"group_name"	text,
	"min_act_g"	real,
	"notes"	text,
	PRIMARY KEY("periods","group_name","regions")
);


CREATE TABLE "tech_reserve" (
	"tech"	text,
	"notes"	text,
	PRIMARY KEY("tech")
);
CREATE TABLE "tech_exchange" (
	"tech"	text,
	"notes"	text,
	PRIMARY KEY("tech")
);
CREATE TABLE "tech_curtailment" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);
CREATE TABLE "tech_annual" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);

CREATE TABLE "CapacityCredit" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"cf_tech"	real CHECK("cf_tech" >= 0 AND "cf_tech" <= 1),
	"cf_tech_notes"	text,
	PRIMARY KEY("regions","periods","tech")
);

CREATE TABLE "StorageDuration" (
	"regions"	text,
	"tech"	text,
	"duration"	real,
	"duration_notes"	text,
	PRIMARY KEY("regions","tech")
);

CREATE TABLE "groups" (
	"group_name"	text,
	"notes"	text,
	PRIMARY KEY("group_name")
);


/*
-------------------------------------------------------
Tables in this section store model outputs
-------------------------------------------------------
*/

CREATE TABLE "Output_V_Capacity" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"tech"	text,
	"vintage"	integer,
	"capacity"	real,
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","tech","vintage")
);
CREATE TABLE "Output_VFlow_Out" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"vflow_out"	real,
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);
CREATE TABLE "Output_VFlow_In" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"vflow_in"	real,
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);
CREATE TABLE "Output_Objective" (
	"scenario"	text,
	"objective_name"	text,
	"total_system_cost"	real
);
CREATE TABLE "Output_Emissions" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"emissions_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"emissions"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("emissions_comm") REFERENCES "EmissionActivity"("emis_comm"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","t_periods","emissions_comm","tech","vintage")
);
CREATE TABLE "Output_Curtailment" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"curtailment"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm")
);
CREATE TABLE "Output_Costs" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"output_name"	text,
	"tech"	text,
	"vintage"	integer,
	"output_cost"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	PRIMARY KEY("regions","scenario","output_name","tech","vintage")
);
CREATE TABLE "Output_CapacityByPeriodAndTech" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"tech"	text,
	"capacity"	real,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	PRIMARY KEY("regions","scenario","t_periods","tech")
);


COMMIT;
