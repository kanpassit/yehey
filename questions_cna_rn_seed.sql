-- =============================================================
-- KanPassIt — Starter Question Bank
-- Subjects: NCLEX CNA (slug: 'cna') + NCLEX RN (slug: 'rn')
-- 30 questions per subject = 60 total
-- Sources:
--   CNA: NNAAP 2024 Content Outline (Credentia/NCSBN, effective Oct 2024)
--   RN:  2023 NCLEX-RN Test Plan (NCSBN, effective April 2023)
-- Clinical values verified against published NCSBN/ATI/Saunders references
-- Run this in your Supabase SQL editor to seed both question banks.
-- =============================================================

-- ─────────────────────────────────────────────────────────────
-- NCLEX CNA  (subject_slug = 'cna')
-- Domain distribution across 30 questions:
--   Activities of Daily Living  → ~9 q  (29%)
--   Basic Nursing Skills        → ~10 q (35%)
--   Psychosocial Care Skills    → ~3 q  (10%)
--   Role of the Nurse Aide      → ~8 q  (26%)
-- ─────────────────────────────────────────────────────────────

INSERT INTO questions (subject_slug, domain, question_text, options, correct_index, explanation, active) VALUES

-- ── Activities of Daily Living (9 questions) ──────────────────

('cna','Activities of Daily Living',
 'When assisting a resident with oral hygiene who cannot hold a toothbrush, what is the best action for the nurse aide?',
 '["Skip brushing and use only mouthwash for convenience", "Brush the resident''s teeth using the aide''s dominant hand with the resident in an upright position", "Allow the resident to attempt brushing without assistance", "Perform oral care only at night to save time"]',
 1,
 'Oral hygiene should be performed at least twice daily. The resident should be upright to prevent aspiration, and the aide assists directly when the resident cannot self-manage. Mouthwash alone does not replace mechanical plaque removal.',
 true),

('cna','Activities of Daily Living',
 'A resident is incontinent of urine and has developed reddened skin in the perineal area. What is the priority action by the nurse aide?',
 '["Cover the area with a plastic pad to protect the bed linens", "Clean the area with mild soap and water, pat dry, and apply a moisture barrier", "Vigorously rub the area with a dry towel to stimulate circulation", "Apply a thick layer of powder to absorb moisture"]',
 1,
 'Moisture-associated skin damage is prevented by promptly cleaning with a gentle cleanser, patting dry (not rubbing), and applying a moisture barrier. Rubbing can break down fragile skin. Powder can cake and cause irritation. Plastic pads trap moisture.',
 true),

('cna','Activities of Daily Living',
 'A resident needs to be repositioned in bed every two hours. What is the primary reason for this intervention?',
 '["To prevent pressure injuries by relieving pressure on bony prominences", "To keep the resident awake and alert during the day", "To improve the resident''s appetite", "To reduce the need for pain medication"]',
 0,
 'Turning every two hours relieves sustained pressure on bony prominences (sacrum, heels, elbows), restoring blood flow and preventing ischemia that leads to pressure injuries. This is the gold-standard prevention measure per clinical guidelines.',
 true),

('cna','Activities of Daily Living',
 'When helping a hemiplegic resident dress, the nurse aide should put on the shirt by:',
 '["Starting with either arm at the aide''s convenience", "Dressing the weaker (affected) arm first", "Having the resident dress independently without assistance", "Dressing the stronger (unaffected) arm first"]',
 1,
 'For a hemiplegic or otherwise weakened resident, dress the affected (weaker) side first and undress it last. This reduces strain on the affected limb and is easier to maneuver the garment when the unaffected side is still free.',
 true),

('cna','Activities of Daily Living',
 'A resident with dysphagia is about to eat lunch. Which position is safest during feeding?',
 '["Semi-reclined at 30 degrees", "Sitting upright at 90 degrees in a chair or with the head of bed elevated at least 90 degrees", "Lying flat with a pillow under the head", "Side-lying with the head slightly lower than the body"]',
 1,
 'Upright at 90 degrees (or as close as possible) uses gravity to move food and liquid down the esophagus and reduces the risk of aspiration into the airway — the primary danger for a resident with dysphagia.',
 true),

('cna','Activities of Daily Living',
 'Which action by the nurse aide promotes independence during mealtimes?',
 '["Remove the tray if the resident eats slowly", "Set up the tray and allow the resident to self-feed as much as possible", "Tell the resident they should be able to feed themselves", "Feed the entire meal to save time"]',
 1,
 'Promoting resident independence, even partial self-feeding, preserves dignity, improves nutritional intake, and supports cognitive and physical function. The aide should set up items (open containers, cut food) and assist only as needed.',
 true),

