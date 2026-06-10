$ mkdir -p /home/user/FYP/database && cat > /home/user/FYP/database/schema.sql << 'EOF'
-- Profiles table
CREATE TABLE profiles (
  id uuid REFERENCES auth.users(id) PRIMARY KEY,
  full_name text,
  email text,
  gender text,
  user_type text,
  status text DEFAULT 'active',
  approved boolean DEFAULT true
);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Allow insert on profiles for new users"
ON profiles FOR INSERT
WITH CHECK (true);

CREATE POLICY "Allow users to read own profile"
ON profiles FOR SELECT
USING (auth.uid() = id);

-- Auto-create profile on user signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, email, user_type)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'full_name',
    NEW.email,
    NEW.raw_user_meta_data->>'role'
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();
EOF

(Bash completed with no output)