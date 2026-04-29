-- ============================================================
-- KANPASSIT HARD CAPS MIGRATION
-- Run this in Supabase SQL Editor to add usage tracking
-- ============================================================

-- 1. USAGE TRACKING TABLE (for hard caps)
CREATE TABLE IF NOT EXISTS public.usage_tracking (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  feature text NOT NULL,
  date date NOT NULL,
  month date NOT NULL,
  count integer DEFAULT 1,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, feature, month),
  UNIQUE(user_id, feature, date)
);

ALTER TABLE public.usage_tracking ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own usage"
  ON public.usage_tracking FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE INDEX idx_usage_user_date ON public.usage_tracking(user_id, date);
CREATE INDEX idx_usage_feature ON public.usage_tracking(feature);

-- 2. SKIP TRACKING (marks intentional skips vs correct answers)
CREATE TABLE IF NOT EXISTS public.question_skips (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  subject text NOT NULL,
  question_id integer NOT NULL,
  skipped_at timestamptz DEFAULT now(),
  UNIQUE(user_id, subject, question_id)
);

ALTER TABLE public.question_skips ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own skips"
  ON public.question_skips FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE INDEX idx_skips_user_subject ON public.question_skips(user_id, subject);

-- 3. AI EXPLANATIONS (cache generated explanations to avoid repeated API calls)
CREATE TABLE IF NOT EXISTS public.ai_explanations (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  question_id integer NOT NULL UNIQUE,
  subject text NOT NULL,
  explanation_text text NOT NULL,
  generated_at timestamptz DEFAULT now()
);

CREATE INDEX idx_explanations_subject ON public.ai_explanations(subject);

-- 4. API LOGS (monitor usage and detect abuse patterns)
CREATE TABLE IF NOT EXISTS public.api_logs (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  feature text NOT NULL,
  tier text NOT NULL,
  allowed boolean NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE INDEX idx_api_logs_user ON public.api_logs(user_id);
CREATE INDEX idx_api_logs_feature ON public.api_logs(feature);
CREATE INDEX idx_api_logs_timestamp ON public.api_logs(created_at);

-- ============================================================
-- UPDATE user_accounts TABLE (if not already updated)
-- ============================================================
-- Make sure user_accounts has subscription_tier column
-- (it should already exist from your setup, but this ensures it)
ALTER TABLE public.user_accounts
ADD COLUMN IF NOT EXISTS subscription_tier text DEFAULT 'free';

-- ============================================================
-- DONE
-- ============================================================
-- After running this migration:
-- 1. All tables will be created with RLS policies
-- 2. Hard caps enforcement is ready to code in the app
-- 3. Ready for analytics dashboard