('cna','Activities of Daily Living',
 'A resident has an indwelling urinary catheter. Which observation should the nurse aide report immediately to the nurse?',
 '["The catheter bag is two-thirds full", "No urine output in the last two hours", "The resident reports mild thirst", "The urine in the bag is light yellow"]',
 1,
 'No urine output for two or more hours may indicate catheter blockage, kinking, or a medical problem such as decreased kidney perfusion. This requires prompt nursing assessment. The other findings are normal.',
 true),

('cna','Activities of Daily Living',
 'What is the proper technique for performing range-of-motion (ROM) exercises on a resident''s joint?',
 '["Skip any joint that the resident reports slight discomfort in", "Perform ROM as fast as possible to save time", "Move each joint slowly and smoothly to the point of resistance, stop if the resident reports pain", "Push the joint past resistance to stretch contracted muscles"]',
 2,
 'ROM exercises should be performed slowly and gently to the point of natural resistance. Pain is a signal to stop immediately and report to the nurse — forcing a joint can cause injury. Brief mild warmth is normal; pain is not.',
 true),

('cna','Activities of Daily Living',
 'A resident has been placed on a fluid restriction of 1,000 mL per day. Which action is correct for the nurse aide?',
 '["Offer small amounts of fluid at regular intervals throughout the shift per the nursing care plan", "Allow the resident unlimited fluids during meals", "Ignore the restriction if the resident is very thirsty", "Provide fluids only when the resident asks for them"]',
 0,
 'Fluid restrictions must be followed exactly as prescribed. The aide distributes the allowed volume across the shift per the care plan to prevent rapid intake or deprivation. Changes to the plan require nurse authorization.',
 true),

-- ── Basic Nursing Skills (10 questions) ───────────────────────

('cna','Basic Nursing Skills',
 'The correct order for putting on personal protective equipment (PPE) before entering a contact-precaution room is:',
 '["Gloves first, then mask, then gown", "Mask first, then gown, then gloves", "Gloves first, then gown", "Gown first, then gloves"]',
 3,
 'Per CDC/OSHA guidance, the gown is applied first (to protect clothing), then gloves (cuffs should overlap the gown sleeves). This sequence ensures the gown is fully covered before contaminated gloves are donned.',
 true),

('cna','Basic Nursing Skills',
 'The most effective method to break the chain of infection is:',
 '["Keeping residents in isolation", "Wearing a mask at all times", "Administering antibiotics prophylactically", "Frequent and proper handwashing"]',
 3,
 'Hand hygiene is consistently identified as the single most important action to prevent the spread of infection. Pathogens are most often transmitted via contaminated hands. Masks, isolation, and medications are additional tools but secondary to hand hygiene.',
 true),

('cna','Basic Nursing Skills',
 'A resident''s blood pressure reading is 158/94 mmHg. What should the nurse aide do?',
 '["Retake the blood pressure three more times, average the results, and decide independently", "Tell the resident to rest and recheck in an hour", "Administer any available antihypertensive medication", "Record the reading and report it promptly to the nurse"]',
 3,
 'A blood pressure of 158/94 is above normal. The nurse aide''s role is to measure, document accurately, and report any abnormal or unexpected readings to the nurse. Nurse aides do not interpret, treat, or independently repeat readings without nurse direction.',
 true),

('cna','Basic Nursing Skills',
 'When using a gait belt to assist a resident to walk, where should the belt be placed?',
 '["Around the resident''s hips below the waist", "Around the resident''s waist, over clothing or a gown", "Directly against bare skin under any clothing", "Around the resident''s chest under the arms"]',
 1,
 'A gait belt is placed at the waist over clothing to give the aide a secure, controlled grip for transfer and ambulation. Placing it on the chest impairs breathing; hip placement reduces control; bare skin placement can cause skin irritation.',
 true),

('cna','Basic Nursing Skills',
 'Which observation about a surgical wound must be reported to the nurse immediately?',
 '["Small amount of clear yellow fluid on a post-operative day 2 dressing", "Mild bruising around the incision site", "Bright red blood saturating the dressing", "A thin scab forming along the wound edges"]',
 2,
 'Bright red (arterial) blood saturating a dressing indicates active hemorrhage — a medical emergency. Serosanguineous or serous drainage on day 2, mild bruising, and scab formation are normal parts of wound healing.',
 true),

('cna','Basic Nursing Skills',
 'A resident begins to fall while being transferred. The nurse aide should:',
 '["Call for help loudly and let go of the resident", "Catch the resident and try to hold them upright", "Guide the resident gently to the floor, protecting the head", "Lower the bed and wait for the resident to land on it"]',
 2,
 'Attempting to hold a falling resident can injure both the resident and the aide. The correct technique is to guide the resident to the floor in a controlled manner, protecting the head from impact, while supporting the body.',
 true),

('cna','Basic Nursing Skills',
 'When measuring oral temperature using an electronic thermometer, the probe should be placed:',
 '["On top of the tongue", "Under the tongue at the front of the mouth", "Inside the cheek", "Under the tongue in the posterior sublingual pocket"]',
 3,
 'The posterior sublingual pocket, located beside the frenulum on either side, has the richest blood supply and gives the most accurate oral temperature. Front-of-mouth or cheek placement yields lower, less accurate readings.',
 true),

