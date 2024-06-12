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
INSERT INTO "time_periods" VALUES(2032, 'f');
INSERT INTO "time_periods" VALUES(2033, 'f');
INSERT INTO "time_periods" VALUES(2034, 'f');
INSERT INTO "time_periods" VALUES(2035, 'f');
INSERT INTO "time_periods" VALUES(2036, 'f');
INSERT INTO "time_periods" VALUES(2037, 'f');
INSERT INTO "time_periods" VALUES(2038, 'f');
INSERT INTO "time_periods" VALUES(2039, 'f');
INSERT INTO "time_periods" VALUES(2040, 'f');
INSERT INTO "time_periods" VALUES(2041, 'f');
INSERT INTO "time_periods" VALUES(2042, 'f');
INSERT INTO "time_periods" VALUES(2043, 'f');
INSERT INTO "time_periods" VALUES(2044, 'f');
INSERT INTO "time_periods" VALUES(2045, 'f');
INSERT INTO "time_periods" VALUES(2046, 'f');
INSERT INTO "time_periods" VALUES(2047, 'f');
INSERT INTO "time_periods" VALUES(2048, 'f');
INSERT INTO "time_periods" VALUES(2049, 'f');
INSERT INTO "time_periods" VALUES(2050, 'f');
INSERT INTO "time_periods" VALUES(2051, 'f');


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
INSERT INTO "technologies" VALUES('NBINE', 'p', 'electric', 'turbine that converts nuclear steam to elc', 'electricity');
INSERT INTO "technologies" VALUES('UL', 'p', 'electric', 'university lighting', 'electricity');
INSERT INTO "technologies" VALUES('UH', 'p', 'industrial', 'university heating', 'steam');
INSERT INTO "technologies" VALUES('NUCLEAR', 'pb', 'steam', 'micro nuclear power plant', 'electricity');
INSERT INTO "technologies" VALUES('IMPGSL','r','supply', 'imported gasoline','gasoline');
INSERT INTO "technologies" VALUES('GSLVCL','r','transport', 'imported gasoline','gasoline');
INSERT INTO "technologies" VALUES('IMPDSL','r','supply', 'imported diesl','diesel');
INSERT INTO "technologies" VALUES('DSLVCL','r','transport', 'diesel vehicle','diesel');
INSERT INTO "technologies" VALUES('IMPE85','r','supply', 'imported E85','E85');
INSERT INTO "technologies" VALUES('E85VCL','r','transport', 'E85 vehicle','E85');
INSERT INTO "technologies" VALUES('ELCVCL','r','transport', 'electric vehicle','electricity');
INSERT INTO "technologies" VALUES('IMPH2','r','transport', 'imported hydrogen','hydrogen');
INSERT INTO "technologies" VALUES('H2VCL','r','transport', 'hydrogen vehicle','hydrogen');
INSERT INTO "technologies" VALUES('ELECTROL', 'p', 'electric', 'electrolysis converts elc to h2', 'hydrogen');
INSERT INTO "technologies" VALUES('CHWS','p','electric','chw production','chilled water production');
INSERT INTO "technologies" VALUES('GEOT', 'p', 'electric', 'geothermal plant', 'steam');
INSERT INTO "technologies" VALUES('GH', 'p', 'electric', 'dummy geothermal plant to convert units', 'steam');
INSERT INTO "technologies" VALUES('GC', 'p', 'electric', 'dummy geothermal plant to convert units', 'chilled water');


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
INSERT INTO "commodities" VALUES('DSL', 'p', 'diesel');
INSERT INTO "commodities" VALUES('E85', 'p', 'E85');
INSERT INTO "commodities" VALUES('H2', 'p', 'hydrogen');
INSERT INTO "commodities" VALUES('ELC', 'p', 'electricity');
INSERT INTO "commodities" VALUES('STM','p','steam');
INSERT INTO "commodities" VALUES('NSTM','p','nuclear steam');
INSERT INTO "commodities" VALUES('UELC', 'd', 'university electricity');
INSERT INTO "commodities" VALUES('USTM','d','university steam');
INSERT INTO "commodities" VALUES('UVCL','d','university vehicle fleet');
INSERT INTO "commodities" VALUES('UCWS','d','university chilled water');
INSERT INTO "commodities" VALUES('GSTM', 'p', 'dummy geothermal steam');
INSERT INTO "commodities" VALUES('GCWS', 'p', 'dummy geothermal chilled water');


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
--
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2021,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2022,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2023,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2024,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2025,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2026,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2027,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2028,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2029,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2030,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2031,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2032,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2033,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2034,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2035,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2036,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2037,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2038,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2039,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2040,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2041,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2042,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2043,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2044,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2045,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2046,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2047,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2048,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2049,'GEOT','GSTM', 0.55,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2050,'GEOT','GSTM', 0.55,'');
--
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2021,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2022,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2023,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2024,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2025,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2026,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2027,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2028,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2029,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2030,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2031,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2032,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2033,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2034,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2035,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2036,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2037,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2038,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2039,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2040,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2041,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2042,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2043,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2044,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2045,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2046,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2047,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2048,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2049,'GEOT','GCWS', 0.45,'');
INSERT INTO "TechOutputSplit" VALUES ('uiuc',2050,'GEOT','GCWS', 0.45,'');


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
-- INSERT INTO "TechInputSplit" VALUES('uiuc', 2021, )


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
INSERT INTO "MinActivity" VALUES('uiuc', 2031, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2032, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2033, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2034, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2035, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2036, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2037, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2038, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2039, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2040, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2041, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2042, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2043, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2044, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2045, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2046, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2047, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2048, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2049, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2050, 'IMPSOL', 24.69, 'electric GWh','must buy electricity that is produced');
-- until 2026 because that's when'uiuc',  the PPA ends, then we can buy more if we choose.
INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2022, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2023, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2024, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2025, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
INSERT INTO "MinActivity" VALUES('uiuc', 2026, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2027, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2028, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2029, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2030, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2031, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2032, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2033, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2034, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2035, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2036, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2037, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2038, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2039, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2040, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2041, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2042, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2043, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2044, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2045, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2046, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2047, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2048, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2049, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2050, 'IMPWIND', 23.35, 'electric GWh','must buy electricity that is produced');
--
-- INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'GSLVCL', 91.925, 'kgal','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'DSLVCL', 20.9, 'kgal','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'E85VCL', 16.4, 'kgal','');
--
INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'GSLVCL', 408.713, 'kgal','');
INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'DSLVCL', 116.828, 'kgal','');
INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'E85VCL', 25.727, 'kgal','');
--
-- INSERT INTO "MinActivity" VALUES('uiuc', 2021, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2022, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2023, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2024, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2025, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2026, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2027, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2028, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2029, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2030, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2031, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2032, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2033, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2034, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2035, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2036, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2037, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2038, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2039, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2040, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2041, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2042, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2043, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2044, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2045, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2046, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2047, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2048, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2049, 'CHWS', 80, 'electric GWh','');
-- INSERT INTO "MinActivity" VALUES('uiuc', 2050, 'CHWS', 80, 'electric GWh','');


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
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'IMPWIND', 8.6, 'MWe', 'wind PPA, unless increased');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2031, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2032, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2033, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2034, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2035, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2036, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2037, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2038, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2039, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2040, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2041, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2042, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2043, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2044, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2045, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2046, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2047, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2048, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2049, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2050, 'IMPWIND', 100.5, 'MWe', 'max capacity of railsplitter');
-- We are assuming that we can add 12.1 MWe capacity every 6 years.
-- This should be constrained because we can't add an arbitrary amount of solar
-- power.
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'IMPSOL', 4.68, 'MWe', 'after Solar Farm 2.0');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'IMPSOL', 16.78, 'MWe', 'solar PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'IMPSOL', 16.78, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2031, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2032, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2033, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2034, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2035, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2036, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2037, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2038, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2039, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2040, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2041, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2042, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2043, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2044, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2045, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2046, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2047, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2048, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2049, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2050, 'IMPSOL', 28.9, 'MWe', 'solar 2.0 PPA');
--
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2031, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2032, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2033, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2034, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2035, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2036, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2037, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2038, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2039, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2040, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2041, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2042, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2043, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2044, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2045, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2046, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2047, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2048, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2049, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2050, 'IMPELC', 120, 'MWe', 'UIUC import limits, unless increased');
-- Abbott should be capped at its'uiuc',  current capacity because we are trying to
-- retire part of its capacity
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2031, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2032, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2033, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2034, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2035, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2036, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2037, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2038, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2039, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2040, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2041, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2042, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2043, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2044, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2045, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2046, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2047, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2048, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2049, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2050, 'ABBOTT', 375, 'MWth', 'Max capacity of abbott');
--
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2031, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2032, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2033, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2034, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2035, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2036, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2037, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2038, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2039, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2040, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2041, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2042, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2043, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2044, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2045, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2046, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2047, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2048, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2049, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2050, 'TURBINE', 85, 'MWe', 'Max capacity of abbott');
--
INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2031, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2032, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2033, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2034, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2035, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2036, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2037, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2038, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2039, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2040, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2041, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2042, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2043, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2044, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2045, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2046, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2047, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2048, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2049, 'NBINE', 300, 'MWe', 'Max capacity of abbott');
INSERT INTO "MaxCapacity" VALUES('uiuc', 2050, 'NBINE', 300, 'MWe', 'Max capacity of abbott');

