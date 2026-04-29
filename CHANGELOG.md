# KanPassIt — Changelog

## 🚀 Latest Deployment
**v2.3.1 deployed to production** — April 29, 2026

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