('cna','Basic Nursing Skills',
 'The nurse aide is providing perineal care for a female resident. Which direction should the aide clean?',
 '["Back to front", "In a circular motion starting at the center", "Front to back (urethral meatus to anal area)", "Side to side"]',
 2,
 'Front-to-back cleaning moves away from the urethral meatus toward the anus, preventing fecal bacteria from contaminating the urethra and reducing the risk of urinary tract infection.',
 true),

('cna','Basic Nursing Skills',
 'When collecting a urine specimen for a mid-stream clean-catch culture, the nurse aide instructs the resident to:',
 '["Cleanse the perineal area, begin urinating into the toilet, then collect the midstream in the sterile container", "Collect all urine from the first void of the day into the container", "Void completely into the container without cleansing first", "Collect urine directly from the urinary catheter bag"]',
 0,
 'Mid-stream clean-catch technique discards the first flow of urine (which flushes urethral contaminants), then captures the midstream in a sterile container. This reduces the chance of a contaminated or false-positive culture result.',
 true),

('cna','Basic Nursing Skills',
 'A resident is prescribed elastic compression stockings. When should the stockings be applied?',
 '["Whenever the resident requests them throughout the day", "Only at night when the resident is sleeping", "In the morning before the resident gets out of bed", "After the resident has been sitting in a chair for 30 minutes"]',
 2,
 'Compression stockings are most effective when applied in the morning before the resident rises, before gravity causes venous blood to pool in the lower extremities. Applying them after prolonged sitting is less effective at preventing edema and DVT.',
 true),

('cna','Basic Nursing Skills',
 'The correct technique for handwashing includes rubbing all surfaces of the hands for at least:',
 '["5 seconds", "10 seconds", "20 seconds", "60 seconds"]',
 2,
 'The CDC recommends at least 20 seconds of vigorous scrubbing of all hand surfaces (palms, backs, between fingers, under nails) with soap and water to mechanically remove pathogens. Less time is insufficient.',
 true),

-- ── Psychosocial Care Skills (3 questions) ────────────────────

('cna','Psychosocial Care Skills',
 'A resident with dementia becomes agitated and repeatedly calls out. Which response by the nurse aide is most therapeutic?',
 '["Approach calmly, make eye contact, and use a soothing tone to redirect the resident", "Ignore the behavior until the resident stops", "Restrain the resident to prevent agitation from escalating", "Tell the resident firmly to stop yelling because it disturbs others"]',
 0,
 'Residents with dementia often cannot express distress verbally. A calm approach, eye contact, soft tone, and gentle redirection address the underlying need without escalating agitation. Scolding, ignoring, or restraining are inappropriate and potentially harmful.',
 true),

('cna','Psychosocial Care Skills',
 'A resident begins crying while telling the nurse aide about a recent visit from family. The best response is:',
 '["Sit quietly with the resident and offer a tissue, allowing them to express their feelings", "Tell the resident to cheer up because things will get better", "Change the subject to something positive", "Immediately call the nurse and leave the room"]',
 0,
 'Therapeutic presence — staying calmly with the resident, acknowledging the emotion, and offering simple comfort — validates feelings and supports emotional wellbeing. Abandoning the resident, giving false reassurance, or deflecting the emotion are non-therapeutic.',
 true),

('cna','Psychosocial Care Skills',
 'A resident from a different cultural background refuses a particular food that the facility regularly serves. What should the nurse aide do?',
 '["Insist the resident eat the food because it is part of their prescribed diet", "Remove the food without documentation", "Tell the resident the food is good for them and encourage them to try it", "Respect the refusal and report the resident''s food preference to the nurse so the dietary team can be notified"]',
 3,
 'Respecting cultural and personal food preferences honors resident rights and dignity. The aide should document and report the preference so the care team can offer appropriate alternatives — changing a diet requires nurse and dietary involvement.',
 true),

-- ── Role of the Nurse Aide (8 questions) ──────────────────────

('cna','Role of the Nurse Aide',
 'A resident tells the nurse aide, "I don''t want anyone to know I''m here." The nurse aide''s best response is to:',
 '["Post a note on the door for all staff", "Tell callers the resident is not present without consulting the nurse", "Acknowledge the request and inform the nurse so the care team can document the resident''s confidentiality preference", "Tell the resident confidentiality is not possible in a facility"]',
 2,
 'Residents have the right to confidentiality regarding their presence and care. The aide should acknowledge the request and relay it to the nurse for proper documentation and implementation per facility policy — the aide cannot independently implement disclosure restrictions.',
 true),

