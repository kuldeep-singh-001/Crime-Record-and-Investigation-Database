BEGIN;

-- ========================================
-- VIEW: view_officer_workload
-- Description:
--   Summarizes the workload and performance of each officer across all assigned cases.
-- ========================================
CREATE OR REPLACE VIEW view_officer_workload AS
SELECT
    o.officer_id,
    o.first_name || ' ' || o.last_name AS officer_name,
    o.rank,
    d.department_name,
    COUNT(c.case_id) AS total_cases,
    COUNT(CASE WHEN c.status = 'open' THEN 1 END) AS open_cases,
    COUNT(CASE WHEN c.status = 'under_investigation' THEN 1 END) AS ongoing_cases,
    COUNT(CASE WHEN c.status = 'solved' THEN 1 END) AS solved_cases,
    COUNT(CASE WHEN c.status = 'closed' THEN 1 END) AS closed_cases
FROM officers o
LEFT JOIN departments d ON o.department_id = d.department_id
LEFT JOIN cases c ON c.lead_officer_id = o.officer_id
GROUP BY o.officer_id, officer_name, o.rank, d.department_name;



-- ========================================
-- VIEW: view_evidence_chain
-- Description:
--   Displays the full chain of custody for all evidence items, ordered by time.
-- ========================================
CREATE OR REPLACE VIEW view_evidence_chain AS
SELECT
    e.evidence_number,
    e.description AS evidence_description,
    ec.action,
    ec.location,
    ec.action_timestamp,
    o.first_name || ' ' || o.last_name AS handled_by
FROM evidence_chain ec
JOIN evidence e ON e.evidence_id = ec.evidence_id
JOIN officers o ON ec.officer_id = o.officer_id
ORDER BY e.evidence_number, ec.action_timestamp;

-- ========================================
-- VIEW: view_department_case_load
-- Description:
--   Aggregates case data to show department-level workload and case statuses.
-- ========================================
CREATE OR REPLACE VIEW view_department_case_load AS
SELECT
    d.department_name,
    COUNT(DISTINCT c.case_id) AS total_cases,
    COUNT(DISTINCT CASE WHEN c.status IN ('open', 'under_investigation') THEN c.case_id END) AS active_cases,
    COUNT(DISTINCT CASE WHEN c.status IN ('solved', 'closed') THEN c.case_id END) AS completed_cases,
    COUNT(DISTINCT CASE WHEN c.status = 'cold_case' THEN c.case_id END) AS cold_cases
FROM departments d
LEFT JOIN officers o ON o.department_id = d.department_id
LEFT JOIN cases c ON c.lead_officer_id = o.officer_id
GROUP BY d.department_name;

-- ========================================
-- VIEW: view_suspect_involvement
-- Description:
--   Lists all suspects with the number of cases they are associated with, and their involvement level.
-- ========================================
CREATE OR REPLACE VIEW view_suspect_involvement AS
SELECT
    s.suspect_id,
    s.first_name || ' ' || s.last_name AS suspect_name,
    s.status AS suspect_status,
    COUNT(DISTINCT ca.case_id) AS cases_involved,
    STRING_AGG(DISTINCT c.case_number, ', ') AS case_numbers
FROM suspects s
LEFT JOIN case_assignments ca ON s.suspect_id = ca.suspect_id
LEFT JOIN cases c ON ca.case_id = c.case_id
GROUP BY s.suspect_id, suspect_name, s.status;

-- ========================================
-- VIEW: view_unsolved_cases
-- Description:
--   Quickly filters unsolved or ongoing cases with their responsible officers.
-- ========================================
CREATE OR REPLACE VIEW view_unsolved_cases AS
SELECT
    c.case_id,
    c.case_number,
    c.title,
    c.case_type,
    c.status,
    c.location,
    o.first_name || ' ' || o.last_name AS lead_officer,
    c.reported_date
FROM cases c
LEFT JOIN officers o ON c.lead_officer_id = o.officer_id
WHERE c.status IN ('open', 'under_investigation', 'cold_case')
ORDER BY c.reported_date DESC;

COMMIT;

