#!/usr/bin/env python3
"""
Insert SHRM-SCP subject and 100 questions into Supabase
"""

import json
import subprocess
import sys

# Read the SQL file
with open('/sessions/peaceful-keen-albattani/mnt/Flashcards/shrm-scp-insert-no-id.sql', 'r') as f:
    questions_sql = f.read().strip()

# Create the combined SQL
combined_sql = """
-- Step 1: Insert the SHRM-SCP subject
INSERT INTO subjects (slug, name, icon, description, active) VALUES
('shrm-scp', 'SHRM-SCP', '👔', 'SHRM-SCP Senior Certified Professional Exam', true);

-- Step 2: Insert all 100 SHRM-SCP questions
""" + questions_sql

# Write to a temporary file
with open('/tmp/shrm-scp-final.sql', 'w') as f:
    f.write(combined_sql)

print("=" * 70)
print("SHRM-SCP Insert Script - Final")
print("=" * 70)
print("\n✓ Combined SQL prepared")
print(f"  - Subject INSERT: 1 row")
print(f"  - Questions INSERT: 100 rows")
print(f"  - Total file size: {len(combined_sql)} bytes")
print(f"\nFile saved to: /tmp/shrm-scp-final.sql")

print("\n" + "=" * 70)
print("NEXT STEPS:")
print("=" * 70)
print("\n1. Open Supabase SQL Editor")
print("2. Click 'New Query'")
print("3. Copy the contents of /tmp/shrm-scp-final.sql")
print("4. Paste into the SQL Editor")
print("5. Click 'Run' button")
print("\nOr use: cat /tmp/shrm-scp-final.sql | xclip -selection clipboard")