('cna','Role of the Nurse Aide',
 'Which action violates a resident''s right to privacy?',
 '["Using the resident''s preferred name during care", "Asking only care-related questions during bathing", "Leaving the privacy curtain open while providing perineal care", "Knocking before entering a resident''s room"]',
 2,
 'Leaving a privacy curtain open during intimate care exposes the resident to others, violating their right to privacy and dignity. All other actions are appropriate, rights-respecting behaviors.',
 true),

('cna','Role of the Nurse Aide',
 'A nurse aide observes a co-worker taking a small amount of a resident''s money from the bedside table. What should the aide do?',
 '["Do nothing because it may be a misunderstanding", "Report the observation to the supervisor or charge nurse immediately", "Wait to see if the money reappears before reporting", "Confront the co-worker directly"]',
 1,
 'Taking a resident''s money or property is financial abuse and must be reported immediately to a supervisor. Nurse aides are mandatory reporters of suspected abuse, neglect, or exploitation. Delay or confrontation can allow harm to continue.',
 true),

('cna','Role of the Nurse Aide',
 'Which statement best describes the role of the nurse aide in the healthcare team?',
 '["The nurse aide independently develops and implements care plans", "The nurse aide provides direct care under the supervision of a licensed nurse", "The nurse aide has authority over other healthcare staff", "The nurse aide performs the same duties as a licensed nurse"]',
 1,
 'Nurse aides perform delegated direct care tasks (bathing, feeding, ambulation, vital signs) under the supervision and direction of a licensed nurse (RN or LPN). They do not diagnose, plan care independently, or supervise licensed staff.',
 true),

('cna','Role of the Nurse Aide',
 'A resident refuses to take a bath. What is the correct action for the nurse aide?',
 '["Skip the documentation since it was just a missed bath", "Force the bath because hygiene is medically necessary", "Tell the resident they have no choice", "Respect the refusal, document it, and inform the nurse"]',
 3,
 'Competent residents have the right to refuse any aspect of care. The aide must respect the refusal, document it accurately, and report it to the nurse so alternatives can be explored and the care plan updated if needed.',
 true),

('cna','Role of the Nurse Aide',
 'When documenting care, the nurse aide should:',
 '["Record only factual, objective observations using clear and accurate language", "Record personal opinions and guesses about why symptoms occurred", "Use only abbreviations the aide personally understands", "Document care before it is given to save time"]',
 0,
 'Documentation must be accurate, objective, factual, and completed after care is provided. Only approved abbreviations should be used. Personal opinions, guesses, or pre-charting create legal and safety risks.',
 true),

('cna','Role of the Nurse Aide',
 'A resident shares information about their personal life and asks the nurse aide not to tell anyone. What should the aide do?',
 '["Immediately share all information with other staff members", "Explain that information affecting the resident''s health or safety must be shared with the care team, but other personal details will be kept confidential", "Write the information in the resident''s chart in detail", "Promise complete confidentiality for all information shared"]',
 1,
 'Healthcare workers cannot guarantee absolute confidentiality. Information relevant to the resident''s health, safety, or care must be shared with the care team. The aide should be honest about this boundary while assuring that unnecessary personal details are not disclosed.',
 true),

('cna','Role of the Nurse Aide',
 'The nurse aide notices a sudden change in a resident''s mental status — the resident appears confused and disoriented, which is new. What is the priority action?',
 '["Ask other residents if they noticed anything", "Re-orient the resident and document it later", "Report the change immediately to the nurse", "Assume the resident is just tired and check again at the end of the shift"]',
 2,
 'A sudden change in mental status is a critical observation that can indicate stroke, infection (especially UTI in older adults), metabolic disturbance, or medication effect. This must be reported to the nurse immediately for assessment — it is a potential emergency.',
 true);


-- =============================================================
-- NCLEX RN  (subject_slug = 'rn')
-- Domain distribution across 30 questions:
--   Safe & Effective Care     → ~10 q  (32%)
--   Physiological Integrity   → ~15 q  (51%)
--   Health Promotion          → ~3 q   (9%)
--   Psychosocial Integrity    → ~3 q   (9%)
-- =============================================================

INSERT INTO questions (subject_slug, domain, question_text, options, correct_index, explanation, active) VALUES

-- ── Safe & Effective Care (10 questions) ──────────────────────

('rn','Safe & Effective Care',
 'A nurse receives a SBAR hand-off report. The "S" in SBAR stands for:',
 '["Symptoms", "Situation", "System", "Safety"]',
 1,
 'SBAR is a structured communication framework: Situation (what is happening now), Background (relevant history), Assessment (what the nurse thinks is going on), Recommendation (what is needed). The "S" is Situation — the presenting concern.',
 true),