-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2031, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2032, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2033, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2034, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2035, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2036, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2037, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2038, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2039, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2040, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2041, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2042, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2043, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2044, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2045, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2046, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2047, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2048, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2049, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2050, 'NUCLEAR', 100, 'MWth', 'max smr capacity');
--
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2031, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2032, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2033, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2034, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2035, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2036, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2037, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2038, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2039, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2040, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2041, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2042, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2043, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2044, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2045, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2046, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2047, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2048, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2049, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2050, 'CHWS', 26.2, 'MWe', 'max CHWS capacity');
--
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2021, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2022, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2023, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2024, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2025, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2026, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2027, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2028, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2029, 'GEOT', 20., 'MWth', 'max GEOT capacity');
-- INSERT INTO "MaxCapacity" VALUES('uiuc', 2030, 'GEOT', 20., 'MWth', 'max GEOT capacity');


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
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2021, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2022, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2023, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2024, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2025, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2026, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2027, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2028, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2029, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2030, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2031, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2032, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2033, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2034, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2035, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2036, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2037, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2038, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2039, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2040, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2041, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2042, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2043, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2044, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2045, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2046, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2047, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2048, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2049, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2050, 'ABBOTT', 1278.7, 'thermal GWh', 'based on 0.568 average CapFactor');
-- -- Previous value: 1051 GWh imported.
-- -- Imports have never exceeded 60% of demand.
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
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2031, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2032, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2033, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2034, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2035, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2036, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2037, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2038, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2039, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2040, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2041, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2042, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2043, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2044, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2045, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2046, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2047, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2048, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2049, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2050, 'IMPELC', 250, 'electric GWh', '120 MWe imp limit met year round');

-- INSERT INTO "MaxActivity" VALUES('uiuc', 2021, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2022, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2023, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2024, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2025, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2026, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2027, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2028, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2029, 'GEOT', 100, 'electric GWh', '');
-- INSERT INTO "MaxActivity" VALUES('uiuc', 2030, 'GEOT', 100, 'electric GWh', '');


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
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPDSL',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPE85',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPH2',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPWIND',30,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'IMPSOL',25,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'TURBINE',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'NBINE',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'UL',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'UH',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'GSLVCL',25,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'DSLVCL',25,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'E85VCL',25,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'ELCVCL',8,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'H2VCL',8,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'GEOT',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'NUCLEAR',60,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'ABBOTT',40,'');
-- The following entries need reviewing
INSERT INTO "LifetimeTech" VALUES('uiuc', 'CHWS',1000,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'GH',50,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'GC',50,'');
INSERT INTO "LifetimeTech" VALUES('uiuc', 'ELECTROL',1000,'');

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
-- INSERT INTO "LifetimeProcess" VALUES('uiuc', 'TURBINE',2000,60,'#forexistingcap');
-- INSERT INTO "LifetimeProcess" VALUES('uiuc', 'NBINE',2021,60,'#forexistingcap');

