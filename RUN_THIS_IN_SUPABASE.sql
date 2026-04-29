-- ============================================================
-- KANPASSIT HARD CAPS MIGRATION
-- Copy everything below and paste into Supabase SQL Editor
-- Then click Run button (bottom right)
-- ============================================================

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

CREATE TABLE IF NOT EXISTS public.ai_explanations (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  question_id integer NOT NULL UNIQUE,
  subject text NOT NULL,
  explanation_text text NOT NULL,
  generated_at timestamptz DEFAULT now()
);

CREATE INDEX idx_explanations_subject ON public.ai_explanations(subject);

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

ALTER TABLE public.user_accounts
ADD COLUMN IF NOT EXISTS subscription_tier text DEFAULT 'free';
