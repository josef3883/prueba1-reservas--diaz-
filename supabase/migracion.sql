-- Esquema de la app de reservas de sala.
-- Ejecutar en el SQL Editor de Supabase.

create extension if not exists btree_gist;

create table if not exists public.reservas (
  id          uuid primary key default gen_random_uuid(),
  sala_id     text not null,
  usuario_id  uuid not null references auth.users (id),
  inicio      timestamptz not null,
  fin         timestamptz not null,
  creada_en   timestamptz not null default now(),
  constraint fin_despues_de_inicio check (fin > inicio)
);

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conrelid = 'public.reservas'::regclass
      and conname = 'reservas_sin_solapamiento'
  ) then
    alter table public.reservas
      add constraint reservas_sin_solapamiento
      exclude using gist (
        sala_id with =,
        tstzrange(inicio, fin, '[)') with &&
      );
  end if;
end
$$;

alter table public.reservas enable row level security;

create policy "ver reservas"
  on public.reservas for select
  to authenticated
  using (true);

create policy "crear reservas"
  on public.reservas for insert
  to authenticated
  with check (true);
