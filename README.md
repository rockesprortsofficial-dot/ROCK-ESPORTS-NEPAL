# ROCK ESPORTS — Private Admin Website

This package is designed for GitHub Pages + Supabase.

## What it does
- Public professional ROCK ESPORTS website
- Private `/admin.html` login
- Only users added to `admins` can edit
- Website text, banner URL, management, members and social links
- Changes are saved online in Supabase, so everyone sees the same updated data

## Setup
1. Create a free Supabase project.
2. Open SQL Editor and run `supabase.sql`.
3. In Authentication > Users, create your private admin account.
4. Copy the user's UUID and run the commented INSERT in `supabase.sql`.
5. Rename `config.example.js` to `config.js` and put your Supabase Project URL and public anon key there.
6. Upload all files to a GitHub repository and enable GitHub Pages.
7. Open `https://YOUR-GITHUB-PAGES-URL/admin.html` to edit.

Do NOT put a Supabase service_role key in these files. Only use the public anon key; RLS protects editing.
