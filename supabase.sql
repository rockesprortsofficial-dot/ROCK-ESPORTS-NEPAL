-- 1) Create a Supabase project.
-- 2) In Authentication > Users, create ONE admin user with your private email/password.
-- 3) Copy that user's UUID below and run this SQL.
create table if not exists public.admins (user_id uuid primary key references auth.users(id) on delete cascade);
create table if not exists public.site_content (key text primary key, value jsonb not null, updated_at timestamptz default now());

alter table public.admins enable row level security;
alter table public.site_content enable row level security;

create policy "admins can read own admin row" on public.admins for select to authenticated using (auth.uid()=user_id);
create policy "public can read site content" on public.site_content for select to anon,authenticated using (true);
create policy "admins can insert site content" on public.site_content for insert to authenticated with check (exists(select 1 from public.admins a where a.user_id=auth.uid()));
create policy "admins can update site content" on public.site_content for update to authenticated using (exists(select 1 from public.admins a where a.user_id=auth.uid())) with check (exists(select 1 from public.admins a where a.user_id=auth.uid()));
create policy "admins can delete site content" on public.site_content for delete to authenticated using (exists(select 1 from public.admins a where a.user_id=auth.uid()));

-- Replace YOUR-ADMIN-UUID with the UUID of your admin Auth user:
-- insert into public.admins(user_id) values ('YOUR-ADMIN-UUID');

insert into public.site_content(key,value) values
('site','{"title":"ROCK ESPORTS","home":"Building the future of Nepali esports through discipline, teamwork, skill and leadership.","about":"ROCK ESPORTS is an official esports organization dedicated to developing talented players, building competitive teams and creating a professional esports platform for the next generation.","banner":"","footer":"© ROCK ESPORTS"}'::jsonb),
('management','[]'::jsonb),('members','[]'::jsonb),('social','[]'::jsonb)
on conflict (key) do nothing;