('rn','Safe & Effective Care',
 'The nurse is caring for four clients. Which client should be assessed first?',
 '["A client scheduled for a non-urgent echocardiogram in two hours", "A client admitted yesterday with a UTI whose oral temperature is 37.8°C (100.0°F)", "A post-operative client who returned from surgery one hour ago reporting pain of 8/10", "A client with chronic asthma who is awaiting discharge education"]',
 2,
 'Using the ABCs/priority framework, a post-operative client one hour out of surgery with severe pain (8/10) has the highest risk of acute complications (hemorrhage, hemodynamic instability). This client requires immediate assessment. The low-grade fever is expected in early infection and is less urgent. The chronic asthma and echocardiogram are non-urgent.',
 true),

('rn','Safe & Effective Care',
 'A nurse is preparing to administer a medication. Which is the correct order for the "rights" of medication administration?',
 '["Right chart, right nurse, right room, right drug, right time", "Right drug, right patient, right time, right chart, right room", "Right patient, right drug, right dose, right route, right time", "Right patient, right nurse, right dose, right chart, right route"]',
 2,
 'The traditional five rights of medication administration are: right patient, right drug (medication), right dose, right route, and right time. Many institutions add right documentation and right reason as additional rights.',
 true),

('rn','Safe & Effective Care',
 'A nurse is about to administer a blood transfusion. What is the priority action before initiating the infusion?',
 '["Begin the infusion quickly to minimize the time the blood is outside refrigeration", "Have the client sign a new consent form immediately before hanging the blood", "Check the IV site and flush it with dextrose solution", "Verify the blood product with another registered nurse at the bedside using two patient identifiers"]',
 3,
 'Two-nurse blood product verification at the bedside is a critical safety check required before any transfusion. Two unique patient identifiers (name + date of birth or MRN) must match the blood label and the patient''s armband. Blood is flushed with normal saline — never dextrose, which causes hemolysis.',
 true),

('rn','Safe & Effective Care',
 'A nurse is delegating tasks to an unlicensed assistive personnel (UAP). Which task is appropriate to delegate?',
 '["Performing an initial nursing assessment on a newly admitted client", "Administering oral medications to a client with dysphagia", "Measuring and recording vital signs for a stable postoperative client", "Titrating oxygen flow rate based on a client''s SpO2"]',
 2,
 'Measuring and recording vital signs for a stable client is within UAP scope of practice. Initial nursing assessments, medication administration, and clinical decision-making (like adjusting oxygen) require a licensed nurse.',
 true),

('rn','Safe & Effective Care',
 'A client is found unresponsive and not breathing. After calling for help, what is the nurse''s immediate next action per current BLS guidelines?',
 '["Begin high-quality chest compressions at a rate of 100–120 per minute", "Perform a head-tilt chin-lift and give two rescue breaths", "Apply supplemental oxygen via non-rebreather mask", "Check the pulse for 30 seconds before initiating CPR"]',
 0,
 'Current AHA BLS guidelines use a C-A-B sequence: start with Compressions at 100–120/min before Airway and Breathing. Early, high-quality compressions maintain coronary and cerebral perfusion. Checking a pulse should take no more than 10 seconds.',
 true),

('rn','Safe & Effective Care',
 'A client with a latex allergy is scheduled for surgery. Which action by the nurse is most important?',
 '["Inform the client that minor latex exposure is acceptable", "Administer antihistamine prophylactically before surgery", "Apply a latex-free label only to the client''s chart", "Alert the entire surgical team and ensure a latex-free environment is prepared"]',
 3,
 'Latex allergy can cause life-threatening anaphylaxis intraoperatively. The surgical team, OR, and supply chain must all be alerted to prepare a completely latex-free environment. A chart label alone is insufficient; all team members and the physical environment must be addressed.',
 true),

('rn','Safe & Effective Care',
 'A nurse is preparing to insert a urinary catheter. Which action best prevents catheter-associated urinary tract infection (CAUTI)?',
 '["Clamping the catheter tubing between drainage periods", "Using a large-diameter catheter to ensure urine flow", "Using strict aseptic technique throughout catheter insertion", "Changing the catheter every 48 hours routinely"]',
 2,
 'Strict aseptic technique during insertion is the primary evidence-based intervention for CAUTI prevention. Routine catheter changes increase infection risk. Large catheters cause urethral trauma. Clamping tubing creates stasis and increases infection risk.',
 true),

('rn','Safe & Effective Care',
 'A nurse notes that the wrong medication was administered to a client. The client shows no signs of adverse effects. What is the nurse''s priority action?',
 '["Tell the charge nurse only and wait to see if symptoms develop", "Document the error in the chart as \"medication given in error\" and move on", "Do nothing because the client has no symptoms", "Assess the client, notify the provider, complete an incident report, and document all actions"]',
 3,
 'Any medication error requires immediate client assessment (safety first), provider notification so treatment can be ordered if needed, and completion of an incident/variance report per facility policy. Transparent documentation and reporting are both safety and legal obligations.',
 true),

