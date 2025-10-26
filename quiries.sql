-- ========================================
-- QUERY 1: All Open/Active Cases
-- ========================================
-- Description: Retrieve all cases currently under investigation
SELECT 
    case_number,
    title,
    case_type,
    severity,
    status,
    incident_date,
    location,
    lead_officer,
    days_open,
    suspect_count,
    evidence_count
FROM case_summary
WHERE status IN ('open', 'under_investigation')
ORDER BY severity DESC, days_open DESC;

-- ========================================
-- QUERY 2: Solved Cases in Last 30 Days
-- ========================================
-- Description: Recent case resolutions
SELECT 
    case_number,
    title,
    case_type,
    severity,
    resolution_date,
    days_to_solve,
    lead_officer,
    department_name,
    suspects_involved,
    evidence_collected
FROM solved_cases_analysis
WHERE resolution_date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY resolution_date DESC;

-- ========================================
-- QUERY 3: Cold Cases (Open > 1 Year)
-- ========================================
-- Description: Cases that have been open for over a year
SELECT 
    case_number,
    title,
    case_type,
    severity,
    incident_date,
    days_open,
    location,
    lead_officer,
    suspects_identified,
    evidence_collected,
    priority_level
FROM unsolved_cases_analysis
WHERE days_open > 365
ORDER BY days_open DESC, severity DESC;

-- ========================================
-- QUERY 4: High Priority Unsolved Cases
-- ========================================
-- Description: Critical severity cases still open
SELECT 
    case_number,
    title,
    case_type,
    incident_date,
    days_open,
    location,
    lead_officer,
    badge_number,
    department_name,
    suspects_identified,
    evidence_collected
FROM unsolved_cases_analysis
WHERE severity = 'critical'
ORDER BY days_open DESC;

-- ========================================
-- QUERY 5: Officer Performance Report
-- ========================================
-- Description: Top performing officers by solve rate
SELECT 
    officer_name,
    badge_number,
    rank,
    department_name,
    active_cases,
    solved_cases,
    total_cases,
    solve_rate_percent
FROM officer_workload
WHERE total_cases > 0
ORDER BY solve_rate_percent DESC, solved_cases DESC
LIMIT 20;

-- ========================================
-- QUERY 6: Overloaded Officers
-- ========================================
-- Description: Officers with high active case counts
SELECT 
    officer_name,
    badge_number,
    rank,
    department_name,
    active_cases,
    total_cases,
    solve_rate_percent
FROM officer_workload
WHERE active_cases >= 5
ORDER BY active_cases DESC;

-- ========================================
-- QUERY 7: Cases by Type and Status
-- ========================================
-- Description: Statistical breakdown of cases
SELECT 
    case_type,
    COUNT(*) AS total_cases,
    COUNT(CASE WHEN status = 'solved' THEN 1 END) AS solved,
    COUNT(CASE WHEN status IN ('open', 'under_investigation') THEN 1 END) AS open,
    COUNT(CASE WHEN status = 'cold_case' THEN 1 END) AS cold,
    ROUND(
        COUNT(CASE WHEN status = 'solved' THEN 1 END)::NUMERIC / 
        COUNT(*) * 100, 2
    ) AS solve_rate
FROM cases
GROUP BY case_type
ORDER BY total_cases DESC;

-- ========================================
-- QUERY 8: Evidence Chain Verification
-- ========================================
-- Description: Evidence items with incomplete chains
SELECT 
    e.evidence_number,
    c.case_number,
    e.evidence_type,
    e.collection_date,
    e.chain_of_custody_verified,
    COUNT(ec.chain_id) AS chain_entries,
    MAX(ec.action_timestamp) AS last_update
FROM evidence e
INNER JOIN cases c ON e.case_id = c.case_id
LEFT JOIN evidence_chain ec ON e.evidence_id = ec.evidence_id
WHERE e.chain_of_custody_verified = false
   OR e.status = 'missing'
GROUP BY e.evidence_id, e.evidence_number, c.case_number, 
         e.evidence_type, e.collection_date, e.chain_of_custody_verified
