# KanPassIt

**AI-powered exam prep for certification candidates.**
Live at [www.kanpassit.com](https://www.kanpassit.com)

Current version: **v2.3.1** | Stack: Vercel · Supabase · Vanilla JS

---

## Subjects

| Subject | Questions | Exam |
|---------|-----------|------|
| AB-900 | 100 | Microsoft 365 Copilot & Agent Administration |
| CNA | 101 | Certified Nursing Assistant State Competency |
| LVN | 100 | NCLEX-PN Licensed Vocational Nurse |
| RN | 97 | NCLEX-RN Registered Nurse |
| SHRM-CP | 100 | SHRM Certified Professional |
| SHRM-SCP | 100 | SHRM Senior Certified Professional |
| **Total** | **598** | |

---

## Features

- Multiple-choice quiz engine with instant feedback and wrong answer log
- Answer options shuffled on every load (eliminates AI positional bias)
- Skip button — returns skipped questions at end of session
- Pass Likelihood gauge (unlocks after sufficient questions answered)
- AI Study Analysis — generates personalized study plan via Claude API
- AI Question Generation — generates new practice questions targeting weak domains
- Analytics dashboard — domain-level accuracy + progress tracking
- Guest mode (local-only) and authenticated mode (cross-device sync via Supabase)
- Tier-based access: Free · Single Subject · All Access

---

## Tech Stack

| Layer | Tech |
|-------|------|
| Frontend | Single-file `index.html` (Vanilla JS, ~103KB) |
| Auth + DB | Supabase (PostgreSQL + Row-Level Security) |
| API | Vercel serverless functions (`/api/analyze.js`, `/api/generate.js`) |
| AI | Claude claude-sonnet-4-6 via Anthropic API |
| Hosting | Vercel (auto-deploy from GitHub `main`) |
| Payments | Stripe (schema ready, not wired) |

---

## Repo Structure

```
index.html                   Main app
AB-900-Quiz.html             Standalone AB-900 quiz
api/
  analyze.js                 AI study plan endpoint
  generate.js                AI question generation endpoint
kanpassit_migration.sql      Master seed: ab900, lvn, shrm (300q)
questions_cna_rn_seed.sql    CNA/RN seed batch 1
questions_cna_rn_batch2.sql  CNA/RN seed batch 2
shrm-scp-final.sql           SHRM-SCP seed (100q)
migrations_hard_caps.sql     usage_tracking, api_logs, question_skips tables
CHANGELOG.md                 Full version history
IMPLEMENTATION_SUMMARY.md   Technical deep-dives per version
```

---

## Version History

| Version | Date | Summary |
|---------|------|---------|
| v2.3.1 | 2026-04-29 | Add CNA+RN subjects; fix LVN + AB-900 domain names; fix loading screen freeze |
| v2.3.0 | 2026-04-29 | Fix answer positional bias — UI shuffle + DB migration across all 598 questions |
| v2.2.0 | 2026-04-29 | AI question generation (Claude API + Vercel endpoint) |
| v2.1.0 | 2026-04-29 | Hard usage caps, skip button, analytics dashboard |
| v2.0.x | 2026-04-28 | User accounts, settings page, exam fidelity, 6 subjects |
| v1.x | 2026-04-28 | Initial launch — AB-900, LVN, SHRM-CP, core quiz engine |

---

## Roadmap

- [ ] Stripe payment integration (schema already in DB)
- [ ] Per-question AI explanations (DB table ready, needs UI)
- [ ] AdSense / AdMob (pending hosted domain verification)
- [ ] Mobile app via Capacitor
- [ ] NCLEX-RN expanded question bank (currently 97q, exam uses 75–145)