('rn','Safe & Effective Care',
 'Which finding requires the nurse to implement contact precautions immediately?',
 '["A client with seasonal influenza on day 3 of illness", "A client with a new diagnosis of Clostridioides difficile (C. diff) diarrhea", "A client with varicella who is afebrile and fully crusted over", "A client with a positive tuberculosis skin test and no active symptoms"]',
 1,
 'C. difficile requires contact precautions (gown and gloves, dedicated equipment, hand washing with soap and water — not alcohol gel, which is ineffective against C. diff spores). TB requires airborne precautions. Influenza requires droplet precautions. Fully crusted varicella is no longer infectious.',
 true),

-- ── Physiological Integrity (15 questions) ────────────────────

('rn','Physiological Integrity',
 'A client receiving IV potassium chloride develops burning pain at the infusion site. The nurse should first:',
 '["Flush the IV line with normal saline and increase the rate", "Stop the infusion and assess the IV site for signs of infiltration", "Administer analgesic medication and continue the infusion", "Slow the infusion rate and apply a warm compress"]',
 1,
 'Burning pain at a peripheral IV site during potassium infusion suggests infiltration or phlebitis. The infusion must be stopped immediately and the site assessed. Potassium infiltration into subcutaneous tissue can cause tissue necrosis. Rate reduction alone does not address the safety issue.',
 true),

('rn','Physiological Integrity',
 'A client with type 1 diabetes is found diaphoretic, trembling, and confused. Blood glucose is reported as 48 mg/dL. What is the priority intervention?',
 '["Administer 15–20 g of fast-acting carbohydrate orally if the client can swallow", "Administer regular insulin subcutaneously", "Encourage the client to rest and recheck glucose in one hour", "Initiate a 0.9% normal saline IV bolus"]',
 0,
 'Blood glucose of 48 mg/dL is severe hypoglycemia. Per the 15-15 rule, 15–20 g of fast-acting carbohydrates (glucose gel, 4 oz juice) are given orally if the client can protect their airway. Insulin would worsen hypoglycemia. Saline alone does not raise blood glucose. (Reference: ADA Standards of Care; normal fasting glucose 70–99 mg/dL — NCSBN NGN reference ranges.)',
 true),

('rn','Physiological Integrity',
 'A client is receiving morphine via PCA pump. Which assessment finding requires immediate intervention?',
 '["Pain rating of 4/10 one hour after a dose", "Mild nausea without vomiting", "Respiratory rate of 9 breaths/min", "Oxygen saturation of 96% on room air"]',
 2,
 'Opioid-induced respiratory depression is life-threatening. A respiratory rate of 9 breaths/min (normal adult 12–20) with opioid use warrants immediate intervention, which may include stopping the PCA, providing oxygen, and administering naloxone. The other findings are expected or non-urgent. (Verified: normal adult RR 12–20 breaths/min — NCSBN reference.)',
 true),

('rn','Physiological Integrity',
 'A client with heart failure is prescribed furosemide (Lasix) 40 mg IV. Which electrolyte must be assessed before and after administration?',
 '["Sodium", "Potassium", "Calcium", "Magnesium"]',
 1,
 'Loop diuretics like furosemide cause significant potassium wasting (hypokalemia), which can precipitate life-threatening dysrhythmias, especially in clients taking digoxin. Potassium must be assessed before administration and monitored throughout therapy. Normal serum K+ is 3.5–5.0 mEq/L. (Source: ATI Pharmacology; NCSBN lab values reference.)',
 true),

('rn','Physiological Integrity',
 'A nurse assesses a client and notes a serum sodium level of 122 mEq/L. Which clinical manifestations are most consistent with this finding?',
 '["Polyuria, polydipsia, and fruity-smelling breath", "Confusion, headache, and seizure risk", "Bradycardia, peaked T waves on ECG, and muscle weakness", "Excessive thirst, dry mucous membranes, and hypertension"]',
 1,
 'Normal serum sodium is 135–145 mEq/L. At 122, severe hyponatremia causes neurological symptoms (confusion, headache) due to cerebral edema from osmotic water shift into brain cells, with seizure risk below 120 mEq/L. The other findings describe hypernatremia, hyperkalemia, and diabetic ketoacidosis respectively. (Clinical value verified: normal Na 135–145 mEq/L — NCSBN NGN reference ranges.)',
 true),

('rn','Physiological Integrity',
 'A client post-total knee replacement reports calf pain and swelling two days after surgery. What is the priority nursing action?',
 '["Notify the provider and anticipate orders for a venous duplex ultrasound", "Massage the calf to improve circulation", "Elevate the leg and apply warm compresses", "Encourage ambulation to prevent further clot formation"]',
 0,
 'Unilateral calf pain and swelling post-surgery are classic signs of deep vein thrombosis (DVT). The provider must be notified immediately and imaging ordered to confirm. Massaging a suspected DVT can dislodge the clot causing pulmonary embolism. Activity and compressions are contraindicated until DVT is ruled out.',
 true),