CREATE TABLE "LifetimeLoanTech" (
	"regions"	text,
	"tech"	text,
	"loan"	real,
	"loan_notes"	text,
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	PRIMARY KEY("regions","tech")
);
--UIUC data
-- INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'UL',40,'');
-- INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'UH',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'ABBOTT',40,'');
-- INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'TURBINE',40,'');
INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'NUCLEAR',60,'');
-- INSERT INTO "LifetimeLoanTech" VALUES('uiuc', 'NBINE',40,'');


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
-- UIUC data
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'IMPELC', 2020, 60, 'units: MWe', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'ABBOTT', 2000, 257, 'units: MWth', '');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'TURBINE', 2000, 85, 'units: MWe','');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'IMPWIND', 2016, 8.6, 'units: MWe', 'if 100% to electricity');
INSERT INTO "ExistingCapacity" VALUES('uiuc', 'IMPSOL', 2016, 4.68, 'units: MWe', 'if 100% to electricity');
--
INSERT INTO "ExistingCapacity" VALUES('uiuc','GSLVCL', 2020, 0.04666,'units: kgal/h', 'Unleaded fuel consumption');
INSERT INTO "ExistingCapacity" VALUES('uiuc','DSLVCL', 2020, 0.01334,'units: kgal/h', 'Diesel fuel consumption');
INSERT INTO "ExistingCapacity" VALUES('uiuc','E85VCL', 2020, 0.00294,'units: kgal/h', 'E85 fuel consumption');
--
INSERT INTO "ExistingCapacity" VALUES('uiuc','CHWS', 2016, 37.5,'units: kilo-tons', 'UIUC uses only the electric chillers');
INSERT INTO "ExistingCapacity" VALUES('uiuc','GEOT', 2020, 0.1,'units: MWth', '');
INSERT INTO "ExistingCapacity" VALUES('uiuc','GH', 2020, 0.0523,'units: MWth', '');
INSERT INTO "ExistingCapacity" VALUES('uiuc','GC', 2020, 0.01221,'units: kilo-tons', '');


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
-- Data from iCAP and linear regression in data_processing/ghg_emissions.ipynb
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
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2031, 'co2eq', 262.129, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2032, 'co2eq', 248.332, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2033, 'co2eq', 234.536, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2034, 'co2eq', 220.740, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2035, 'co2eq', 206.944, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2036, 'co2eq', 193.147, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2037, 'co2eq', 179.351, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2038, 'co2eq', 165.555, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2039, 'co2eq', 151.759, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2040, 'co2eq', 137.962, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2041, 'co2eq', 124.166, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2042, 'co2eq', 110.370, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2043, 'co2eq', 96.574, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2044, 'co2eq', 82.777, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2045, 'co2eq', 68.981, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2046, 'co2eq', 55.185, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2047, 'co2eq', 41.389, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2048, 'co2eq', 27.592, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2049, 'co2eq', 13.796, 'kilo-tCO2', 'projection from iCAP');
INSERT INTO "EmissionLimit" VALUES ('uiuc', 2050, 'co2eq', 0.000, 'kilo-tCO2', 'projection from iCAP');


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
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2031,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2032,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2033,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2034,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2035,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2036,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2037,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2038,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2039,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2040,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2041,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2042,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2043,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2044,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2045,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2046,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2047,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2048,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2049,'STM',0.26,'tCO2/MWth','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GAS','ABBOTT', 2050,'STM',0.26,'tCO2/MWth','from iCAP');
--
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
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2031,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2032,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2033,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2034,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2035,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2036,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2037,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2038,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2039,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2040,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2041,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2042,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2043,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2044,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2045,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2046,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2047,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2048,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2049,'ELC',0.825,'tCO2/MWe','from iCAP');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'ethos','IMPELC', 2050,'ELC',0.825,'tCO2/MWe','from iCAP');
--
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2020,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2021,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2022,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2023,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2024,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2025,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2026,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2027,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2028,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2029,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2030,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2031,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2032,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2033,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2034,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2035,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2036,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2037,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2038,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2039,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2040,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2041,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2042,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2043,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2044,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2045,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2046,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2047,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2048,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2049,'UVCL',0.00889,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'GSL','GSLVCL', 2050,'UVCL',0.00889,'tCO2/kGal','from F&S');
--
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2020,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2021,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2022,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2023,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2024,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2025,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2026,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2027,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2028,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2029,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2030,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2031,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2032,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2033,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2034,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2035,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2036,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2037,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2038,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2039,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2040,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2041,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2042,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2043,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2044,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2045,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2046,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2047,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2048,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2049,'UVCL',0.01016,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'DSL','DSLVCL', 2050,'UVCL',0.01016,'tCO2/kGal','from F&S');
--
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2020,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2021,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2022,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2023,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2024,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2025,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2026,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2027,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2028,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2029,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2030,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2031,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2032,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2033,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2034,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2035,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2036,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2037,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2038,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2039,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2040,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2041,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2042,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2043,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2044,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2045,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2046,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2047,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2048,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2049,'UVCL',0.00622,'tCO2/kGal','from F&S');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'co2eq', 'E85','E85VCL', 2050,'UVCL',0.00622,'tCO2/kGal','from F&S');
-- Waste from EVs
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2021,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2022,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2023,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2024,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2025,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2026,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2027,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2028,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2029,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2030,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2031,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2032,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2033,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2034,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2035,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2036,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2037,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2038,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2039,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2040,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2041,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2042,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2043,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2044,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2045,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2046,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2047,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2048,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2049,'UVCL',332,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ELC','ELCVCL', 2050,'UVCL',332,'kg/kGal','from waste calc');
-- Waste from FCEVs
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2021,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2022,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2023,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2024,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2025,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2026,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2027,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2028,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2029,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2030,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2031,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2032,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2033,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2034,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2035,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2036,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2037,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2038,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2039,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2040,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2041,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2042,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2043,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2044,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2045,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2046,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2047,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2048,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2049,'UVCL',21.4,'kg/kGal','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'H2','H2VCL', 2050,'UVCL',21.4,'kg/kGal','from waste calc');
-- Solar Panel Waste
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
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2031,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2032,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2033,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2034,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2035,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2036,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2037,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2038,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2039,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2040,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2041,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2042,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2043,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2044,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2045,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2046,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2047,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2048,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2049,'ELC',2.0462,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPSOL', 2050,'ELC',2.0462,'kg/MWe','from waste calc');
-- Wind Turbine Waste
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
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2031,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2032,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2033,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2034,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2035,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2036,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2037,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2038,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2039,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2040,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2041,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2042,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2043,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2044,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2045,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2046,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2047,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2048,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2049,'ELC',0.2104,'kg/MWe','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'ewaste', 'ethos','IMPWIND', 2050,'ELC',0.2104,'kg/MWe','from waste calc');
-- Nuclear Reactor Waste
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2021,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2022,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2023,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2024,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2025,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2026,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2027,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2028,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2029,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2030,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2031,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2032,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2033,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2034,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2035,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2036,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2037,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2038,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2039,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2040,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2041,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2042,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2043,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2044,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2045,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2046,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2047,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2048,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2049,'NSTM',0.000815,'kg/MWth','from waste calc');
INSERT INTO "EmissionActivity" VALUES ('uiuc', 'spent-fuel', 'ethos','NUCLEAR', 2050,'NSTM',0.000815,'kg/MWth','from waste calc');


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
--
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
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2031, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2032, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2033, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2034, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2035, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2036, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2037, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2038, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2039, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2040, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2041, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2042, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2043, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2044, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2045, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2046, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2047, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2048, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2049, 'ELC', 1.00,'pure electricity import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPELC', 2050, 'ELC', 1.00,'pure electricity import');
-- Vehicle demand
-- INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPGSL', 2020, 'GSL', 1.00,'pure gasoline import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPGSL', 2021, 'GSL', 1.00,'pure gasoline import');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2020, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
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
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2031, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2032, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2033, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2034, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2035, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2036, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2037, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2038, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2039, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2040, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2041, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2042, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2043, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2044, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2045, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2046, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2047, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2048, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2049, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSL', 'GSLVCL', 2050, 'UVCL', 1.00,'1 gal gsl = 1 gal gsl');
--
-- INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPDSL', 2020, 'DSL', 1.00,'pure diesel import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPDSL', 2021, 'DSL', 1.00,'pure diesel import');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2020, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2021, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2022, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2023, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2024, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2025, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2026, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2027, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2028, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2029, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2030, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2031, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2032, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2033, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2034, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2035, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2036, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2037, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2038, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2039, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2040, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2041, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2042, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2043, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2044, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2045, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2046, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2047, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2048, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2049, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'DSL', 'DSLVCL', 2050, 'UVCL', 1.155,'1 gal dsl = 1.155 gal gsl');
--
-- INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPE85', 2020, 'E85', 1.00,'pure E85 import');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPE85', 2021, 'E85', 1.00,'pure E85 import');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2020, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2021, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2022, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2023, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2024, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2025, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2026, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2027, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2028, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2029, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2030, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2031, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2032, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2033, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2034, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2035, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2036, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2037, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2038, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2039, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2040, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2041, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2042, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2043, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2044, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2045, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2046, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2047, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2048, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2049, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'E85', 'E85VCL', 2050, 'UVCL', 0.734,'1 gal E85 = 0.734 gal gsl');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2021, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2022, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2023, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2024, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2025, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2026, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2027, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2028, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2029, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2030, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2031, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2032, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2033, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2034, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2035, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2036, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2037, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2038, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2039, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2040, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2041, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2042, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2043, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2044, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2045, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2046, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2047, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2048, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2049, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELCVCL', 2050, 'UVCL', 0.11,'1.0 kWh = 0.11 gal gsl');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPH2', 2021, 'H2', 1.00,'pure hydrogen import');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2021, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2022, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2023, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2024, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2025, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2026, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2027, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2028, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2029, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2030, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2031, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2032, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2033, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2034, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2035, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2036, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2037, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2038, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2039, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2040, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2041, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2042, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2043, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2044, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2045, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2046, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2047, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2048, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2049, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
INSERT INTO "Efficiency" VALUES('uiuc', 'H2', 'H2VCL', 2050, 'UVCL', 2.40,'1 kg h2 = 2.4 gal gsl');
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
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2031, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2032, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2033, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2034, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2035, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2036, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2037, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2038, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2039, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2040, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2041, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2042, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2043, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2044, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2045, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2046, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2047, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2048, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2049, 'STM', 1.00, 'Converts steam to steam? Unsure.');
INSERT INTO "Efficiency" VALUES('uiuc', 'GAS', 'ABBOTT', 2050, 'STM', 1.00, 'Converts steam to steam? Unsure.');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2000, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2021, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2022, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2023, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2024, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2025, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2026, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2027, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2028, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2029, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2030, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2031, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2032, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2033, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2034, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2035, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2036, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2037, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2038, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2039, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2040, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2041, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2042, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2043, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2044, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2045, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2046, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2047, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2048, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2049, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'TURBINE', 2050, 'ELC', 0.6, 'converts STM to ELC, CHP efficiency');
-- Define nuclear here
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2021, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2022, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2023, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2024, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2025, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2026, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2027, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2028, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2029, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2030, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2031, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2032, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2033, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2034, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2035, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2036, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2037, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2038, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2039, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2040, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2041, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2042, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2043, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2044, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2045, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2046, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2047, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2048, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2049, 'NSTM', 1.00, 'Creates steam');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'NUCLEAR', 2050, 'NSTM', 1.00, 'Creates steam');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2021, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2022, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2023, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2024, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2025, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2026, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2027, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2028, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2029, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2030, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2031, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2032, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2033, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2034, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2035, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2036, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2037, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2038, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2039, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2040, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2041, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2042, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2043, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2044, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2045, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2046, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2047, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2048, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2049, 'ELC', 0.33, 'Converts steam to electricity.');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'NBINE', 2050, 'ELC', 0.33, 'Converts steam to electricity.');
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
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2031, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2032, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2033, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2034, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2035, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2036, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2037, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2038, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2039, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2040, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2041, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2042, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2043, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2044, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2045, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2046, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2047, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2048, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2049, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPWIND', 2050, 'ELC', 1.00,'pure electricity imports');
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
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2031, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2032, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2033, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2034, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2035, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2036, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2037, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2038, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2039, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2040, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2041, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2042, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2043, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2044, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2045, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2046, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2047, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2048, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2049, 'ELC', 1.00,'pure electricity imports');
INSERT INTO "Efficiency" VALUES('uiuc', 'ethos', 'IMPSOL', 2050, 'ELC', 1.00,'pure electricity imports');
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
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2031, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2032, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2033, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2034, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2035, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2036, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2037, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2038, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2039, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2040, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2041, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2042, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2043, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2044, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2045, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2046, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2047, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2048, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2049, 'UELC', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'UL', 2050, 'UELC', 1.00,'');
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
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2031, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2032, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2033, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2034, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2035, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2036, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2037, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2038, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2039, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2040, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2041, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2042, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2043, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2044, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2045, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2046, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2047, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2048, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2049, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'STM', 'UH', 2050, 'USTM', 1.00,'');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2021, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2022, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2023, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2024, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2025, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2026, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2027, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2028, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2029, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2030, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2031, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2032, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2033, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2034, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2035, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2036, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2037, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2038, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2039, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2040, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2041, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2042, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2043, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2044, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2045, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2046, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2047, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2048, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2049, 'USTM', 1.00,'');
INSERT INTO "Efficiency" VALUES('uiuc', 'NSTM', 'UH', 2050, 'USTM', 1.00,'');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2021, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2022, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2023, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2024, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2025, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2026, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2027, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2028, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2029, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2030, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2031, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2032, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2033, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2034, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2035, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2036, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2037, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2038, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2039, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2040, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2041, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2042, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2043, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2044, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2045, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2046, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2047, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2048, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2049, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'ELECTROL', 2050, 'H2', 0.67, 'converts ELC to H2 efficiency kWh/kg-H2');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2016, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2021, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2022, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2023, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2024, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2025, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2026, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2027, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2028, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2029, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2030, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2031, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2032, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2033, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2034, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2035, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2036, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2037, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2038, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2039, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2040, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2041, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2042, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2043, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2044, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2045, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2046, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2047, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2048, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2049, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'CHWS', 2050, 'UCWS', 1.286, 'converts electricity to thermal and back to electricity');
-- GEOT
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2020, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2021, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2022, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2023, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2024, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2025, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2026, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2027, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2028, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2029, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2030, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2031, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2032, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2033, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2034, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2035, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2036, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2037, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2038, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2039, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2040, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2041, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2042, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2043, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2044, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2045, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2046, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2047, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2048, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2049, 'GSTM', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2050, 'GSTM', 1.00, 'converts electricity to electricity');
--
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2020, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2021, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2022, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2023, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2024, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2025, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2026, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2027, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2028, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2029, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2030, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2031, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2032, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2033, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2034, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2035, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2036, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2037, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2038, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2039, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2040, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2041, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2042, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2043, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2044, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2045, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2046, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2047, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2048, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2049, 'GCWS', 1.00, 'converts electricity to electricity');
INSERT INTO "Efficiency" VALUES('uiuc', 'ELC', 'GEOT', 2050, 'GCWS', 1.00, 'converts electricity to electricity');
-- GEOT: GH
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2020, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2021, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2022, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2023, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2024, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2025, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2026, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2027, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2028, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2029, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2030, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2031, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2032, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2033, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2034, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2035, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2036, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2037, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2038, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2039, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2040, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2041, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2042, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2043, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2044, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2045, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2046, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2047, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2048, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2049, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GSTM', 'GH', 2050, 'USTM', 3.74, 'converts electricity (MWe) to steam (MWth)');
-- GEOT: GC
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2020, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2021, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2022, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2023, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2024, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2025, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2026, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2027, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2028, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2029, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2030, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2031, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2032, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2033, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2034, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2035, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2036, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2037, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2038, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2039, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2040, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2041, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2042, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2043, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2044, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2045, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2046, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2047, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2048, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2049, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');
INSERT INTO "Efficiency" VALUES('uiuc', 'GCWS', 'GC', 2050, 'UCWS', 1.2229, 'converts electricity (MWe) to chilled water (kilo-tons)');


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
-- this is a guess
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','inter','day','UCWS',0.19,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','inter','night','UCWS',0.189,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','winter','day','UCWS',0.092,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','winter','night','UCWS',0.092,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','summer','day','UCWS',0.219,'');
INSERT INTO "DemandSpecificDistribution" VALUES('uiuc','summer','night','UCWS',0.218,'');


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
INSERT INTO "Demand" VALUES('uiuc',2031, 'UELC', 521.3, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2032, 'UELC', 526.5, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2033, 'UELC', 531.7, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2034, 'UELC', 537.1, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2035, 'UELC', 542.4, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2036, 'UELC', 547.9, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2037, 'UELC', 553.3, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2038, 'UELC', 558.9, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2039, 'UELC', 564.5, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2040, 'UELC', 570.1, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2041, 'UELC', 575.8, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2042, 'UELC', 581.6, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2043, 'UELC', 587.4, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2044, 'UELC', 593.2, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2045, 'UELC', 599.2, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2046, 'UELC', 605.2, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2047, 'UELC', 611.2, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2048, 'UELC', 617.3, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2049, 'UELC', 623.5, 'electric GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2050, 'UELC', 629.7, 'electric GWh', 'from 2015 eDNA data');
--
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
INSERT INTO "Demand" VALUES('uiuc',2031, 'USTM', 661.8, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2032, 'USTM', 668.5, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2033, 'USTM', 675.2, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2034, 'USTM', 681.9, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2035, 'USTM', 688.7, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2036, 'USTM', 695.6, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2037, 'USTM', 702.6, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2038, 'USTM', 709.6, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2039, 'USTM', 716.7, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2040, 'USTM', 723.9, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2041, 'USTM', 731.1, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2042, 'USTM', 738.4, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2043, 'USTM', 745.8, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2044, 'USTM', 753.3, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2045, 'USTM', 760.8, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2046, 'USTM', 768.4, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2047, 'USTM', 776.1, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2048, 'USTM', 783.8, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2049, 'USTM', 791.7, 'thermal GWh', 'from 2015 eDNA data');
INSERT INTO "Demand" VALUES('uiuc',2050, 'USTM', 799.6, 'thermal GWh', 'from 2015 eDNA data');
--
INSERT INTO "Demand" VALUES('uiuc',2021, 'UCWS', 85.74, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2022, 'UCWS', 86.60, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2023, 'UCWS', 87.46, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2024, 'UCWS', 88.34, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2025, 'UCWS', 89.22, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2026, 'UCWS', 90.11, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2027, 'UCWS', 91.01, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2028, 'UCWS', 91.92, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2029, 'UCWS', 92.84, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2030, 'UCWS', 93.77, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2031, 'UCWS', 94.71, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2032, 'UCWS', 95.66, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2033, 'UCWS', 96.61, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2034, 'UCWS', 97.58, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2035, 'UCWS', 98.56, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2036, 'UCWS', 99.54, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2037, 'UCWS', 100.54, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2038, 'UCWS', 101.54, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2039, 'UCWS', 102.56, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2040, 'UCWS', 103.58, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2041, 'UCWS', 104.62, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2042, 'UCWS', 105.66, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2043, 'UCWS', 106.72, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2044, 'UCWS', 107.79, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2045, 'UCWS', 108.87, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2046, 'UCWS', 109.95, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2047, 'UCWS', 111.05, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2048, 'UCWS', 112.17, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2049, 'UCWS', 113.29, 'megaton-hours', '2019 data');
INSERT INTO "Demand" VALUES('uiuc',2050, 'UCWS', 114.42, 'megaton-hours', '2019 data');
-- Assumes 1% growth
INSERT INTO "Demand" VALUES('uiuc',2021, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2022, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2023, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2024, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2025, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2026, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2027, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2028, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2029, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2030, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2031, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2032, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2033, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2034, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2035, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2036, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2037, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2038, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2039, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2040, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2041, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2042, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2043, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2044, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2045, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2046, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2047, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2048, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2049, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');
INSERT INTO "Demand" VALUES('uiuc',2050, 'UVCL', 551.5, 'K_gal of Gasoline Equiv.', 'from 2019 F&S data');

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
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'TURBINE', 2000, 0.03, 'M$/GWh', '');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'IMPELC', 2020, 0.09, 'M$/GWh', 'typical electricity price');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'IMPWIND', 2016, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'IMPWIND', 2035, 0.0384, 'M$/GWh', 'wind farm PPA');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'IMPSOL', 2016, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'IMPSOL', 2030, 0.196, 'M$/GWh', '');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'NUCLEAR', 2021, 0.027, 'M$/GWh', '');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'IMPGSL', 2021, 0.00222, 'M$/k_GAL', 'typical gasoline price');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'IMPDSL', 2021, 0.00248, 'M$/k_GAL', 'typical diesel price');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'IMPE85', 2021, 0.00199, 'M$/k_GAL', 'typical E85 price');

