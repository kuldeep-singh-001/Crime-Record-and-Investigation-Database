-- TABLE: departments (Stores police department information)
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(200) NOT NULL,
    contact_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE: officers (Stores police officer information)
CREATE TABLE officers (
    officer_id SERIAL PRIMARY KEY,
    badge_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    rank VARCHAR(50) NOT NULL,
    department_id INTEGER REFERENCES departments(department_id) ON DELETE SET NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'on_leave', 'retired', 'suspended')),
    hire_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE: cases (Stores criminal case information)
CREATE TABLE cases (
    case_id SERIAL PRIMARY KEY,
    case_number VARCHAR(50) NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    case_type VARCHAR(50) NOT NULL CHECK (case_type IN ('homicide', 'assault', 'robbery', 'burglary', 'theft', 'fraud', 'cybercrime', 'drug_offense', 'other')),
    severity VARCHAR(20) NOT NULL CHECK (severity IN ('low', 'medium', 'high', 'critical')),
    status VARCHAR(20) DEFAULT 'open' CHECK (status IN ('open', 'under_investigation', 'solved', 'closed', 'cold_case')),
    incident_date TIMESTAMP NOT NULL,
    reported_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(300) NOT NULL,
    lead_officer_id INTEGER REFERENCES officers(officer_id) ON DELETE SET NULL,
    resolution_date TIMESTAMP,
    resolution_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE: suspects (Stores suspect information)
CREATE TABLE suspects (
    suspect_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    alias VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'other', 'unknown')),
    nationality VARCHAR(50),
    identification_number VARCHAR(50),
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    physical_description TEXT,
    criminal_history TEXT,
    status VARCHAR(30) DEFAULT 'person_of_interest' CHECK (status IN ('person_of_interest', 'suspect', 'arrested', 'convicted', 'acquitted', 'at_large')),
    arrest_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE: case_assignments ( Links suspects to cases (many-to-many) )
CREATE TABLE case_assignments (
    assignment_id SERIAL PRIMARY KEY,
    case_id INTEGER NOT NULL REFERENCES cases(case_id) ON DELETE CASCADE,
    suspect_id INTEGER NOT NULL REFERENCES suspects(suspect_id) ON DELETE CASCADE,
    involvement_level VARCHAR(30) CHECK (involvement_level IN ('primary_suspect', 'accomplice', 'witness', 'person_of_interest')),
    assigned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(case_id, suspect_id)
);

-- TABLE: evidence (Stores evidence related to cases)
CREATE TABLE evidence (
    evidence_id SERIAL PRIMARY KEY,
    case_id INTEGER NOT NULL REFERENCES cases(case_id) ON DELETE CASCADE,
    evidence_number VARCHAR(50) NOT NULL UNIQUE,
    evidence_type VARCHAR(50) NOT NULL CHECK (evidence_type IN ('physical', 'digital', 'documentary', 'testimonial', 'forensic', 'photographic', 'video', 'audio')),
    description TEXT NOT NULL,
    collection_date TIMESTAMP NOT NULL,
    collection_location VARCHAR(300),
    collected_by INTEGER REFERENCES officers(officer_id) ON DELETE SET NULL,
    storage_location VARCHAR(200),
    status VARCHAR(30) DEFAULT 'collected' CHECK (status IN ('collected', 'under_analysis', 'analyzed', 'stored', 'disposed', 'missing')),
    chain_of_custody_verified BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE: evidence_chain (Tracks chain of custody for evidence)
CREATE TABLE evidence_chain (
    chain_id SERIAL PRIMARY KEY,
    evidence_id INTEGER NOT NULL REFERENCES evidence(evidence_id) ON DELETE CASCADE,
    officer_id INTEGER NOT NULL REFERENCES officers(officer_id) ON DELETE RESTRICT,
    action VARCHAR(50) NOT NULL CHECK (action IN ('collected', 'transferred', 'analyzed', 'returned', 'stored', 'retrieved', 'disposed')),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(200),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);