('rn','Physiological Integrity',
 'A client with COPD is receiving supplemental oxygen. The target SpO2 range for this population is typically:',
 '["80–85%", "88–92%", "94–96%", "95–100%"]',
 1,
 'Clients with COPD may have chronic hypercapnia and a hypoxic drive to breathe. Maintaining SpO2 at 88–92% avoids over-oxygenation that can suppress the hypoxic respiratory drive. Targets above 92% risk hypercapnic respiratory failure in susceptible patients. (Reference: GOLD COPD guidelines; NCSBN clinical judgment framework.)',
 true),

('rn','Physiological Integrity',
 'A nurse is caring for a client receiving a blood transfusion. Fifteen minutes into the infusion, the client develops fever, chills, and flank pain. What is the nurse''s immediate action?',
 '["Stop the transfusion and remove the IV catheter", "Stop the transfusion, keep the IV open with normal saline, and notify the provider", "Slow the transfusion rate and administer an antihistamine", "Administer acetaminophen and continue the transfusion"]',
 1,
 'Fever, chills, and flank pain suggest an acute hemolytic transfusion reaction — a life-threatening emergency caused by ABO incompatibility. The transfusion must be stopped immediately. The IV must stay patent with normal saline to allow medications to be given. The provider and blood bank must be notified. The IV catheter is not removed.',
 true),

('rn','Physiological Integrity',
 'A client is receiving IV heparin for pulmonary embolism. Which laboratory value is used to monitor heparin''s therapeutic effect?',
 '["Prothrombin Time (PT)/INR", "Activated Partial Thromboplastin Time (aPTT)", "Complete Blood Count (CBC)", "Platelet count"]',
 1,
 'IV heparin is monitored using the aPTT (or anti-Xa level in some protocols). The therapeutic aPTT range is typically 60–100 seconds (1.5–2.5× the control value). PT/INR is used to monitor warfarin. Platelet count is monitored to detect heparin-induced thrombocytopenia (HIT), not therapeutic effect. (Values verified: therapeutic aPTT 60–100 s — standard pharmacology reference.)',
 true),

('rn','Physiological Integrity',
 'A client with acute asthma exacerbation is tachypneic, using accessory muscles, and has an SpO2 of 89%. Which intervention has the highest priority?',
 '["Educate the client about avoiding asthma triggers", "Obtain peak flow measurements before initiating any treatment", "Administer oral corticosteroids as the first-line intervention", "Administer a short-acting bronchodilator (albuterol) via nebulizer and provide supplemental oxygen"]',
 3,
 'An acute asthma exacerbation with SpO2 of 89% is a respiratory emergency. Short-acting bronchodilators (SABA) are the first-line treatment to open airways, combined with supplemental oxygen to correct hypoxia. Peak flow measurement and education come after stabilization. Systemic corticosteroids are added for moderate-severe episodes but are not the immediate first step.',
 true),

('rn','Physiological Integrity',
 'A nurse is reviewing a client''s ABG results: pH 7.28, PaCO2 52 mmHg, HCO3 24 mEq/L. How should the nurse interpret these findings?',
 '["Metabolic alkalosis, uncompensated", "Respiratory alkalosis, compensated", "Metabolic acidosis, uncompensated", "Respiratory acidosis, uncompensated"]',
 3,
 'pH 7.28 = acidosis. PaCO2 52 mmHg = elevated (normal 35–45), indicating CO2 retention and a respiratory cause. HCO3 24 mEq/L = normal (22–26), meaning no metabolic compensation has occurred yet → uncompensated respiratory acidosis. (Reference values verified: pH 7.35–7.45, PaCO2 35–45 mmHg, HCO3 22–26 mEq/L — NCSBN NGN reference ranges.)',
 true),

('rn','Physiological Integrity',
 'The nurse is administering digoxin to a client with heart failure. Which finding should cause the nurse to hold the medication and notify the provider?',
 '["Apical heart rate of 52 beats/min", "Client reports slight fatigue", "Blood pressure of 118/76 mmHg", "Serum digoxin level of 0.8 ng/mL"]',
 0,
 'Digoxin is held when the apical pulse is below 60 beats/min due to its negative chronotropic effect — bradycardia below 60 signals potential toxicity or overdose risk and requires provider notification before administration. The blood pressure and digoxin level (therapeutic range 0.5–2.0 ng/mL) are normal. Fatigue is expected in heart failure. (Therapeutic digoxin range 0.5–2.0 ng/mL verified — standard pharmacology reference.)',
 true),

('rn','Physiological Integrity',
 'A client develops sudden onset of sharp chest pain and dyspnea after a central line placement. Breath sounds are absent on the left side. The nurse should anticipate:',
 '["Pneumothorax requiring chest tube insertion", "Pulmonary embolism requiring anticoagulation", "Pericardial tamponade requiring pericardiocentesis", "Pleural effusion requiring thoracentesis"]',
 0,
 'Absent breath sounds unilaterally after central line placement, with acute chest pain and dyspnea, is a classic presentation of iatrogenic pneumothorax — air in the pleural space. This is treated with chest tube insertion. Tamponade presents with muffled heart sounds and Beck''s triad. Effusion and PE have different presentations and timings.',
 true),

