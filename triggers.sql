BEGIN;

-- ========================================
-- FUNCTION: update_modified_timestamp()
-- PURPOSE: Automatically updates 'updated_at' whenever a record is modified.
-- ========================================
CREATE OR REPLACE FUNCTION update_modified_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- TRIGGERS: Apply timestamp update to main tables
-- ========================================
CREATE TRIGGER trg_update_departments
BEFORE UPDATE ON departments
FOR EACH ROW
EXECUTE FUNCTION update_modified_timestamp();

CREATE TRIGGER trg_update_officers
BEFORE UPDATE ON officers
FOR EACH ROW
EXECUTE FUNCTION update_modified_timestamp();

CREATE TRIGGER trg_update_cases
BEFORE UPDATE ON cases
FOR EACH ROW
EXECUTE FUNCTION update_modified_timestamp();

CREATE TRIGGER trg_update_evidence
BEFORE UPDATE ON evidence
FOR EACH ROW
EXECUTE FUNCTION update_modified_timestamp();

-- ========================================
-- FUNCTION: record_evidence_chain()
-- PURPOSE: Logs new chain of custody entries whenever new evidence is collected or updated.
-- ========================================
CREATE OR REPLACE FUNCTION record_evidence_chain()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO evidence_chain (
        evidence_id,
        officer_id,
        action,
        location,
        notes
    )
    VALUES (
        NEW.evidence_id,
        COALESCE(NEW.collected_by, NULL),
        CASE 
            WHEN TG_OP = 'INSERT' THEN 'collected'
            WHEN TG_OP = 'UPDATE' THEN 'updated'
            ELSE 'unknown'
        END,
        NEW.storage_location,
        'Auto entry from trigger'
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- TRIGGER: trg_record_evidence_chain
-- PURPOSE: Auto-inserts custody records when evidence changes
-- ========================================
CREATE TRIGGER trg_record_evidence_chain
AFTER INSERT OR UPDATE ON evidence
FOR EACH ROW
EXECUTE FUNCTION record_evidence_chain();

-- ========================================
-- FUNCTION: mark_case_resolved()
-- PURPOSE: Automatically sets resolution date when a case is marked as 'solved'.
-- ========================================
CREATE OR REPLACE FUNCTION mark_case_resolved()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'solved' AND OLD.status <> 'solved' THEN
        NEW.resolution_date := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- TRIGGER: trg_mark_case_resolved
-- PURPOSE: Auto-adds resolution timestamp for solved cases
-- ========================================
CREATE TRIGGER trg_mark_case_resolved
BEFORE UPDATE ON cases
FOR EACH ROW
EXECUTE FUNCTION mark_case_resolved();

COMMIT;
