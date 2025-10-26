BEGIN;

-- ========================================
-- Insert Departments 
-- ========================================
INSERT INTO departments (department_name, location, contact_number) VALUES
('Delhi Police Crime Branch', 'Delhi', '011-23456789'),
('Mumbai Crime Branch', 'Mumbai, Maharashtra', '022-24567890'),
('Bangalore Cyber Crime Unit', 'Bangalore, Karnataka', '080-22334455'),
('Chennai Narcotics Division', 'Chennai, Tamil Nadu', '044-33445566'),
('Kolkata Homicide Squad', 'Kolkata, West Bengal', '033-66778899'),
('Hyderabad Anti-Terror Cell', 'Hyderabad, Telangana', '040-11223344'),
('Pune Economic Offenses Wing', 'Pune, Maharashtra', '020-55667788'),
('Ahmedabad Special Investigation Team', 'Ahmedabad, Gujarat', '079-88990011'),
('Lucknow Crime Investigation Unit', 'Lucknow, Uttar Pradesh', '0522-99001122'),
('Jaipur Women Safety Cell', 'Jaipur, Rajasthan', '0141-66778899');

-- ========================================
-- Insert Officers
-- ========================================
INSERT INTO officers (badge_number, first_name, last_name, rank, department_id, email, phone, hire_date) VALUES
('DL1001', 'Rakesh', 'Sharma', 'Inspector', 1, '[rakesh.sharma@delhipolice.in](mailto:rakesh.sharma@delhipolice.in)', '9876543210', '2010-03-12'),
('DL1002', 'Sunita', 'Verma', 'Sub-Inspector', 1, '[sunita.verma@delhipolice.in](mailto:sunita.verma@delhipolice.in)', '9898989898', '2015-07-10'),
('MH2001', 'Arjun', 'Patil', 'Inspector', 2, '[arjun.patil@mumbaipolice.in](mailto:arjun.patil@mumbaipolice.in)', '9822022022', '2008-11-05'),
('KA3001', 'Meena', 'Rao', 'Cyber Specialist', 3, '[meena.rao@bangalorepolice.in](mailto:meena.rao@bangalorepolice.in)', '9845098450', '2016-02-20'),
('TN4001', 'Suresh', 'Kumar', 'Inspector', 4, '[suresh.kumar@chennaipolice.in](mailto:suresh.kumar@chennaipolice.in)', '9876000001', '2012-04-25'),
('WB5001', 'Priya', 'Das', 'Head Constable', 5, '[priya.das@kolkatapolice.in](mailto:priya.das@kolkatapolice.in)', '9000000011', '2018-08-14'),
('TG6001', 'Anil', 'Reddy', 'Deputy Superintendent', 6, '[anil.reddy@hydpolice.in](mailto:anil.reddy@hydpolice.in)', '9123456789', '2005-01-30'),
('MH7001', 'Sneha', 'Joshi', 'Inspector', 7, '[sneha.joshi@punepolice.in](mailto:sneha.joshi@punepolice.in)', '9823456789', '2014-06-17'),
('GJ8001', 'Rahul', 'Mehta', 'Sub-Inspector', 8, '[rahul.mehta@ahmedabadpolice.in](mailto:rahul.mehta@ahmedabadpolice.in)', '9977665544', '2019-12-01'),
('UP9001', 'Vikas', 'Tiwari', 'Inspector', 9, '[vikas.tiwari@lucknowpolice.in](mailto:vikas.tiwari@lucknowpolice.in)', '9450001234', '2013-09-09');

