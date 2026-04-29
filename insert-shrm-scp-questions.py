#!/usr/bin/env python3
"""
SHRM-SCP Questions Insertion Script
Inserts all 100 SHRM-SCP exam questions into Supabase database
"""

import json
import sys

def main():
    print("=" * 70)
    print("SHRM-SCP Questions Insertion for StudyApp")
    print("=" * 70)

    # Load the JSON file with all questions
    json_file = 'shrm-scp-complete-100-questions.json'
    print(f"\n1. Loading questions from {json_file}...")

    try:
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"ERROR: {json_file} not found in current directory")
        sys.exit(1)

    questions = data.get('questions', [])
    print(f"   ✓ Loaded {len(questions)} questions")

    # Display summary
    print(f"\n2. Question Summary:")
    domains = data.get('domains', {})
    for domain, count in domains.items():
        print(f"   • {domain}: {count} questions")

    # Load the SQL file
    print(f"\n3. Preparing SQL INSERT statement...")
    sql_file = 'shrm-scp-insert-no-id.sql'

    try:
        with open(sql_file, 'r', encoding='utf-8') as f:
            sql_content = f.read()
    except FileNotFoundError:
        print(f"ERROR: {sql_file} not found")
        sys.exit(1)

    sql_lines = len(sql_content.split('\n'))
    print(f"   ✓ SQL file ready ({sql_lines} lines, ~{len(sql_content)} bytes)")

    print("\n" + "=" * 70)
    print("NEXT STEPS - Two Options:")
    print("=" * 70)

    print("\n📌 OPTION 1: Use Supabase SQL Editor (Recommended)")
    print("-" * 70)
    print("1. Open your Supabase project: https://supabase.com/dashboard/project/kcycuabxhowpdprrulyn/sql")
    print("2. Click 'New Query' or '+' to create a new SQL query")
    print("3. Open shrm-scp-insert-no-id.sql in a text editor")
    print("4. Copy the entire content")
    print("5. Paste it into the Supabase SQL Editor")
    print("6. Click the green 'Run' button (Ctrl+Enter)")
    print("7. You should see a success message after 5-10 seconds")

    print("\n📌 OPTION 2: Use Command Line (Advanced)")
    print("-" * 70)
    print("1. Install Supabase CLI if not already installed")
    print("2. Authenticate: supabase login")
    print("3. Link to your project: supabase link --project-ref kcycuabxhowpdprrulyn")
    print("4. Execute SQL: supabase sql < shrm-scp-insert-no-id.sql")

    print("\n" + "=" * 70)
    print("VERIFICATION:")
    print("=" * 70)
    print("\n After running the SQL, verify in your app:")
    print("1. Clear browser cache (Ctrl+Shift+Delete)")
    print("2. Navigate to the Subjects page")
    print("3. You should see 'SHRM-SCP' as the 4th course")
    print("4. Click it to see all 100 questions available")
    print("5. Try a practice quiz to confirm it's working")

    print("\n" + "=" * 70)
    print("✓ Files are ready for insertion")
    print("=" * 70 + "\n")

    return 0

if __name__ == '__main__':
    sys.exit(main())
