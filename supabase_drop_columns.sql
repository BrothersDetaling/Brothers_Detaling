-- Migration that removes legacy generic pricing columns.
-- Drops dependent package-total refresh logic first so the migration is safe.

begin;

drop trigger if exists trg_refresh_package_totals_from_items on public.package_items;
drop trigger if exists trg_refresh_package_totals_from_service on public.services;

drop function if exists public.refresh_package_totals(uuid);
drop function if exists public.tg_refresh_package_totals_from_items();
drop function if exists public.tg_refresh_package_totals_from_service();

alter table public.services
  drop column if exists price_html,
  drop column if exists price_amount,
  drop column if exists duration_minutes;

alter table public.packages
  drop column if exists total_price_amount;

commit;
