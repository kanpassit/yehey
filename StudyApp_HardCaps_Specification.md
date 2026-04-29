# StudyApp Hard Caps Specification
*Protecting API costs & ensuring predictable infrastructure*

---

## Hard Cap Summary

| Feature | Free | Single Subject | All Access | Cost/Unit |
|---------|------|---|---|---|
| **AI Study Plans** | 1/month | 1/week | 1/week | $0.04–0.06 |
| **AI Q Generation** | ✗ Blocked | 4/week | 12/week | $0.05–0.10 |
| **AI Tutoring Chatbot** | ✗ Blocked | ✗ Blocked | 20 msg/day | $0.001–0.005 |
| **Explanations** | Pre-cached only | Pre-cached only | Pre-cached only | $0 (cached) |

---

## Implementation Approach

**All caps enforced via database checks BEFORE Claude API calls.**

Create a `usage_tracking` table:

```sql
CREATE TABLE usage_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id),
  feature TEXT NOT NULL, -- 'study_plan', 'q_generation', 'chatbot_message'
  date DATE NOT NULL,
  month DATE NOT NULL, -- first day of month for monthly caps
  count INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT now(),
  UNIQUE(user_id, feature, month) -- one row per user/feature/month
);

CREATE INDEX idx_usage_user_date ON usage_tracking(user_id, date);
```

---

## Feature-by-Feature Caps

### 1. AI Study Plans

**Hard Cap Logic:**
```javascript
async function checkStudyPlanQuota(userId, tier) {
  const thisMonth = new Date().toISOString().slice(0, 7) + '-01'; // '2026-04-01'
  
  const { data } = await supabase
    .from('usage_tracking')
    .select('count')
    .eq('user_id', userId)
    .eq('feature', 'study_plan')
    .eq('month', thisMonth)
    .single();

  const used = data?.count || 0;
  const limit = tier === 'free' ? 1 : 1; // both free and paid get 1/week (tracked by date, not month)
  
  if (used >= limit) {
    return { allowed: false, message: `Study plan limit (${limit}/month) reached. Next request available ${nextMonthDate}.` };
  }
  
  return { allowed: true };
}

// On successful API call:
await supabase.from('usage_tracking').upsert({
  user_id: userId,
  feature: 'study_plan',
  month: thisMonth,
  count: used + 1
}, { onConflict: 'user_id,feature,month' });
```

**User Message:**
```
"You've used your study plan for this month. New plan available 2026-05-01."
```

**Why:** Study plans are low-frequency, user-initiated. One per month/week is enough. This prevents request spam.

---

### 2. AI Q Generation

**Hard Cap Logic:**
```javascript
async function checkQGenerationQuota(userId, tier) {
  const thisWeek = getMonday(new Date()).toISOString().slice(0, 10); // ISO date of Monday
  
  const { data } = await supabase
    .from('usage_tracking')
    .select('count')
    .eq('user_id', userId)
    .eq('feature', 'q_generation')
    .gte('date', thisWeek)
    .lt('date', new Date(new Date(thisWeek).getTime() + 7*24*60*60*1000).toISOString().slice(0, 10))
    .single();

  const used = data?.count || 0;
  const limits = { free: 0, single: 4, all_access: 12 };
  const limit = limits[tier];
  
  if (limit === 0) {
    return { allowed: false, message: "Q generation is a premium feature. Upgrade to Single Subject." };
  }
  
  if (used >= limit) {
    const daysUntilReset = 7 - Math.floor((new Date() - new Date(thisWeek)) / (24*60*60*1000));
    return { allowed: false, message: `Weekly Q limit (${limit}) reached. Resets in ${daysUntilReset} days.` };
  }
  
  return { allowed: true };
}

// On successful API call:
await supabase.from('usage_tracking').upsert({
  user_id: userId,
  feature: 'q_generation',
  date: new Date().toISOString().slice(0, 10),
  count: used + 1
}, { onConflict: 'user_id,feature,date' });
```

**User Messages:**
```
Free tier: "Generate new questions is a premium feature. Upgrade to Single Subject ($6.99/mo)."
Single: "4 Q generation requests used this week. Resets Sunday at 12:00 AM PST."
All Access: "12 Q generation requests used this week. Resets Sunday."
```

**Why:** Q generation is your highest-risk feature. Weekly resets prevent hoarding. Different tiers prevent free tier abuse while letting premium users generate freely.

---

### 3. AI Tutoring Chatbot

**Hard Cap Logic:**
```javascript
async function checkChatbotQuota(userId, tier) {
  const today = new Date().toISOString().slice(0, 10);
  
  const { data } = await supabase
    .from('usage_tracking')
    .select('count')
    .eq('user_id', userId)
    .eq('feature', 'chatbot_message')
    .eq('date', today)
    .single();

  const used = data?.count || 0;
  const limits = { free: 0, single: 0, all_access: 20 };
  const limit = limits[tier];
  
  if (limit === 0) {
    return { allowed: false, message: "AI Tutoring is an All Access feature. Upgrade to unlock unlimited help." };
  }
  
  if (used >= limit) {
    return { allowed: false, message: `Daily message limit (${limit}) reached. Your quota resets tomorrow at 12:00 AM PST.` };
  }
  
  return { allowed: true };
}

// On successful API call (after Claude response):
await supabase.from('usage_tracking').upsert({
  user_id: userId,
  feature: 'chatbot_message',
  date: today,
  count: used + 1
}, { onConflict: 'user_id,feature,date' });
```