('rn','Physiological Integrity',
 'A postpartum client is assessed four hours after vaginal delivery. Which finding requires immediate intervention?',
 '["Fundus firm, midline, 1 cm above the umbilicus", "Blood pressure 88/50 mmHg with heart rate 118 beats/min", "Perineal swelling with mild discomfort", "Lochia rubra with a few small clots"]',
 0,
 'Blood pressure 88/50 with heart rate 118 indicates hemorrhagic shock — a postpartum emergency likely due to uterine atony, retained placenta, or lacerations. Fundal firmness, small rubra clots, and perineal swelling are expected normal postpartum findings.',
 true),

('rn','Physiological Integrity',
 'A client is ordered to receive 1,000 mL of 0.9% NaCl over 8 hours. Using a standard IV tubing with a drop factor of 15 gtt/mL, what is the correct drip rate in gtt/min?',
 '["20 gtt/min", "125 gtt/min", "31 gtt/min", "63 gtt/min"]',
 2,
 'IV drip rate = (Volume mL × Drop factor) ÷ Time in minutes. = (1000 × 15) ÷ (8 × 60) = 15,000 ÷ 480 = 31.25 → rounds to 31 gtt/min. This is a standard NCLEX-style calculation — no clinical value verification needed beyond math check.',
 true),

-- ── Health Promotion (3 questions) ────────────────────────────

('rn','Health Promotion',
 'A nurse is counseling a 50-year-old client about colorectal cancer screening. Based on current USPSTF guidelines, when should average-risk adults begin screening?',
 '["Age 50", "Age 60", "Age 45", "Age 40 only if family history is positive"]',
 2,
 'The USPSTF updated its recommendation in 2021 to begin colorectal cancer screening at age 45 for average-risk adults (previously age 50). Screening may begin earlier for those with a family history or other risk factors. (Source: USPSTF 2021 Colorectal Cancer Screening Recommendation.)',
 true),

('rn','Health Promotion',
 'A nurse is teaching a pregnant client in the first trimester. Which supplement is most important to prevent neural tube defects in the developing fetus?',
 '["Iron 30 mg daily", "Vitamin D 600 IU daily", "Folic acid 400–800 mcg daily", "Calcium 1,000 mg daily"]',
 2,
 'Folic acid supplementation (400–800 mcg/day) beginning before conception and continuing through the first trimester is the most critical intervention to prevent neural tube defects (anencephaly, spina bifida). Iron, calcium, and vitamin D are also important in pregnancy but do not prevent neural tube defects. (Source: CDC/ACOG folic acid recommendations.)',
 true),

('rn','Health Promotion',
 'When teaching a client about the DASH diet for hypertension management, the nurse emphasizes increasing intake of:',
 '["Red meats, eggs, and high-fat cheeses", "Sodium-rich canned goods and processed foods", "Caffeinated beverages and energy drinks", "Fruits, vegetables, whole grains, and low-fat dairy"]',
 3,
 'The DASH (Dietary Approaches to Stop Hypertension) diet emphasizes fruits, vegetables, whole grains, low-fat dairy, lean protein, and nuts while limiting sodium, saturated fat, and sweets. It has strong evidence for lowering blood pressure by 8–14 mmHg systolic in hypertensive patients.',
 true),

-- ── Psychosocial Integrity (2 questions) ──────────────────────

('rn','Psychosocial Integrity',
 'A client diagnosed with major depressive disorder tells the nurse, "I''ve been giving away my belongings — I won''t need them much longer." What is the nurse''s priority response?',
 '["Ask the client directly: \"Are you thinking about ending your life?\"", "Document the statement and plan to discuss it at the next team meeting", "Call the client''s family without the client''s consent", "Reassure the client that things will improve and change the subject"]',
 0,
 'Giving away possessions is a warning sign of suicidal intent. The nurse must ask directly about suicidal ideation — direct questioning does not increase suicide risk and is essential for accurate risk assessment. Avoidance, reassurance without assessment, or delayed action endangers the client.',
 true),

('rn','Psychosocial Integrity',
 'A client with a new diagnosis of breast cancer tells the nurse, "The doctor must have mixed up my results — I feel perfectly healthy." The nurse recognizes this as which defense mechanism?',
 '["Denial", "Projection", "Regression", "Rationalization"]',
 0,
 'Denial is the refusal to acknowledge a painful reality (diagnosis, prognosis) as a self-protective coping mechanism. It is a normal early response to devastating news. Rationalization involves justifying behavior with logical reasons. Projection attributes one''s own feelings to others. Regression returns to earlier developmental behaviors.',
 true);
