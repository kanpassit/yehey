-- Create user_accounts table for subscription & billing metadata
CREATE TABLE IF NOT EXISTS public.user_accounts (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id uuid UNIQUE NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,

  -- Subscription fields
  subscription_tier text DEFAULT 'free' NOT NULL CHECK (subscription_tier IN ('free', 'monthly', 'annual')),
  subscription_status text DEFAULT 'active' NOT NULL CHECK (subscription_status IN ('active', 'canceled', 'paused')),
  subscription_start_date timestamptz DEFAULT now() NOT NULL,
  subscription_renews_at timestamptz,

  -- Billing fields
  billing_email text,
  stripe_customer_id text UNIQUE,
  stripe_subscription_id text UNIQUE,

  -- Profile fields (optional)
  display_name text,
  avatar_url text,

  -- Audit fields
  created_at timestamptz DEFAULT now() NOT NULL,
  updated_at timestamptz DEFAULT now() NOT NULL
);

-- Enable RLS
ALTER TABLE public.user_accounts ENABLE ROW LEVEL SECURITY;

-- RLS policy: users can only view/edit their own account
CREATE POLICY "Users manage own account"
  ON public.user_accounts FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Create index on user_id for fast lookups
CREATE INDEX idx_user_accounts_user_id ON public.user_accounts(user_id);
CREATE INDEX idx_user_accounts_stripe_customer ON public.user_accounts(stripe_customer_id);

-- Optional: Create a trigger to auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_user_accounts_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_accounts_update_timestamp
  BEFORE UPDATE ON public.user_accounts
  FOR EACH ROW
  EXECUTE FUNCTION update_user_accounts_timestamp();