ORDER BY e.collection_date;

-- ========================================
-- QUERY 9: Suspect Criminal Activity
-- ========================================
-- Description: Suspects involved in multiple cases
SELECT 
    suspect_name,
    alias,
    age,
    status,
    case_count,
    crime_types,
    arrest_date
FROM suspect_profile
WHERE case_count > 1
ORDER BY case_count DESC, suspect_name;

-- ========================================
-- QUERY 10: Cases by Location Hotspots
-- ========================================
-- Description: Geographic analysis of crime
SELECT 
    location,
    COUNT(*) AS case_count,
    COUNT(CASE WHEN status = 'solved' THEN 1 END) AS solved,
    COUNT(CASE WHEN status IN ('open', 'under_investigation') THEN 1 END) AS active,
    STRING_AGG(DISTINCT case_type, ', ') AS crime_types
FROM cases
GROUP BY location
HAVING COUNT(*) >= 2
ORDER BY case_count DESC
LIMIT 15;

-- ========================================
-- QUERY 11: Recent Evidence Collection
-- ========================================
-- Description: Evidence collected in last 7 days
SELECT 
    evidence_number,
    case_number,
    case_title,
    evidence_type,
    collection_date,
    collected_by,
    evidence_status,
    chain_of_custody_verified
FROM evidence_tracking
WHERE collection_date >= CURRENT_DATE - INTERVAL '7 days'
ORDER BY collection_date DESC;

-- ========================================
-- QUERY 12: Department Comparison
-- ========================================
-- Description: Performance metrics across departments
SELECT 
    department_name,
    location,
    active_officers,
    total_cases,
    active_cases,
    solved_cases,
    solve_rate_percent,
    ROUND(total_cases::NUMERIC / NULLIF(active_officers, 0), 2) AS cases_per_officer
FROM department_statistics
ORDER BY solve_rate_percent DESC, total_cases DESC;

-- ========================================
-- QUERY 13: Cases Solved Within 30 Days
-- ========================================
-- Description: Quick resolution cases
SELECT 
    case_number,
    title,
    case_type,
    incident_date,
    resolution_date,
    days_to_solve,
    lead_officer,
    evidence_collected
FROM solved_cases_analysis
WHERE days_to_solve <= 30
ORDER BY days_to_solve ASC;

-- ========================================
-- QUERY 14: Evidence by Type Analysis
-- ========================================
-- Description: Statistical breakdown of evidence
SELECT 
    evidence_type,
    COUNT(*) AS total_items,
    COUNT(CASE WHEN chain_of_custody_verified = true THEN 1 END) AS verified,
    COUNT(CASE WHEN evidence_status = 'under_analysis' THEN 1 END) AS under_analysis,
    COUNT(CASE WHEN evidence_status = 'missing' THEN 1 END) AS missing,
    ROUND(
        COUNT(CASE WHEN chain_of_custody_verified = true THEN 1 END)::NUMERIC / 
        COUNT(*) * 100, 2
    ) AS verification_rate
FROM evidence_tracking
GROUP BY evidence_type
ORDER BY total_items DESC;

-- ========================================
-- QUERY 15: Monthly Case Trends (Current Year)
-- ========================================
-- Description: Cases opened per month this year
SELECT 
    TO_CHAR(incident_date, 'YYYY-MM') AS month,
    COUNT(*) AS cases_opened,
    COUNT(CASE WHEN status = 'solved' THEN 1 END) AS cases_solved,
    STRING_AGG(DISTINCT case_type, ', ') AS crime_types
FROM cases
WHERE EXTRACT(YEAR FROM incident_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY TO_CHAR(incident_date, 'YYYY-MM')
ORDER BY month DESC;

-- ========================================
-- QUERY 16: Suspects Currently At Large
-- ========================================
-- Description: Wanted suspects not in custody
SELECT 
    s.suspect_id,
    s.first_name || ' ' || s.last_name AS suspect_name,
    s.alias,
    s.date_of_birth,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, s.date_of_birth)) AS age,
    s.physical_description,
    STRING_AGG(c.case_number, ', ') AS related_cases,
    STRING_AGG(DISTINCT c.case_type, ', ') AS crime_types
