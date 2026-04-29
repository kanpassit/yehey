# KanPassIt — Changelog

## 🚀 Latest Deployment
**v2.3.0 deployed to production** — April 29, 2026

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
- Result: correct answers distributed ~25% each across A/B/C/D in live DB

### 📄 Seed Files Rewritten
The following seed files were rewritten with shuffled options so future re-seeds produce clean data:
- `kanpassit_migration.sql` (ab900, lvn, shrm — 300 questions)
- `questions_cna_rn_seed.sql` (cna, rn — 61 questions)
- `questions_cna_rn_batch2.sql` (cna, rn — 138 questions)
- `shrm-scp-final.sql` (shrm-scp — 100 questions)

### 💡 Architecture Note
The UI shuffle acts as a permanent safety net — even if new questions are added with AI-generated positional bias, users will not notice it. The DB fix ensures the data is clean at rest.

---

## [2.2.0] — 2026-04-29 — AI Question Generation (Frontend + API)

### ✦ AI Question Generation — Now Fully Wired
- **New API endpoint:** `/api/generate.js` — Vercel serverless function that calls Claude to generate exam-realistic MCQ questions as JSON
- **New frontend function:** `generateQuestions()` — checks quota, identifies weak domains, calls `/api/generate`, stores result
- **New UI button:** "✦ Generate AI Practice Questions" on the Analysis page (below AI Analyze)
- **New practice mode:** "🤖 AI-Generated Questions" in the Practice modal (appears after questions are generated)
- **Tier limits enforced:** Free = blocked, Single = 4 questions/week, All Access = 10 questions/week
- **Weak area targeting:** Automatically focuses generation on domains where accuracy < 70%
- **Usage logged:** All generation attempts (allowed + blocked) written to `api_logs` and `usage_tracking`
- **One-click practice:** "▶ Practice These Now" button appears in-line after generation completes

---

## [2.1.0] — 2026-04-29 — Hard Caps & Analytics Release — ✅ LIVE ON VERCEL
**v2.1.0 deployed to production** — April 29, 2026, 05:30 AM PST
- **Live URL**: https://yehey-8q6rplw6-kanpassits-projects.vercel.app (also www.kanpassit.com)
- **GitHub**: https://github.com/kanpassit/yehey
- **Status**: ✅ Ready for users | All tests passing | Analytics dashboard live

---

## [2.1.0] — 2026-04-29 — Hard Caps & 