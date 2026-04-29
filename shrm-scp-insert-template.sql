-- SHRM-SCP Question Bank Insertion Script
-- Insert 100 questions across 4 domains (25 per domain)
-- Domain Distribution:
--   - Acuity (25 questions)
--   - Strategic HR Management (25 questions)
--   - HR Expertise (25 questions)
--   - Consultation & Business Acumen (25 questions)

-- Example SQL INSERT statement (customize for your database):
-- INSERT INTO questions (id, subject_slug, domain, question_text, options, correct_index, explanation, active)
-- VALUES 

-- Sample for first 3 questions:

('shrm-scp-001', 'shrm-scp', 'Acuity', 
 'An HR leader identifies that several high-performing employees are leaving the organization within 18 months of promotion. What is the BEST first step to address this retention issue?',
 '["Increase compensation for newly promoted employees", "Conduct exit interviews and analyze departure patterns", "Implement a formal mentoring program for all promoted staff", "Create retention bonuses contingent on 2-year tenure"]', 1, 
 'Exit interviews and analysis of departure patterns provide data-driven insights into why employees are leaving, enabling targeted interventions. While mentoring and retention bonuses may help, diagnosis through analysis is the logical first step before implementing solutions.', true),

('shrm-scp-002', 'shrm-scp', 'Acuity', 
 'A manufacturing plant experiences a 35% increase in workplace injuries over the past quarter. Which metric would BEST help the HR leader understand the root cause?',
 '["Injury severity rate (ISR)", "Lost workday injury frequency rate (LWIFR)", "Total injury frequency rate and correlation with staffing changes", "Workers'' compensation claim denial rate"]', 2, 
 'Analyzing the total injury frequency rate alongside staffing changes (such as turnover, new hires, or overtime increases) allows the HR leader to identify contributing factors. While ISR and LWIFR are valuable metrics, they don''t directly reveal causation related to workforce changes.', true),

('shrm-scp-003', 'shrm-scp', 'Acuity', 
 'A company''s voluntary turnover rate has doubled from 8% to 16% over two years. Which stakeholder group should the HR leader engage FIRST to understand external market factors?',
 '["Finance team to review compensation competitiveness", "Customers to gather feedback on service quality", "Industry peers and recruiters through stay interviews", "Terminated employees through detailed exit surveys"]', 2, 
 'Engaging industry peers and recruiters provides critical external market context on competitive compensation, hiring trends, and industry-wide talent challenges. This helps distinguish between internal (company-specific) and external (market-wide) causes of turnover.', true),

-- ... continue with remaining 97 questions