**User Messages:**
```
Free/Single: "AI Tutoring is an All Access feature ($12.99/mo)."
All Access: "5 of 20 daily messages used. Resets tomorrow at 12:00 AM PST."
All Access (limit hit): "Daily message limit (20) reached. Resets in 8 hours."
```

**Why:** 20 messages/day = ~100 messages/month per user. At $0.001–0.005/msg, that's ~$0.10–0.50/month cost. Totally manageable and prevents chatbot from becoming a free ChatGPT replacement.

---

### 4. Explanations (Pre-Cached)

**No hard cap needed.** All explanations are pre-generated and stored in Supabase. Users can read them unlimited times without API cost.

**Implementation:**
```javascript
// Generate all explanations in batch (once, at off-peak)
async function batchGenerateExplanations() {
  const questions = await getQuestionsWithoutExplanations();
  
  for (const question of questions) {
    const explanation = await generateExplanation(question); // Claude call
    await supabase.from('questions').update({
      ai_explanation: explanation,
      explanation_generated_at: new Date()
    }).eq('id', question.id);
  }
}

// On user view:
const explanation = question.ai_explanation; // zero API cost ✓
```

---

## Database Cleanup & Reset

**Monthly reset for monthly caps (study plans):**
```javascript
// Run nightly via cron job (e.g., Vercel Cron, Supabase Edge Function)
async function dailyUsageReset() {
  const oneMonthAgo = new Date();
  oneMonthAgo.setMonth(oneMonthAgo.getMonth() - 1);
  
  await supabase
    .from('usage_tracking')
    .delete()
    .lt('month', oneMonthAgo.toISOString().slice(0, 7) + '-01');
}
```

**Weekly reset for weekly caps (Q generation, chatbot):**
```javascript
// Also run nightly
async function dailyWeeklyReset() {
  const sevenDaysAgo = new Date(new Date().getTime() - 7*24*60*60*1000).toISOString().slice(0, 10);
  
  await supabase
    .from('usage_tracking')
    .delete()
    .lt('date', sevenDaysAgo)
    .in('feature', ['q_generation', 'chatbot_message']);
}
```

---

## Monitoring & Alerts

**Add telemetry to detect abuse patterns:**

```javascript
// Log every API call attempt (success or blocked)
async function logUsageAttempt(userId, feature, tier, allowed) {
  await supabase.from('api_logs').insert({
    user_id: userId,
    feature,
    tier,
    allowed,
    timestamp: new Date(),
    ip: request.headers['x-forwarded-for'] // detect multi-account abuse
  });
}

// Daily check for outliers
async function detectAbuse() {
  const outliers = await supabase.rpc('detect_usage_outliers', {
    std_devs: 3 // flag users 3+ std devs above mean
  });
  
  if (outliers.length > 0) {
    console.warn('Potential abuse detected:', outliers);
    // Notify you (email/Slack)
  }
}
```

---

## User-Facing Copy

### Study Plan
```
✓ Generate 1 personalized AI study plan per month
→ Analyze your weak domains
→ Get customized drill recommendations
→ Next plan available: 2026-05-01
```

### Q Generation
```
Free:     "Generate new questions [LOCKED] Upgrade to Single Subject"
Single:   "✓ 4 new question sets per week (reset Sundays)"
AllAccess: "✓ 12 new question sets per week (reset Sundays)"
```

### Chatbot
```
Free:     "AI Tutoring [LOCKED] Upgrade to All Access"
Single:   "AI Tutoring [LOCKED] Upgrade to All Access"
AllAccess: "✓ 20 AI messages per day (resets 12:00 AM PST)"
```

---

## Cost Ceiling Per User (Safety Net)

Even with hard caps, implement a **monthly cost ceiling** to catch edge cases:

```javascript
async function enforceMonthlyAPIBudget() {
  const users = await supabase.from('users').select('id, tier, stripe_subscription_id');
  
  for (const user of users) {
    const estimatedCost = await estimateUserAPICost(user.id);
    const budgets = { free: 5, single: 10, all_access: 20 }; // dollars
    
    if (estimatedCost > budgets[user.tier]) {
      console.warn(`User ${user.id} approaching cost ceiling: $${estimatedCost}`);
      // Disable APIs for that user, email them
    }
  }
}
```

---

## Tier Summary & Messaging

### Free Tier
- ✓ 1 study plan/month
- ✗ Q generation (premium only)
- ✗ Chatbot (premium only)
- ✓ Drill existing questions unlimited
- ✓ Pre-cached explanations unlimited

### Single Subject
- ✓ 1 study plan/week
- ✓ 4 Q generation sets/week
- ✗ Chatbot (All Access only)
- ✓ Drill unlimited
- ✓ Explanations unlimited

### All Access
- ✓ 1 study plan/week
- ✓ 12 Q generation sets/week
- ✓ 20 chatbot messages/day
- ✓ Drill unlimited
- ✓ Explanations unlimited

---

## Implementation Checklist

- [ ] Create `usage_tracking` table + indexes
- [ ] Create `api_logs` table for monitoring
- [ ] Implement cap checks before each Claude API call
- [ ] Add rate limiter for rapid-fire requests (cooldown)
- [ ] Set up nightly cleanup cron job
- [ ] Build monitoring dashboard (usage by tier, cost trends)
- [ ] Test cap enforcement (simulate hitting limits)
- [ ] Write user-facing error messages
- [ ] Document for support (what to tell users who hit limits)
- [ ] Set up alerts for abuse patterns
- [ ] Monitor real usage for first month, adjust limits if needed

