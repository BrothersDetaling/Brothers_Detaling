-- Migration for size-based pricing and duration support.
-- Keeps existing columns intact for backward compatibility.

begin;

alter table public.services
  add column if not exists price_amount_small numeric(10,2) not null default 0,
  add column if not exists price_amount_medium numeric(10,2) not null default 0,
  add column if not exists price_amount_large numeric(10,2) not null default 0,
  add column if not exists duration_minutes_small integer not null default 0,
  add column if not exists duration_minutes_medium integer not null default 0,
  add column if not exists duration_minutes_large integer not null default 0;

alter table public.packages
  add column if not exists total_price_amount_small numeric(10,2) not null default 0,
  add column if not exists total_price_amount_medium numeric(10,2) not null default 0,
  add column if not exists total_price_amount_large numeric(10,2) not null default 0;

comment on column public.services.price_amount_small is 'Service price for small cars';
comment on column public.services.price_amount_medium is 'Service price for medium cars';
comment on column public.services.price_amount_large is 'Service price for large cars';
comment on column public.services.duration_minutes_small is 'Service duration for small cars';
comment on column public.services.duration_minutes_medium is 'Service duration for medium cars';
comment on column public.services.duration_minutes_large is 'Service duration for large cars';

comment on column public.packages.total_price_amount_small is 'Package total price for small cars';
comment on column public.packages.total_price_amount_medium is 'Package total price for medium cars';
comment on column public.packages.total_price_amount_large is 'Package total price for large cars';

-- Optional compatibility backfill:
-- Copy the existing generic values into the medium columns so current records
-- can act as the default baseline for medium-sized cars.
update public.services
set
  price_amount_medium = price_amount,
  duration_minutes_medium = duration_minutes;

update public.packages
set
  total_price_amount_medium = total_price_amount;

commit;
