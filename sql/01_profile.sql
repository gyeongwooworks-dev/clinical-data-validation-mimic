-- 01_profile.sql : Profiling of MIMIC-IV demo tables

-- Q1. Row counts and distinct patients per table
SELECT 'patients'      AS table_name, COUNT(*) AS n_rows, COUNT(DISTINCT subject_id) AS n_patients FROM patients
UNION ALL
SELECT 'admissions',    COUNT(*), COUNT(DISTINCT subject_id) FROM admissions
UNION ALL
SELECT 'diagnoses_icd', COUNT(*), COUNT(DISTINCT subject_id) FROM diagnoses_icd
UNION ALL
SELECT 'labevents',     COUNT(*), COUNT(DISTINCT subject_id) FROM labevents
UNION ALL
SELECT 'icustays',      COUNT(*), COUNT(DISTINCT subject_id) FROM icustays;
-- Finding: all 100 demo patients have >=1 ICU stay -> cohort over-represents critically ill patients

-- Q2. Admission date range (dates are shifted per patient for de-identification)
SELECT MIN(admittime) AS first_admit,
       MAX(admittime) AS last_admit
FROM admissions;
-- Finding: 2110-2201 -> only within-patient time intervals are meaningful

-- Check: per-patient lab counts sum to the table total (expected 107,727)
WITH lab_per_patient AS (
    SELECT subject_id, COUNT(*) AS n_labs
    FROM labevents
    GROUP BY subject_id
)
SELECT SUM(n_labs) AS total_labs,
       AVG(n_labs) AS avg_labs_per_patient
FROM lab_per_patient;

-- Q3. Distribution of admissions per patient
WITH adm_per_patient AS (
    SELECT subject_id, COUNT(*) AS n_admissions
    FROM admissions
    GROUP BY subject_id
)
SELECT n_admissions,
       COUNT(*) AS n_patients
FROM adm_per_patient
GROUP BY n_admissions
ORDER BY n_admissions;
-- Finding: 52/100 patients have a single admission; 48 have >=2 (readmission analysis is feasible).
-- Check: n_patients sums to 100 and n_admissions x n_patients sums to 275.