-- ========================================
-- Insert Cases
-- ========================================
INSERT INTO cases (case_number, title, description, case_type, severity, status, incident_date, location, lead_officer_id)
VALUES
('CASE-IND-0001', 'Jewelry Shop Robbery', 'Armed robbery at a jewelry shop in Connaught Place.', 'robbery', 'high', 'under_investigation', '2025-01-10 21:00:00', 'Connaught Place, Delhi', 1),
('CASE-IND-0002', 'Cyber Fraud Complaint', 'Online credit card fraud reported by multiple citizens.', 'cybercrime', 'medium', 'open', '2025-03-05 15:20:00', 'Indiranagar, Bangalore', 4),
('CASE-IND-0003', 'Homicide Case - Park Murder', 'Suspicious death found in Central Park.', 'homicide', 'critical', 'under_investigation', '2025-02-15 08:00:00', 'Park Street, Kolkata', 6),
('CASE-IND-0004', 'Drug Trafficking Bust', 'Narcotics found in truck shipment.', 'drug_offense', 'high', 'solved', '2024-11-30 23:30:00', 'Ambattur, Chennai', 5),
('CASE-IND-0005', 'ATM Skimming Operation', 'Illegal ATM skimming detected in Pune region.', 'fraud', 'medium', 'closed', '2024-12-18 12:00:00', 'Shivajinagar, Pune', 8),
('CASE-IND-0006', 'Kidnapping Incident', 'Reported missing child from Lucknow area.', 'other', 'critical', 'under_investigation', '2025-04-05 18:00:00', 'Hazratganj, Lucknow', 10),
('CASE-IND-0007', 'Corporate Data Breach', 'Data stolen from IT company servers.', 'cybercrime', 'high', 'open', '2025-05-02 09:30:00', 'Electronic City, Bangalore', 4),
('CASE-IND-0008', 'Women Harassment Case', 'Complaint filed by a female victim in Jaipur.', 'assault', 'medium', 'open', '2025-06-15 20:45:00', 'Mansarovar, Jaipur', 10),
('CASE-IND-0009', 'Chain Snatching', 'Motorbike chain-snatching reported by citizens.', 'theft', 'low', 'closed', '2024-10-10 07:00:00', 'Marine Drive, Mumbai', 3),
('CASE-IND-0010', 'Terror Suspect Interrogation', 'Suspected terrorist under interrogation.', 'other', 'critical', 'under_investigation', '2025-08-22 11:15:00', 'Banjara Hills, Hyderabad', 7);

-- ========================================
-- Insert Suspects
-- ========================================
INSERT INTO suspects (first_name, last_name, alias, date_of_birth, gender, nationality, identification_number, address, phone, email, physical_description, criminal_history, status) VALUES
('Amit', 'Singh', 'Raja', '1988-05-10', 'male', 'Indian', 'ID12345', 'Delhi, India', '9990001111', '[amit.singh@mail.com](mailto:amit.singh@mail.com)', '5ft10, scar on left cheek', 'Previously involved in theft cases.', 'suspect'),
('Ravi', 'Kumar', NULL, '1990-09-22', 'male', 'Indian', 'ID23456', 'Mumbai, India', '9988776655', '[ravi.kumar@mail.com](mailto:ravi.kumar@mail.com)', '6ft1, tattoos on both arms', 'History of robbery cases.', 'arrested'),
('Neha', 'Verma', NULL, '1995-11-12', 'female', 'Indian', 'ID34567', 'Lucknow, India', '9123456789', '[neha.verma@mail.com](mailto:neha.verma@mail.com)', '5ft6, fair complexion', 'None', 'person_of_interest'),
('Sanjay', 'Patel', NULL, '1982-01-05', 'male', 'Indian', 'ID45678', 'Ahmedabad, India', '9812345678', '[sanjay.patel@mail.com](mailto:sanjay.patel@mail.com)', '5ft8, beard', 'Fraud cases in 2015 and 2018', 'convicted'),
('Pooja', 'Iyer', NULL, '1993-04-15', 'female', 'Indian', 'ID56789', 'Chennai, India', '9001234567', '[pooja.iyer@mail.com](mailto:pooja.iyer@mail.com)', '5ft5, mole on nose', 'Clean record', 'person_of_interest'),
('Imran', 'Khan', NULL, '1985-06-30', 'male', 'Indian', 'ID67890', 'Hyderabad, India', '9090909090', '[imran.khan@mail.com](mailto:imran.khan@mail.com)', '6ft, medium build', 'Suspected drug dealer', 'suspect'),
('Manish', 'Rao', NULL, '1989-03-25', 'male', 'Indian', 'ID78901', 'Bangalore, India', '9876509876', '[manish.rao@mail.com](mailto:manish.rao@mail.com)', '5ft9, slim', 'Cybercrime offenses (2019)', 'arrested'),
('Priya', 'Nair', NULL, '1992-07-07', 'female', 'Indian', 'ID89012', 'Pune, India', '9845012345', '[priya.nair@mail.com](mailto:priya.nair@mail.com)', '5ft4, glasses', 'ATM fraud link (2021)', 'acquitted'),
('Ankit', 'Tiwari', NULL, '1996-02-20', 'male', 'Indian', 'ID90123', 'Lucknow, India', '9823001122', '[ankit.tiwari@mail.com](mailto:ankit.tiwari@mail.com)', '5ft10, wheatish complexion', 'Suspected in kidnapping ring', 'person_of_interest'),
('Rekha', 'Das', NULL, '1987-08-18', 'female', 'Indian', 'ID01234', 'Kolkata, India', '9830002233', '[rekha.das@mail.com](mailto:rekha.das@mail.com)', '5ft2, short hair', 'Previously involved in local extortion case', 'suspect');

