-- Cases indexes
CREATE INDEX idx_cases_case_number ON cases(case_number);
CREATE INDEX idx_cases_status ON cases(status);
CREATE INDEX idx_cases_case_type ON cases(case_type);
CREATE INDEX idx_cases_severity ON cases(severity);
CREATE INDEX idx_cases_incident_date ON cases(incident_date);
CREATE INDEX idx_cases_lead_officer ON cases(lead_officer_id);

-- Suspects indexes
CREATE INDEX idx_suspects_name ON suspects(last_name, first_name);
CREATE INDEX idx_suspects_status ON suspects(status);
CREATE INDEX idx_suspects_identification ON suspects(identification_number);

-- Officers indexes
CREATE INDEX idx_officers_badge ON officers(badge_number);
CREATE INDEX idx_officers_name ON officers(last_name, first_name);
CREATE INDEX idx_officers_status ON officers(status);
CREATE INDEX idx_officers_department ON officers(department_id);

-- Evidence indexes
CREATE INDEX idx_evidence_case_id ON evidence(case_id);
CREATE INDEX idx_evidence_number ON evidence(evidence_number);
CREATE INDEX idx_evidence_type ON evidence(evidence_type);
CREATE INDEX idx_evidence_status ON evidence(status);

-- Case assignments indexes
CREATE INDEX idx_assignments_case ON case_assignments(case_id);
CREATE INDEX idx_assignments_suspect ON case_assignments(suspect_id);

-- Evidence chain indexes
CREATE INDEX idx_chain_evidence ON evidence_chain(evidence_id);
CREATE INDEX idx_chain_officer ON evidence_chain(officer_id);
CREATE INDEX idx_chain_timestamp ON evidence_chain(action_timestamp);

-- ========================================
-- COMMENTS FOR DOCUMENTATION
-- ========================================

COMMENT ON TABLE departments IS 'Police departments and organizational units';
COMMENT ON TABLE officers IS 'Law enforcement officers and investigators';
COMMENT ON TABLE cases IS 'Criminal cases and investigations';
COMMENT ON TABLE suspects IS 'Suspects and persons of interest';
COMMENT ON TABLE case_assignments IS 'Links suspects to cases';
COMMENT ON TABLE evidence IS 'Physical and digital evidence items';
COMMENT ON TABLE evidence_chain IS 'Chain of custody tracking for evidence';

-- Success message
DO $$
BEGIN
    RAISE NOTICE 'Schema created successfully!';
END $$;