INSERT INTO "CostVariable" VALUES('uiuc', 2021, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2022, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2023, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2024, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2025, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2026, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2027, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2028, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2029, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2030, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2031, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2032, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2033, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2034, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2035, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2036, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2037, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2038, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2039, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2040, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2041, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2042, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2043, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2044, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2045, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2046, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2047, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2048, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2049, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
INSERT INTO "CostVariable" VALUES('uiuc', 2050, 'IMPH2', 2021, 0.006, 'M$/metrictons', 'typical hydrogen price $6/kg');
-- No cost variable considered for the ELCVCL because uses electricity produced in the system.


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
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2022, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2023, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2024, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2025, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2026, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2027, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2028, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2029, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2030, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2031, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2032, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2033, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2034, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2035, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2036, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2037, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2038, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2039, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2040, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2041, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2042, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2043, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2044, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2045, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2046, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2047, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2048, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2049, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');
INSERT INTO "CostInvest" VALUES('uiuc','ABBOTT', 2050, 0.735, 'M$/MWth', 'cost of installing a natural gas unit');

INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2021, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2022, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2023, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2024, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2025, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2026, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2027, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2028, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2029, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2030, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2031, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2032, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2033, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2034, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2035, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2036, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2037, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2038, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2039, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2040, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2041, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2042, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2043, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2044, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2045, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2046, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2047, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2048, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2049, 1.66, 'M$/MWe', 'solar farm 2.0 contract');
INSERT INTO "CostInvest" VALUES('uiuc','IMPSOL', 2050, 1.66, 'M$/MWe', 'solar farm 2.0 contract');

INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2021, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2022, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2023, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2024, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2025, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2026, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2027, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2028, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2029, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2030, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2031, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2032, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2033, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2034, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2035, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2036, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2037, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2038, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2039, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2040, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2041, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2042, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2043, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2044, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2045, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2046, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2047, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2048, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2049, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');
INSERT INTO "CostInvest" VALUES('uiuc','ELECTROL', 2050, 1.03019, 'M$/MWe', 'avg investment cost for alkaline electrolysis cells');

INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2021, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2022, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2023, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2024, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2025, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2026, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2027, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2028, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2029, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2030, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2031, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2032, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2033, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2034, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2035, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2036, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2037, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2038, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2039, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2040, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2041, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2042, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2043, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2044, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2045, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2046, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2047, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2048, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2049, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');
INSERT INTO "CostInvest" VALUES('uiuc','IMPWIND', 2050, 1.75, 'M$/MWe', 'if UIUC builds its own wind farm');

INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2021, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2022, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2023, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2024, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2025, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2026, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2027, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2028, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2029, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2030, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2031, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2032, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2033, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2034, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2035, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2036, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2037, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2038, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2039, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2040, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2041, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2042, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2043, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2044, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2045, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2046, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2047, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2048, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2049, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
INSERT INTO "CostInvest" VALUES('uiuc','NUCLEAR', 2050, 5.945, 'M$/MWth', 'cost of utility scale nuclear plant');
--
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2021, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2022, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2023, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2024, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2025, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2026, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2027, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2028, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2029, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2030, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2031, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2032, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2033, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2034, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2035, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2036, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2037, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2038, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2039, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2040, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2041, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2042, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2043, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2044, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2045, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2046, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2047, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2048, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2049, 0.186, 'M$/kilo-tons', 'cost of installation');
INSERT INTO "CostInvest" VALUES('uiuc','CHWS', 2050, 0.186, 'M$/kilo-tons', 'cost of installation');
-- GEOT: Sam's values
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2021, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2022, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2023, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2024, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2025, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2026, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2027, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2028, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2029, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- INSERT INTO "CostInvest" VALUES('uiuc','GEOT', 2030, 0.6513, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- GEOT: GH
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2021, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2022, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2023, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2024, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2025, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2026, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2027, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2028, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2029, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2030, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2031, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2032, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2033, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2034, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2035, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2036, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2037, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2038, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2039, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2040, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2041, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2042, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2043, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2044, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2045, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2046, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2047, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2048, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2049, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GH', 2050, 1.0235, 'M$/MWth', 'capital cost of geothermal plant and well-field');
-- GEOT: GC
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2021, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2022, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2023, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2024, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2025, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2026, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2027, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2028, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2029, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2030, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2031, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2032, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2033, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2034, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2035, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2036, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2037, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2038, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2039, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2040, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2041, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2042, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2043, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2044, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2045, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2046, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2047, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2048, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2049, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
INSERT INTO "CostInvest" VALUES('uiuc','GC', 2050, 3.7305, 'M$/kilo-tons', 'capital cost of geothermal plant and well-field');
-- Based on values from fuel-analysis/temoa-model.ipynb
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2021, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2022, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2023, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2024, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2025, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2026, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2027, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2028, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2029, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2030, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2031, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2032, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2033, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2034, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2035, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2036, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2037, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2038, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2039, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2040, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2041, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2042, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2043, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2044, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2045, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2046, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2047, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2048, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2049, 0.0229, 'M$/gge', 'cost of electric vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','ELCVCL', 2050, 0.0229, 'M$/gge', 'cost of electric vehicle');

INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2021, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2022, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2023, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2024, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2025, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2026, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2027, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2028, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2029, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2030, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2031, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2032, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2033, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2034, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2035, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2036, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2037, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2038, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2039, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2040, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2041, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2042, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2043, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2044, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2045, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2046, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2047, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2048, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2049, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','H2VCL', 2050, 0.0116, 'M$/gge', 'cost of hydrogen vehicle');

INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2021, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2022, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2023, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2024, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2025, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2026, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2027, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2028, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2029, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2030, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2031, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2032, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2033, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2034, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2035, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2036, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2037, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2038, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2039, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2040, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2041, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2042, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2043, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2044, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2045, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2046, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2047, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2048, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2049, 0.0018, 'M$/gge', 'cost of gasoline vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','GSLVCL', 2050, 0.0018, 'M$/gge', 'cost of gasoline vehicle');

INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2021, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2022, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2023, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2024, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2025, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2026, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2027, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2028, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2029, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2030, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2031, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2032, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2033, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2034, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2035, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2036, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2037, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2038, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2039, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2040, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2041, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2042, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2043, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2044, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2045, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2046, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2047, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2048, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2049, 0.0015, 'M$/gge', 'cost of e85 vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','E85VCL', 2050, 0.0015, 'M$/gge', 'cost of e85 vehicle');

INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2021, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2022, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2023, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2024, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2025, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2026, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2027, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2028, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2029, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2030, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2031, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2032, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2033, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2034, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2035, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2036, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2037, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2038, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2039, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2040, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2041, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2042, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2043, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2044, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2045, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2046, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2047, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2048, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2049, 0.0018, 'M$/gge', 'cost of diesel vehicle');
INSERT INTO "CostInvest" VALUES('uiuc','DSLVCL', 2050, 0.0018, 'M$/gge', 'cost of diesel vehicle');


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
--uiuc data
--INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'ABBOTT', 2000, 0.0553, 'M$/GWh', '');
--INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'TURBINE', 2000, 0.03, 'M$/GWh', '');
--INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'ELECTROL', 2021, 1, 'M$/kW-year', 'fixed O&M cost for');

--INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'IMPWIND', 2016, 0.00002634, 'M$/kw', 'yearly fixed O&M cost for large scale solar from S&L report');

--INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');
--INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'IMPSOL', 2016, 0.00001525, 'M$/kW', 'yearly fixed O&M cost from from S&L report');

INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2031, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2032, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2033, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2034, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2035, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2036, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2037, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2038, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2039, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2040, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2041, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2042, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2043, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2044, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2045, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2046, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2047, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2048, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2049, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
INSERT INTO "CostFixed" VALUES('uiuc', 2050, 'NUCLEAR', 2021, 0.00012164, 'M$/kW', 'yearly fixed O&M cost for utility scale nuclear from S\&L report');
--
-- INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');
-- INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'GEOT', 2020, 0.00028, 'M$/MWth', 'cost of O&M of the plant');

INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2031, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2032, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2033, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2034, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2035, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2036, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2037, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2038, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2039, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2040, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2041, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2042, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2043, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2044, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2045, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2046, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2047, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2048, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2049, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2050, 'GH', 2020, 0.0251, 'M$/MWth', 'cost of O&M of the plant');

INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2031, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2032, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2033, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2034, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2035, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2036, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2037, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2038, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2039, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2040, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2041, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2042, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2043, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2044, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2045, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2046, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2047, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2048, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2049, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
INSERT INTO "CostFixed" VALUES('uiuc', 2050, 'GC', 2020, 0.091485, 'M$/kilo-tons', 'cost of O&M of the plant');
--
INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2031, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2032, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2033, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2034, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2035, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2036, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2037, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2038, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2039, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2040, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2041, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2042, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2043, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2044, 'GSLVCL', 2020, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2045, 'GSLVCL', 2045, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2046, 'GSLVCL', 2045, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2047, 'GSLVCL', 2045, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2048, 'GSLVCL', 2045, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2049, 'GSLVCL', 2045, 0.0013, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2050, 'GSLVCL', 2045, 0.0013, 'M$/year', '5% of msrp');

INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2031, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2032, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2033, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2034, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2035, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2036, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2037, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2038, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2039, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2040, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2041, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2042, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2043, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2044, 'DSLVCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2045, 'DSLVCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2046, 'DSLVCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2047, 'DSLVCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2048, 'DSLVCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2049, 'DSLVCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2050, 'DSLVCL', 2045, 0.0019, 'M$/year', '5% of msrp');

INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2031, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2032, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2033, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2034, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2035, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2036, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2037, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2038, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2039, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2040, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2041, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2042, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2043, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2044, 'E85VCL', 2020, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2045, 'E85VCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2046, 'E85VCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2047, 'E85VCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2048, 'E85VCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2049, 'E85VCL', 2045, 0.0019, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2050, 'E85VCL', 2045, 0.0019, 'M$/year', '5% of msrp');

INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'ELCVCL', 2021, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'ELCVCL', 2021, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'ELCVCL', 2021, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'ELCVCL', 2021, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'ELCVCL', 2021, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'ELCVCL', 2021, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'ELCVCL', 2021, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'ELCVCL', 2021, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'ELCVCL', 2029, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'ELCVCL', 2029, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2031, 'ELCVCL', 2029, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2032, 'ELCVCL', 2029, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2033, 'ELCVCL', 2029, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2034, 'ELCVCL', 2029, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2035, 'ELCVCL', 2029, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2036, 'ELCVCL', 2029, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2037, 'ELCVCL', 2037, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2038, 'ELCVCL', 2037, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2039, 'ELCVCL', 2037, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2040, 'ELCVCL', 2037, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2041, 'ELCVCL', 2037, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2042, 'ELCVCL', 2037, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2043, 'ELCVCL', 2037, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2044, 'ELCVCL', 2037, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2045, 'ELCVCL', 2045, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2046, 'ELCVCL', 2045, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2047, 'ELCVCL', 2045, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2048, 'ELCVCL', 2045, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2049, 'ELCVCL', 2045, 0.0021, 'M$/year', '5% of msrp');
INSERT INTO "CostFixed" VALUES('uiuc', 2050, 'ELCVCL', 2045, 0.0021, 'M$/year', '5% of msrp');

INSERT INTO "CostFixed" VALUES('uiuc', 2021, 'H2VCL', 2021, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2022, 'H2VCL', 2021, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2023, 'H2VCL', 2021, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2024, 'H2VCL', 2021, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2025, 'H2VCL', 2021, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2026, 'H2VCL', 2021, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2027, 'H2VCL', 2021, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2028, 'H2VCL', 2021, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2029, 'H2VCL', 2029, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2030, 'H2VCL', 2029, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2031, 'H2VCL', 2029, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2032, 'H2VCL', 2029, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2033, 'H2VCL', 2029, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2034, 'H2VCL', 2029, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2035, 'H2VCL', 2029, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2036, 'H2VCL', 2029, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2037, 'H2VCL', 2037, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2038, 'H2VCL', 2037, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2039, 'H2VCL', 2037, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2040, 'H2VCL', 2037, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2041, 'H2VCL', 2037, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2042, 'H2VCL', 2037, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2043, 'H2VCL', 2037, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2044, 'H2VCL', 2037, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2045, 'H2VCL', 2045, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2046, 'H2VCL', 2045, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2047, 'H2VCL', 2045, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2048, 'H2VCL', 2045, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2049, 'H2VCL', 2045, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');
INSERT INTO "CostFixed" VALUES('uiuc', 2050, 'H2VCL', 2045, 0.003261417, 'M$/year', 'assuming a 15 year lifespan');


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
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPDSL', 1, 'k_gal');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPE85', 1, 'k_gal');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPH2', 1, 'metrictons');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'GSLVCL', 1, 'k_gal');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'DSLVCL', 1, 'k_gal');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'E85VCL', 1, 'k_gal');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'ELCVCL', 1, 'k_gal');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'H2VCL', 1, 'k_gal');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPELC', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPSOL', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'IMPWIND', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'NUCLEAR', 8.76, 'thermal GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'NBINE', 8.76, 'electrical GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'CHWS', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'GEOT', 8.76, 'electric GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'GH', 8.76, 'thermal GWh');
INSERT INTO "CapacityToActivity" VALUES('uiuc', 'GC', 8.76, 'thermal GWh');


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
-- INSERT INTO "CapacityFactorTech" VALUES('uiuc','winter', 'day', 'CHWS', 0.0,'CHW CF');
-- INSERT INTO "CapacityFactorTech" VALUES('uiuc','winter', 'night', 'CHWS', 1.0,'CHW CF');
-- INSERT INTO "CapacityFactorTech" VALUES('uiuc','inter', 'day', 'CHWS', 0.5,'CHW CF');
-- INSERT INTO "CapacityFactorTech" VALUES('uiuc','inter', 'night', 'CHWS', 0.5,'CHW CF');
-- INSERT INTO "CapacityFactorTech" VALUES('uiuc','summer', 'day', 'CHWS', 1.0,'CHW CF');
-- INSERT INTO "CapacityFactorTech" VALUES('uiuc','summer', 'night', 'CHWS', 1.0,'CHW CF');


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
-- INSERT INTO "StorageDuration" VALUES ('uiuc','CHWS',0.0000761,'units: 2/3 * 1/8760 years');


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
