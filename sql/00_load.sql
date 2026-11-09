-- 00_load.sql : Load core MIMIC-IV demo tables into DuckDB
CREATE OR REPLACE TABLE patients        AS SELECT * FROM read_csv_auto('data/hosp/patients.csv.gz');
CREATE OR REPLACE TABLE admissions      AS SELECT * FROM read_csv_auto('data/hosp/admissions.csv.gz');
CREATE OR REPLACE TABLE diagnoses_icd   AS SELECT * FROM read_csv_auto('data/hosp/diagnoses_icd.csv.gz');
CREATE OR REPLACE TABLE d_icd_diagnoses AS SELECT * FROM read_csv_auto('data/hosp/d_icd_diagnoses.csv.gz');
CREATE OR REPLACE TABLE labevents       AS SELECT * FROM read_csv_auto('data/hosp/labevents.csv.gz');
CREATE OR REPLACE TABLE d_labitems      AS SELECT * FROM read_csv_auto('data/hosp/d_labitems.csv.gz');
CREATE OR REPLACE TABLE icustays        AS SELECT * FROM read_csv_auto('data/icu/icustays.csv.gz');