FROM suspects s
INNER JOIN case_assignments ca ON s.suspect_id = ca.suspect_id
INNER JOIN cases c ON ca.case_id = c.case_id
WHERE s.status = 'at_large'
GROUP BY s.suspect_id, s.first_name, s.last_name, s.alias, 
         s.date_of_birth, s.physical_description
ORDER BY s.last_name;

-- ========================================
-- QUERY 17: Case Resolution Time by Type
-- ========================================
-- Description: Average resolution time per crime type
SELECT 
    case_type,
    COUNT(*) AS solved_cases,
    ROUND(AVG(days_to_solve), 2) AS avg_days_to_solve,
    MIN(days_to_solve) AS fastest_resolution,
    MAX(days_to_solve) AS slowest_resolution
FROM solved_cases_analysis
GROUP BY case_type
HAVING COUNT(*) >= 1
ORDER BY avg_days_to_solve;

-- ========================================
-- QUERY 18: Officers Without Active Cases
-- ========================================
-- Description: Available officers for assignment
SELECT 
    o.officer_id,
    o.badge_number,
    o.first_name || ' ' || o.last_name AS officer_name,
    o.rank,
    d.department_name,
    o.email,
    o.phone
FROM officers o
INNER JOIN departments d ON o.department_id = d.department_id
WHERE o.status = 'active'
  AND o.officer_id NOT IN (
      SELECT DISTINCT lead_officer_id 
      FROM cases 
      WHERE status IN ('open', 'under_investigation')
        AND lead_officer_id IS NOT NULL
  )
ORDER BY o.rank, o.last_name;

-- ========================================
-- QUERY 19: Evidence Chain Audit Trail
-- ========================================
-- Description: Complete chain of custody for evidence
SELECT 
    ec.evidence_id,
    e.evidence_number,
    c.case_number,
    ec.action,
    ec.action_timestamp,
    o.first_name || ' ' || o.last_name AS officer_name,
    o.badge_number,
    ec.location,
    ec.notes
FROM evidence_chain ec
INNER JOIN evidence e ON ec.evidence_id = e.evidence_id
INNER JOIN cases c ON e.case_id = c.case_id
INNER JOIN officers o ON ec.officer_id = o.officer_id
WHERE e.evidence_number = 'EVD-XXXX-XXXX-0001' -- Replace with actual evidence number
ORDER BY ec.action_timestamp;

-- ========================================
-- QUERY 20: Critical Open Cases Summary
-- ========================================
-- Description: Dashboard view for critical cases
SELECT 
    c.case_number,
    c.title,
    c.case_type,
    c.incident_date,
    EXTRACT(DAY FROM (CURRENT_TIMESTAMP - c.reported_date)) AS days_open,
    c.location,
    o.first_name || ' ' || o.last_name AS lead_officer,
    o.badge_number,
    COUNT(DISTINCT ca.suspect_id) AS suspects,
    COUNT(DISTINCT e.evidence_id) AS evidence_items,
    CASE 
        WHEN COUNT(DISTINCT ca.suspect_id) = 0 THEN 'No suspects identified'
        WHEN COUNT(DISTINCT e.evidence_id) = 0 THEN 'No evidence collected'
        ELSE 'Under active investigation'
    END AS investigation_status
FROM cases c
LEFT JOIN officers o ON c.lead_officer_id = o.officer_id
LEFT JOIN case_assignments ca ON c.case_id = ca.case_id
LEFT JOIN evidence e ON c.case_id = e.case_id
WHERE c.severity = 'critical'
  AND c.status IN ('open', 'under_investigation')
GROUP BY c.case_id, c.case_number, c.title, c.case_type, c.incident_date,
         c.reported_date, c.location, o.first_name, o.last_name, o.badge_number
ORDER BY days_open DESC;

-- Success message
DO $
BEGIN
    RAISE NOTICE 'Analysis queries ready to use!';
END $;