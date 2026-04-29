# KanPassIt — Implementation Summary
**Last Updated: April 29, 2026 | Current Version: v2.3.1 | Status: LIVE ✅**

---

## v2.3.1 — Subject & Domain Fixes (April 29, 2026)

### Loading Screen Freeze — Root Cause & Fix
The app was stuck on "Loading questions…" on every load. Root cause: `index.html` was being truncated at ~101KB by the bash sandbox's Windows mount limit. The file ended mid-function inside `deleteAccount()` with no closing `</script>` or `</html>`. The browser hit a JS parse error, `init()` never ran, and the page stayed frozen on the loading view.

Fix: Recovered the missing function tail from a prior working GitHub commit, appended it to restore the complete file, then deployed via native Windows PowerShell (which reads the full Windows filesystem without the mount limit).

### CNA and RN Subjects Added
Both had full question banks in Supabase (`cna`: 101 questions, `rn`: 97 questions) but were missing from the frontend `SUBJECTS` object. Added complete configs including domain names, weights, icons, exam info, and aiContext strings.

### Domain Name Alignment
Domain `name` values in the frontend `SUBJECTS[slug].domains` array must exactly match the `domain` column in Supabase — they're used as query filters. Six mismatches were found and fixed:

| Subject | Fixed |
|---------|-------|
| AB-900 | `Admin Tasks` → split into `Agents` + `Copilot`; `Core M365` → `M365 Core` |
| LVN | All 4 domains renamed to match DB: `Safe Care`, `Physiological Care`, `Pharmacology`, `Psychosocial` |

### Live Question Bank
| Subject | Questions | Domains |
|---------|-----------|---------|
| AB-900 | 100 | Data & Governance (37) · M365 Core (33) · Agents (15) · Copilot (15) |
| CNA | 101 | Basic Nursing Skills (36) · Activities of Daily Living (29) · Role of the Nurse Aide (26) · Psychosocial Care Skills (10) |
| LVN | 100 | Physiological Care (45) · Safe Care (30) · Pharmacology (15) · Psychosocial (10) |
| RN | 97 | Physiological Integrity (50) · Safe & Effective Care (32) · Psychosocial Integrity (9) · Health Promotion (6) |
| SHRM-CP | 100 | Employment Law (38) · People & Talent (32) · HR Strategy (18) · HR Operations (12) |
| SHRM-SCP | 100 | Acuity (25) · Consultation & Business Acumen (25) · HR Expertise (25) · Strategic HR Management (25) |
| **Total** | **598** | |

### Architecture Note — Push Strategy
The bash sandbox has a ~101KB read limit on files in the Windows filesystem mount. Any file larger than this **must be pushed via native Windows PowerShell** using `git push` or the GitHub Contents API with `[System.IO.File]::ReadAllBytes()`. Never use `subprocess.run(['cat', ...])` or Python `open()` to read files that may exceed this limit — both will return truncated content without error.

---

## v2.3.0 — Answer Bias Fix (April 29, 2026)

### Problem
All AI-generated question banks had severe positional bias — the correct answer was placed in the same letter position almost every time (e.g. CNA/RN: 100% A, SHRM-SCP: 86% B). This allowed users to pattern-match on letter position rather than learning the material.

### Fix — Two Layers

#### Layer 1: UI Shuffle (index.html + AB-900-Quiz.html)
Added answer-option shuffle at render time. Applied every page load / quiz start.

**`index.html`** — added `_shuffleArr()` and `applyOptionShuffle(QB)`:
- Called in `loadQuestions()` after loading from both Supabase and localStorage cache
- Cache stores original unshuffled DB data; shuffle is applied after cache read so each session gets a different random order

**`AB-900-Quiz.html`** — added `shuffleOptions(q)`:
- Called in `startQuiz()` via `pool = pool.map(shuffleOptions)`
- Runs on every new quiz session

Both use Fisher-Yates shuffle. Correct answer is tracked by option text content, not index position — so no answer correctness is ever broken.

#### Layer 2: Database Migration (598 questions)
- Fetched all 598 questions from Supabase via REST API
- Shuffled `options` array + updated `correct_index` for every row
- Used service role key (bypasses RLS) for admin-level update
- Ran in 3 batches of ~200 to stay within network timeouts

**Final DB distribution (all subjects):**
| Subject | A% | B% | C% | D% |
|---------|----|----|----|----|
| ab900 | 28 | 26 | 24 | 22 |
| cna | 16 | 22 | 33 | 26 |
| lvn | 19 | 28 | 38 | 15 |
| rn | 28 | 26 | 15 | 28 |
| shrm | 31 | 28 | 16 | 25 |
| shrm-scp | 25 | 21 | 29 | 25 |

