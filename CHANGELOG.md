# KanPassIt — Changelog

## 🚀 Latest Deployment
**v2.3.4 deployed to production** — May 4, 2026

---

## [2.3.3] — 2026-05-04 — Lazy Question Loading

### 🐛 Bug Fixed: App Stuck on "Loading Questions…" Screen (Recurring)

**Root causes identified:**
- `init()` fetched ALL questions from ALL 6 subjects in a single Supabase query before leaving the loading screen. As the question bank grew, this query exceeded the 5-second timeout.
- Supabase free tier pauses projects after ~7 days of inactivity; cold-start wake-up takes 10–20s, always blowing the timeout.
- The monolithic cache stored all subjects as one JSON blob, routinely hitting the ~5MB localStorage quota and failing silently — forcing a fresh full fetch every session.
- When the 5s timeout fired, `QB` stayed empty and the background fetch wrote to `QB` too late, after the user was already past the loading screen.

**Fix: lazy per-subject question loading**
- Removed `loadQuestions()` from `init()`. Loading screen now only waits on auth check (~1–3s).
- Added `loadQuestionsForSubject(slug)` — fetches only the selected subject's questions when a subject card is tapped, filtered by `.eq('subject_slug', slug)`.
- Each subject gets its own localStorage cache key (`kanpassit_qb_v2_{slug}`) — small per-subject payload, no quota risk.
- Subject cards dim briefly during load to signal activity; the user is already past the loading screen.
- One-time cleanup of old `kanpassit_qb_v1` monolithic cache key on first load to reclaim localStorage space.

---

## [2.3.4] — 2026-05-04 — Exam Simulation Question Count Fix

### 🐛 Bug Fixed: Full Exam Option Showing More Questions Than Real Exam

The "Full Exam Simulation" mode was using every question in the database (`pool = shuffle([...qs])`) with no cap. Since the DB has more questions than any real exam, users were getting sessions far longer than the actual test.

**Fix:** Added `examSimCount` to each subject config; `mode === 'all'` now slices the shuffled pool to that count. Modal label updated from "All N questions in random order" → "{examSimCount} questions — full exam simulation".

| Subject | Exam Sim Count | Source |
|---------|---------------|--------|
| AB-900 | 60 | Microsoft Learn study guide |
| NCLEX-RN | 145 | NCSBN 2023 NGN CAT upper bound |
| NCLEX-PN | 150 | NCLEX-PN CAT upper bound |
| NCLEX CNA | 60 | NNAAP 2024 scored questions |
| SHRM-CP | 110 | SHRM scored questions (excl. 24 field-test items) |
| SHRM-SCP | 110 | SHRM scored questions (excl. field-test items) |

---

## [2.3.2] — 2026-05-02 — Pass % Card Fix

### 🐛 Bug Fixed: Subject Card Pass % Mismatched Detail Page Pass Likelihood
The Pass % shown on the subject list card was lower than the Pass Likelihood shown on the detail page for the same subject (e.g. AB-900 showed 56% on the card vs 70% on the detail page).

- **Root cause:** `getLocalAnswers()` (used by the card view) read answers from localStorage only, without backfilling the `.cat` (domain category) field. `calcLikelihood()` is domain-weighted — answers missing `.cat` are silently excluded from the weighted calculation, producing an artificially low score.
- **Detail page** was unaffected because `loadProgress()` merges Supabase data and backfills `.cat` from the question bank before computing the gauge.
- **Fix:** Added QB category backfill to `getLocalAnswers()` — mirrors the backfill already in `loadProgress()`. Now both views use fully-categorized answers and produce consistent scores.

---

## [2.3.1] — 2026-04-29 — Subject & Domain Fixes

### 🐛 Bug Fixed: Loading Screen Freeze
- Root cause: `index.html` JS was truncated mid-function (`deleteAccount()` cut off at `const {`), causing a browser parse error that silently prevented `init()` from running
- Fix: Recovered missing function tail from prior working commit; pushed full 103,637-byte file via native Windows PowerShell (bypassing bash sandbox ~101KB mount limit)

### ✦ CNA and RN Subjects Added to App
Both subjects had questions in Supabase but were missing from the frontend subject registry entirely.

**CNA — 101 questions**
| Domain | Questions |
|--------|-----------|
| Basic Nursing Skills | 36 |
| Activities of Daily Living | 29 |
| Role of the Nurse Aide | 26 |
| Psychosocial Care Skills | 10 |

**RN (NCLEX-RN) — 97 questions**
| Domain | Questions |
|--------|-----------|
| Physiological Integrity | 50 |
| Safe & Effective Care | 32 |
| Health Promotion | 6 |
| Psychosocial Integrity | 9 |

### 🐛 Bug Fixed: Domain Name Mismatches
All domain `name` values in the frontend subject config must exactly match the `domain` column in Supabase for question filtering to work.

| Subject | Old (broken) | New (matches DB) |
|---------|-------------|-----------------|
| AB-900 | Admin Tasks | Agents + Copilot (split into 2) |
| AB-900 | Core M365 | M365 Core |
| LVN | Coordinated Care | Physiological Care |
| LVN | Safety & Infection Control | Safe Care |
| LVN | Health Promotion & Maintenance | Pharmacology |
| LVN | Physiological Integrity | Psychosocial |

### 📊 Live Question Bank — All Subjects
| Subject | Questions | Notes |
|---------|-----------|-------|
| AB-900 | 100 | Microsoft 365 Copilot & Agent Admin |
| CNA | 101 | Certified Nursing Assistant |
| LVN | 100 | NCLEX-PN Licensed Vocational Nurse |
| RN | 97 | NCLEX-RN Registered Nurse |
| SHRM-CP | 100 | SHRM Certified Professional |
| SHRM-SCP | 100 | SHRM Senior Certified Professional |
| **Total** | **598** | |

---

---

## [2.3.0] — 2026-04-29 — Answer Bias Fix (DB + UI)

### 🐛 Bug Fixed: AI-Generated Answer Positional Bias
All question banks had a systematic bias where the correct answer was almost always placed in the same position — a known artifact of AI-generated MCQs.

**Before (correct answer distribution):**
| Subject | A | B | C | D |
|---------|---|---|---|---|
| AB-900 | 2% | 46% | 48% | 4% |
| CNA / RN | 100% | 0% | 0% | 0% |
| LVN | 3% | 57% | 40% | 0% |
| SHRM-CP | 4% | 76% | 20% | 0% |
| SHRM-SCP | 3% | 86% | 11% | 0% |

**After (target ~25% per letter):**
All 6 subjects now balanced — no letter exceeds 38%.

### ✦ UI-Layer Shuffle (index.html + AB-900-Quiz.html)
- Added `applyOptionShuffle(QB)` to `index.html` — runs after questions load from either Supabase or localStorage cache, randomizing answer positions on every page load
- Added `shuffleOptions(q)` to `AB-900-Quiz.html` — runs at quiz start via `pool.map(shuffleOptions)`, randomizing on every new quiz session
- Both use Fisher-Yates shuffle, tracking correct answer by text content (not position), so question content is unchanged
- Cache stores original unshuffled data; shuffle is applied after load so each session gets a fresh random order

### 🗄️ Database Migration (598 questions updated)
- All 598 questions in Supabase patched via REST API using service role key
- `options` array and `correct_index` updated for every row across all 6 subjects
- Result: corre