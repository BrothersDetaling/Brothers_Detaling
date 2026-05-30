create extension if not exists pgcrypto;

create table if not exists public.service_categories (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name_html text not null,
  display_order integer not null default 0,
  is_active boolean not null default true,
  css_classes text[] not null default '{}'::text[],
  created_at timestamptz not null default now(),
  constraint service_categories_display_order_check check (display_order >= 0)
);

create table if not exists public.services (
  id uuid primary key default gen_random_uuid(),
  category_id uuid not null references public.service_categories(id) on delete restrict,
  slug text not null unique,
  name_html text not null,
  description_html text not null default '',
  price_html text not null,
  price_amount numeric(10,2) not null default 0,
  duration_minutes integer not null default 0,
  display_order integer not null default 0,
  is_active boolean not null default true,
  css_classes text[] not null default '{}'::text[],
  created_at timestamptz not null default now(),
  constraint services_price_amount_check check (price_amount >= 0),
  constraint services_duration_minutes_check check (duration_minutes >= 0),
  constraint services_display_order_check check (display_order >= 0)
);

create table if not exists public.packages (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name_html text not null,
  description_html text not null default '',
  display_order integer not null default 0,
  is_active boolean not null default true,
  css_classes text[] not null default '{}'::text[],
  total_price_amount numeric(10,2) not null default 0,
  total_duration_minutes integer not null default 0,
  created_at timestamptz not null default now(),
  constraint packages_display_order_check check (display_order >= 0),
  constraint packages_total_price_amount_check check (total_price_amount >= 0),
  constraint packages_total_duration_minutes_check check (total_duration_minutes >= 0)
);

create table if not exists public.package_items (
  package_id uuid not null references public.packages(id) on delete cascade,
  service_id uuid not null references public.services(id) on delete cascade,
  item_order integer not null default 0,
  created_at timestamptz not null default now(),
  primary key (package_id, service_id),
  constraint package_items_item_order_check check (item_order >= 0),
  constraint package_items_unique_order unique (package_id, item_order)
);

create index if not exists idx_service_categories_display_order
  on public.service_categories (display_order, name_html);

create index if not exists idx_services_category_display_order
  on public.services (category_id, display_order, name_html);

create index if not exists idx_packages_display_order
  on public.packages (display_order, name_html);

create index if not exists idx_package_items_package_order
  on public.package_items (package_id, item_order);

create index if not exists idx_package_items_service_id
  on public.package_items (service_id);

create or replace function public.refresh_package_totals(p_package_id uuid)
returns void
language plpgsql
as $$
begin
  update public.packages p
  set total_price_amount = coalesce((
        select sum(s.price_amount)
        from public.package_items pi
        join public.services s on s.id = pi.service_id
        where pi.package_id = p_package_id
      ), 0),
      total_duration_minutes = coalesce((
        select sum(coalesce(s.duration_minutes, 0))
        from public.package_items pi
        join public.services s on s.id = pi.service_id
        where pi.package_id = p_package_id
      ), 0)
  where p.id = p_package_id;
end;
$$;

create or replace function public.tg_refresh_package_totals_from_items()
returns trigger
language plpgsql
as $$
declare
  target_package_id uuid;
begin
  if tg_op = 'DELETE' then
    target_package_id := old.package_id;
  else
    target_package_id := new.package_id;
  end if;

  perform public.refresh_package_totals(target_package_id);

  if tg_op = 'UPDATE' and old.package_id is distinct from new.package_id then
    perform public.refresh_package_totals(old.package_id);
  end if;

  return coalesce(new, old);
end;
$$;

create or replace function public.tg_refresh_package_totals_from_service()
returns trigger
language plpgsql
as $$
declare
  affected_package record;
  target_service_id uuid;
begin
  if tg_op = 'DELETE' then
    target_service_id := old.id;
  else
    target_service_id := new.id;
  end if;

  for affected_package in
    select distinct pi.package_id
    from public.package_items pi
    where pi.service_id = target_service_id
  loop
    perform public.refresh_package_totals(affected_package.package_id);
  end loop;

  return coalesce(new, old);
end;
$$;

drop trigger if exists trg_refresh_package_totals_from_items on public.package_items;
create trigger trg_refresh_package_totals_from_items
after insert or update or delete on public.package_items
for each row execute function public.tg_refresh_package_totals_from_items();

drop trigger if exists trg_refresh_package_totals_from_service on public.services;
create trigger trg_refresh_package_totals_from_service
after update of price_amount, duration_minutes on public.services
for each row execute function public.tg_refresh_package_totals_from_service();

alter table public.service_categories enable row level security;
alter table public.services enable row level security;
alter table public.packages enable row level security;
alter table public.package_items enable row level security;

drop policy if exists "service_categories_select_all" on public.service_categories;
create policy "service_categories_select_all"
on public.service_categories
for select
to anon, authenticated
using (true);

drop policy if exists "services_select_all" on public.services;
create policy "services_select_all"
on public.services
for select
to anon, authenticated
using (true);

drop policy if exists "packages_select_all" on public.packages;
create policy "packages_select_all"
on public.packages
for select
to anon, authenticated
using (true);

drop policy if exists "package_items_select_all" on public.package_items;
create policy "package_items_select_all"
on public.package_items
for select
to anon, authenticated
using (true);
