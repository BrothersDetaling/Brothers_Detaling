create extension if not exists pgcrypto;

create table if not exists public.bookings (
  id uuid primary key default gen_random_uuid(),
  first_name text not null,
  last_name text not null,
  phone text not null,
  email text not null,
  car_model text not null,
  car_size text not null,
  booking_date date not null,
  booking_time time without time zone not null,
  selected_items jsonb not null default '[]'::jsonb,
  total_amount numeric(10,2) not null default 0,
  total_duration_minutes integer not null default 0,
  is_paid boolean not null default false,
  payment_provider text,
  payment_reference text,
  paid_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint bookings_car_size_check check (car_size in ('small', 'medium', 'large')),
  constraint bookings_total_amount_check check (total_amount >= 0),
  constraint bookings_total_duration_minutes_check check (total_duration_minutes >= 0)
);

create index if not exists idx_bookings_created_at
  on public.bookings (created_at desc);

create index if not exists idx_bookings_booking_date
  on public.bookings (booking_date, booking_time);

create index if not exists idx_bookings_is_paid
  on public.bookings (is_paid, created_at desc);

create index if not exists idx_bookings_email
  on public.bookings (email);

create or replace function public.set_bookings_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists trg_set_bookings_updated_at on public.bookings;
create trigger trg_set_bookings_updated_at
before update on public.bookings
for each row execute function public.set_bookings_updated_at();

create or replace function public.mark_booking_paid(p_booking_id uuid)
returns public.bookings
language plpgsql
security definer
set search_path = public
as $$
declare
  updated_booking public.bookings;
begin
  update public.bookings
  set is_paid = true,
      paid_at = coalesce(paid_at, now()),
      updated_at = now()
  where id = p_booking_id
  returning * into updated_booking;

  return updated_booking;
end;
$$;

grant execute on function public.mark_booking_paid(uuid) to anon, authenticated;

alter table public.bookings enable row level security;

grant select, insert, update on public.bookings to anon, authenticated;

drop policy if exists "bookings_select_authenticated" on public.bookings;
create policy "bookings_select_authenticated"
on public.bookings
for select
to authenticated
using (true);

drop policy if exists "bookings_insert_anon_authenticated" on public.bookings;
create policy "bookings_insert_anon_authenticated"
on public.bookings
for insert
to anon, authenticated
with check (true);

drop policy if exists "bookings_update_authenticated" on public.bookings;
create policy "bookings_update_authenticated"
on public.bookings
for update
to authenticated
using (true)
with check (true);