#### Seed Files Rewritten
All source SQL seed files were rewritten with shuffled options so future re-seeds don't reintroduce bias:
- `kanpassit_migration.sql`
- `questions_cna_rn_seed.sql`
- `questions_cna_rn_batch2.sql`
- `shrm-scp-final.sql`

### Architecture Note
The UI shuffle acts as a permanent safety net. Even if new questions are added with AI-generated positional bias, the shuffle ensures users always see randomized answer positions. The DB fix is the clean long-term state.

---

## v2.2.0 — AI Question Generation (April 29, 2026)

### What Was Added

#### `/api/generate.js` (New Vercel Endpoint)
- Accepts `{ subjectName, aiContext, domains, weakDomains, count }` in POST body
- Calls Claude (claude-sonnet-4-6) with a structured prompt to generate exam-realistic MCQs
- Returns validated JSON array: `[{ id, q, opts, correct, cat }]`
- IDs prefixed with `ai_` to distinguish from seeded questions
- Validates each question (must have q, opts array, numeric correct index)
- Max 3000 tokens, handles JSON extraction from response

#### `generateQuestions()` (Frontend)
- Checks quota via `checkQuotaQGeneration()` before any API call
- Identifies weak domains automatically (accuracy < 70% with at least 1 answered)
- Tier-based count: Single = 4 questions, All Access = 10 questions
- Logs all attempts (allowed + blocked) to `api_logs`
- Increments usage counter on success via `incrementUsage()`
- Shows inline result with "▶ Practice These Now" button
- Reveals "🤖 AI-Generated Questions" option in Practice modal

#### UI Changes
- **Analysis page**: "✦ Generate AI Practice Questions" button (blue-tinted, below Analyze button)
- **Practice modal**: "🤖 AI-Generated Questions" mode (hidden until questions are generated)
- **`startQuiz('ai')` mode**: Uses `aiGeneratedQuestions` array as question pool

#### Variables
- `let aiGeneratedQuestions = []` — stores current session's generated questions

---

## v2.1.0 — Hard Caps & Analytics (April 29, 2026)

### Database Tables Created
Run `migrations_hard_caps.sql` (or `RUN_THIS_IN_SUPABASE.sql`) in Supabase SQL Editor:

| Table | Purpose | Key Fields |
|-------|---------|-----------|
| `usage_tracking` | Tracks API usage per user/feature/period | user_id, feature, date, month, count |
| `question_skips` | Tracks intentional skips | user_id, subject, question_id |
| `ai_explanations` | Cached AI explanations (future) | question_id, explanation_text |
| `api_logs` | Audit trail for all API attempts | user_id, feature, tier, allowed |

All tables have RLS — users can only access their own rows.

### Functions Added

| Function | Purpose |
|----------|---------|
| `getUserTier()` | Fetches subscription tier from `user_accounts` |
| `checkQuotaStudyPlan(userId, tier)` | Enforces 1 study plan/month limit |
| `checkQuotaQGeneration(userId, tier)` | Enforces weekly Q generation limits by tier |
| `logUsageAttempt(userId, feature, tier, allowed)` | Logs all API attempts to `api_logs` |
| `incrementUsage(userId, feature)` | Increments usage counter in `usage_tracking` |
| `renderAnalyticsDashboard()` | Renders overall progress + domain breakdown on Analysis page |

### Tier Limits

| Feature | Free | Single Subject | All Access |
|---------|------|----------------|------------|
| AI Study Plan | 1/month | 1/month | 1/month |
| AI Q Generation | ✗ Blocked | 4/week | 10/week |

### Skip Button
- "Skip — return to later" link below answer options during a session
- Moves question to end of queue (revisitable in same session)
- Saves to `question_skips` table via Supabase upsert

### Analytics Dashboard
- Displayed at top of Analysis page on every visit
- Overall Progress card: total answered + accuracy %
- Per-domain cards: correct/attempted, accuracy %, progress bar, completion status

---

## v2.0.x — Settings, Exam Fidelity, Subjects (April 28, 2026)

### User Accounts (`user_accounts` table)
Fields: `user_id`, `subscription_tier` (free/single/all_access), `subscription_status`, `subscription_renews_at`, `stripe_customer_id`, `stripe_subscription_id`, `billing_email`, `display_name`, `avatar_url`, `cre