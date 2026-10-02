-- Run this migration once on the existing B12 Supabase database.
alter table public.menu_categories add column if not exists title_ru text;
alter table public.menu_sections add column if not exists title_ru text;
alter table public.menu_items add column if not exists name_ru text;
alter table public.menu_items add column if not exists description_ru text;
alter table public.menu_item_variants add column if not exists label_ru text;