-- ========================================
-- Insert Case Assignments
-- ========================================
INSERT INTO case_assignments (case_id, suspect_id, involvement_level, notes) VALUES
(1, 1, 'primary_suspect', 'Seen near robbery site'),
(2, 7, 'primary_suspect', 'Digital trail confirmed'),
(3, 10, 'person_of_interest', 'Nearby residence'),
(4, 6, 'primary_suspect', 'Caught during raid'),
(5, 8, 'accomplice', 'ATM withdrawals linked'),
(6, 9, 'primary_suspect', 'Eye witness report'),
(7, 7, 'primary_suspect', 'Employee credentials misused'),
(8, 3, 'witness', 'Victim’s colleague'),
(9, 2, 'primary_suspect', 'Caught on CCTV'),
(10, 6, 'person_of_interest', 'Under interrogation');

-- ========================================
-- Insert Evidence
-- ========================================
INSERT INTO evidence (case_id, evidence_number, evidence_type, description, collection_date, collection_location, collected_by, storage_location, status, chain_of_custody_verified) VALUES
(1, 'EVID-0001', 'physical', 'Crowbar with fingerprints', '2025-01-11 10:00:00', 'Connaught Place, Delhi', 1, 'Delhi Central Storage A1', 'under_analysis', true),
(2, 'EVID-0002', 'digital', 'Server logs from victim website', '2025-03-06 09:00:00', 'Cyber Cell, Bangalore', 4, 'Digital Lab 2', 'analyzed', true),
(3, 'EVID-0003', 'forensic', 'Blood sample collected from scene', '2025-02-15 10:30:00', 'Park Street, Kolkata', 6, 'Forensic Lab KOL', 'under_analysis', false),
(4, 'EVID-0004', 'physical', 'Packet of narcotics recovered', '2024-11-30 23:50:00', 'Ambattur, Chennai', 5, 'Evidence Room CHN-02', 'stored', true),
(5, 'EVID-0005', 'digital', 'ATM camera footage', '2024-12-18 14:00:00', 'Shivajinagar, Pune', 8, 'Video Archive PUN', 'analyzed', true),
(6, 'EVID-0006', 'testimonial', 'Witness statement from parent', '2025-04-05 19:00:00', 'Hazratganj, Lucknow', 10, 'Case File', 'collected', false),
(7, 'EVID-0007', 'digital', 'Hard drive from suspect laptop', '2025-05-02 10:00:00', 'Electronic City, Bangalore', 4, 'Digital Lab 3', 'under_analysis', true),
(8, 'EVID-0008', 'documentary', 'Complaint letter from victim', '2025-06-15 21:00:00', 'Mansarovar, Jaipur', 10, 'Document Storage JPR', 'collected', true),
(9, 'EVID-0009', 'photographic', 'CCTV still image of suspect', '2024-10-10 08:30:00', 'Marine Drive, Mumbai', 3, 'Mumbai Crime Archive', 'stored', true),
(10, 'EVID-0010', 'forensic', 'DNA sample of terror suspect', '2025-08-22 11:45:00', 'Banjara Hills, Hyderabad', 7, 'Forensic Lab HYD', 'under_analysis', true);

-- ========================================
-- Insert Evidence Chain
-- ========================================
INSERT INTO evidence_chain (evidence_id, officer_id, action, location, notes) VALUES
(1, 1, 'collected', 'Connaught Place, Delhi', 'Collected from scene'),
(2, 4, 'analyzed', 'Cyber Lab Bangalore', 'Digital data examined'),
(3, 6, 'transferred', 'Forensic Lab KOL', 'Sent for analysis'),
(4, 5, 'stored', 'Evidence Room CHN-02', 'Stored post-seizure'),
(5, 8, 'analyzed', 'Video Archive PUN', 'Reviewed CCTV footage'),
(6, 10, 'collected', 'Hazratganj, Lucknow', 'Witness signed statement'),
(7, 4, 'analyzed', 'Digital Lab 3', 'Drive imaging complete'),
(8, 10, 'collected', 'Mansarovar, Jaipur', 'Complaint registered'),
(9, 3, 'stored', 'Mumbai Crime Archive', 'Evidence stored safely'),
(10, 7, 'analyzed', 'Forensic Lab HYD', 'DNA profile generated');

COMMIT;
