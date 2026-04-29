# SHRM-SCP Course Setup Guide

## ✅ What's Been Done

### 1. **Generated 100 SHRM-SCP Exam Questions**
   - **25 Acuity** questions (questions 001-025)
   - **25 Strategic HR Management** questions (questions 026-050)
   - **25 HR Expertise** questions (questions 051-075)
   - **25 Consultation & Business Acumen** questions (questions 076-100)
   - All questions include: question text, 4 answer options (A/B/C/D), correct answer index, and detailed explanations

### 2. **Updated index.html**
   - Added SHRM-SCP to the SUBJECTS object with full configuration:
     - Icon: 👔 (tie)
     - Color: #6f42c1 (purple)
     - 4 domain categories with weights
     - AI context for study analysis
   - Updated meta tags to include SHRM-SCP in keywords and description
   - SHRM-CP remains as a separate course (not replaced)

### 3. **Created Question Data Files**
   - `shrm-scp-complete-100-questions.json` — All 100 questions formatted for database insertion
   - `shrm-scp-insert-template.sql` — SQL INSERT template for your database
   - `SHRM-SCP-SETUP-GUIDE.md` — This file

---

## 📋 Next Steps: Getting Questions Into Supabase

### Option A: Manual Insertion via Supabase Dashboard (Simplest)

1. Log in to your Supabase project at https://app.supabase.com
2. Go to **SQL Editor** and create a new query
3. Insert the 100 questions using the template below (batch inserts work best)
4. Questions will auto-sync to the app via the `loadQuestions()` function

### Option B: Use Supabase API (Programmatic)

```javascript
// In your backend or Supabase function:
const questions = [
  {
    subject_slug: 'shrm-scp',
    domain: 'Acuity',
    question_text: '...',
    options: ['A', 'B', 'C', 'D'],
    correct_index: 1,
    explanation: '...',
    active: true
  },
  // ... repeat for all 100
];

await supabase.from('questions').insert(questions);
```

### Option C: Use the JSON File I Created

The file `shrm-scp-complete-100-questions.json` contains all 100 questions in this format:

```json
{
  "subject_slug": "shrm-scp",
  "domain": "Acuity",
  "question_text": "...",
  "options": ["Option A", "Option B", "Option C", "Option D"],
  "correct_index": 1,
  "explanation": "..."
}
```

---

## 📊 Course Structure Summary

| Domain | Count | Questions | Focus |
|--------|-------|-----------|-------|
| **Acuity** | 25 | 001-025 | Data interpretation, metrics, trend analysis, diagnostic questions |
| **Strategic HR Management** | 25 | 026-050 | Business alignment, capability building, organizational change |
| **HR Expertise** | 25 | 051-075 | HR processes, systems, best practices, professional standards |
| **Consultation & Business Acumen** | 25 | 076-100 | Partnering with business, understanding context, systemic thinking |

---

## 🎯 What Users Will See

Once questions are loaded into Supabase:

1. **Course Card** on the subjects page
   - SHRM-SCP with purple accent
   - Shows: 100 total questions, answered count, accuracy %, pass likelihood
   - Separate from SHRM-CP

2. **Domain Selection**
   - Choose to quiz on individual domains (25q each)
   - Or take all 100 questions randomly

3. **AI-Powered Analysis**
   - Post-session analysis identifies weak domains
   - Pass likelihood calculated across all 4 domains
   - Suggested study areas based on performance

---

## 🔧 Database Schema (Expected)

The `questions` table should have these columns:

```sql
CREATE TABLE questions (
  id TEXT PRIMARY KEY,
  subject_slug TEXT NOT NULL,
  domain TEXT NOT NULL,
  question_text TEXT NOT NULL,
  options JSONB NOT NULL,           -- ["Option A", "Option B", "Option C", "Option D"]
  correct_index INTEGER NOT NULL,   -- 0-3
  explanation TEXT,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

---

## 📝 SQL Insert Example

```sql
INSERT INTO questions (id, subject_slug, domain, question_text, options, correct_index, explanation, active)
VALUES 
('shrm-scp-001', 'shrm-scp', 'Acuity', 
 'An HR leader identifies that several high-performing employees are leaving the organization within 18 months of promotion. What is the BEST first step to address this retention issue?',
 '["Increase compensation for newly promoted employees", "Conduct exit interviews and analyze departure patterns", "Implement a formal mentoring program for all promoted staff", "Create retention bonuses contingent on 2-year tenure"]',
 1,
 'Exit interviews and analysis of departure patterns provide data-driven insights into why employees are leaving, enabling targeted interventions.',
 true),

('shrm-scp-002', 'shrm-scp', 'Acuity',
 '...',
 '...',
 -- ... continue for all 100 questions
);
```

---

## ✨ Key Features of These Questions

✅ **Senior-Level Difficulty** — SHRM-SCP requires strategic, integrative thinking  
✅ **Scenario-Based** — Most questions require application, not just recall  
✅ **Business-Focused** — Emphasis on HR as business partner  
✅ **Detailed Explanations** — Each answer explains why it's correct  
✅ **Balanced Distribution** — 25 questions per domain ensures breadth  
✅ **Real-World Context** — Cases and examples reflect actual HR challenges  

---

## 🎓 Question Types Included

- **Data Interpretation** — Analyze metrics to make decisions (Acuity)
- **Strategic Alignment** — Connect HR actions to business strategy (Strategic HR Management)
- **Process & Standards** — Apply HR best practices and compliance (HR Expertise)
- **Business Consulting** — Provide recommendations to non-HR partners (Consultation & Business Acumen)

---

## 📞 Troubleshooting

**Questions aren't showing up after insertion?**
- Clear browser cache (localStorage) to refresh the question bank
- Check that `active = true` is set for all questions
- Verify `subject_slug = 'shrm-scp'` matches the domain names in index.html

**Domain scores not calculating correctly?**
- Ensure 25 questions exist in each domain
- Verify domain names exactly match:
  - `Acuity`
  - `Strategic HR Management`
  - `HR Expertise`
  - `Consultation & Business Acumen`

**Need to edit a question?**
- Edit directly in Supabase and refresh the app
- Questions are cached for 24 hours locally; clear cache to see changes immediately

---

## 📁 Files Created

| File | Purpose |
|------|---------|
| `shrm-scp-complete-100-questions.json` | Complete question bank ready for insertion |
| `shrm-scp-insert-template.sql` | SQL template for Supabase insertion |
| `SHRM-SCP-SETUP-GUIDE.md` | This setup guide |
| `index.html` (updated) | App now includes SHRM-SCP course definition |

---

## 🚀 Ready to Ship?

Once questions are inserted into Supabase:
1. ✅ Users can select SHRM-SCP from the subjects page
2. ✅ Quiz mode works with 100 questions
3. ✅ Domain breakdown and pass likelihood tracking enabled
4. ✅ AI analysis available for post-session insights

The course is structured and ready. Just need the database population!

---

**Created:** April 28, 2026  
**Questions:** 100 (25 per domain)  
**Status:** Ready for Supabase insertion  
**Questions ID Range:** shrm-scp-001 through shrm-scp-100
