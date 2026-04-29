# KanPassIt — Changelog

## 🚀 Latest Deployment
**v2.2.0 deployed to production** — April 29, 2026

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

## [2.1.0] — 2026-04-29 — Hard Caps & Analytics Release — ✅ LIVE ON VERCEL

### 🎯 Hard Caps System (Tier-Based Rate Limiting)
- **Study Plan Limits:** 1/month for all tiers (free, single, all_access)
- **Q Generation Limits:** Free (blocked), Single Subject (4/week), All Access (12/week)
- **Functions Added:**
  - `getUserTier()` — Fetches user's subscription tier from Supabase
  - `checkQuotaStudyPlan(userId, tier)` — Enforces monthly study plan limits with next-available date
  - `checkQuotaQGeneration(userId, tier)` — Enforces weekly Q generation limits by tier
  - `logUsageAttempt(userId, feature, tier, allowed)` — Logs all API attempts (allowed/blocked) for audit trail
  - `incrementUsage(userId, feature)` — Increments usage counter with upsert pattern (avoids race conditions)
- **Fail-Graceful Design:** Features continue without hard caps if database unavailable; prevents hard errors
- **Error Handling:** All functions wrapped in try/catch with console.warn() logging for debugging

### 📊 Analytics Dashboard
- **New Analysis Page Display:**
  - **Overall Progress Card:** Shows total questions answered + overall accuracy % side-by-side
  - **Domain Breakdown:** Separate card for each domain with:
    - Correct/attempted count (e.g., "12/24 correct")
    - Progress bar showing % of domain questions completed
    - Accuracy percentage and completion status
  - **Data Source:** Real-time from current session; no extra API calls needed
- **New Functions:**
  - `renderAnalyticsDashboard()` — Generates analytics UI from session data
  - Modified `renderAnalysisPage()` — Now renders analytics dashboard + wrong log
- **Visual Design:** Color-coded progress bars, domain icons, responsive grid layout

### 📍 Skip Button with Database Persistence
- **Skip Button UI:** "Skip — return to later" link below answer options during practice
- **Behavior:** Moves current question to end of queue; revisitable later in same session
- **Database Persistence:** Saves skips to `question_skips` table for future weak-area analysis
- **Distinction:** Skipped questions tracked separately from answered quest