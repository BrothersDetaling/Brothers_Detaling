-- Dane startowe na podstawie aktualnego main.html.
-- Czas trwania w HTML nie jest podany, więc wartości duration_minutes są orientacyjne.

insert into public.service_categories (slug, name_html, display_order, is_active, css_classes)
values
  ('zewnetrzne', $$Zewnętrzne$$, 1, true, array['podpunkt-header']::text[]),
  ('wewnetrzne', $$Wewnętrzne$$, 2, true, array['podpunkt-header']::text[]),
  ('pranie', $$Pranie$$, 3, true, array['podpunkt-header-pranie']::text[]),
  ('skora', $$Skóra$$, 4, true, array['podpunkt-header-skora']::text[]);

insert into public.services (
  category_id,
  slug,
  name_html,
  description_html,
  price_html,
  price_amount,
  duration_minutes,
  display_order,
  is_active,
  css_classes
)
values
  (
    (select id from public.service_categories where slug = 'zewnetrzne'),
    'mycie-zewnetrzne',
    $$Mycie Zewnętrzne$$,
    $$Dokładne usuwanie zabrudzeń po owadach oraz ręczne mycie aktywną pianą, wraz z czyszczeniem szyb, dla pełnego odświeżenia wyglądu auta.$$,
    $$od 105 zł$$,
    105,
    40,
    1,
    true,
    array['card', 'normal', 'selectn']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'zewnetrzne'),
    'mycie-zewnetrzne-premium',
    $$Mycie Zewnętrzne <span class="premium-text">PREMIUM</span>$$,
    $$Dokładne usuwanie zabrudzeń po owadach oraz ręczne mycie aktywną pianą, wraz z czyszczeniem szyb, <span class="premium-text">dokładnym czyszczeniem felg oraz opon</span>, dla pełnego odświeżenia wyglądu auta.$$,
    $$od 160 zł$$,
    160,
    60,
    2,
    true,
    array['card', 'premium']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'zewnetrzne'),
    'dressing-opon',
    $$Dressing Opon$$,
    $$Aplikacja dressingu opon nadająca oponom świeży wygląd i lepszy efekt wizualny.$$,
    $$w pakiecie$$,
    0,
    0,
    3,
    true,
    array['card', 'dressing']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'wewnetrzne'),
    'odkurzanie-wnetrza',
    $$Odkurzanie Wnętrza$$,
    $$Dokładne odkurzenie dywaników, podłogi, foteli, wnęk drzwi oraz bagażnika, usuwające kurz, piasek i drobne zanieczyszczenia.$$,
    $$od 55 zł$$,
    55,
    30,
    1,
    true,
    array['card', 'normal']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'wewnetrzne'),
    'czyszczenie-plastikow',
    $$Czyszczenie Plastików$$,
    $$Dokładne czyszczenie kokpitu, boczków drzwi, progów oraz elementów wokół kierownicy, usuwające kurz i codzienne zanieczyszczenia.$$,
    $$od 65 zł$$,
    65,
    30,
    2,
    true,
    array['card', 'normal']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'wewnetrzne'),
    'czyszczenie-plastikow-premium',
    $$Czyszczenie Plastików <span class="premium-text">PREMIUM</span>$$,
    $$Dokładne czyszczenie kokpitu, boczków drzwi, progów oraz elementów wokół kierownicy, usuwające kurz i codzienne zanieczyszczenia, <span class="premium-text">zakończone aplikacją QD nadającego świeży wygląd i lekką warstwę ochronną.</span>$$,
    $$od 95 zł$$,
    95,
    40,
    3,
    true,
    array['card', 'premium']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'pranie'),
    'pranie-pojedynczy-fotel',
    $$Pojedyńczy Fotel$$,
    $$Dokładne pranie tapicerki pojedynczego fotela, usuwające zabrudzenia, plamy i nieprzyjemne zapachy.$$,
    $$40 zł$$,
    40,
    20,
    1,
    true,
    array['card', 'pranie']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'pranie'),
    'pranie-komplet-przod',
    $$Komplet Przód$$,
    $$Dokładne pranie dwóch przednich foteli, usuwające zabrudzenia, plamy i nieprzyjemne zapachy.$$,
    $$65 zł$$,
    65,
    35,
    2,
    true,
    array['card', 'pranie']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'pranie'),
    'pranie-tylna-kanapa',
    $$Tylna Kanapa$$,
    $$Dokładne pranie tylnej kanapy, usuwające zabrudzenia, plamy i nieprzyjemne zapachy.$$,
    $$od 85 zł$$,
    85,
    45,
    3,
    true,
    array['card', 'pranie']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'pranie'),
    'pranie-wszystkie-fotele',
    $$Wszytkie Fotele$$,
    $$Dokładne pranie wszystkich foteli, usuwające zabrudzenia, plamy i nieprzyjemne zapachy.$$,
    $$od 140 zł$$,
    140,
    60,
    4,
    true,
    array['card', 'pranie']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'pranie'),
    'pranie-dywanikow',
    $$Pranie Dywaników$$,
    $$Dokładne pranie i odświeżenie dywaników samochodowych, usuwające brud, plamy oraz nieprzyjemne zapachy.$$,
    $$od 40 zł$$,
    40,
    20,
    5,
    true,
    array['card', 'pranie']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'pranie'),
    'pranie-dywanikow-premium',
    $$Pranie Dywaników <span class="premium-text">PREMIUM</span>$$,
    $$Dokładne pranie i odświeżenie dywaników samochodowych <span class="premium-text">oraz podłogi pod dywanikami</span>, usuwające brud, plamy oraz nieprzyjemne zapachy.$$,
    $$od 75 zł$$,
    75,
    30,
    6,
    true,
    array['card', 'premium']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'pranie'),
    'pranie-podlokietnikow',
    $$Pranie Podłokietników$$,
    $$Dokładne pranie materiałowych boczków drzwi i podłokietników, usuwające zabrudzenia, plamy oraz odświeżające wnętrze samochodu.$$,
    $$od 55 zł$$,
    55,
    25,
    7,
    true,
    array['card', 'pranie']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'skora'),
    'impregnacja-skory',
    $$Impregnacja Skóry$$,
    $$Zabezpieczenie skóry przed wysychaniem i pękaniem, poprawiające trwałość i estetykę tapicerki.$$,
    $$w pakiecie$$,
    0,
    0,
    5,
    true,
    array['card', 'premium']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'skora'),
    'skora-pojedynczy-fotel',
    $$Pojedyńczy Fotel$$,
    $$Czyszczenie i impregnacja skórzanego pojedynczego fotela, przywracające świeży wygląd i zabezpieczające tapicerkę przed wysychaniem, pękaniem oraz codziennym zużyciem.$$,
    $$70 zł$$,
    70,
    25,
    1,
    true,
    array['card', 'skora']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'skora'),
    'skora-komplet-przod',
    $$Komplet Przód$$,
    $$Czyszczenie i impregnacja dwóch przednich foteli skórzanych, przywracające świeży wygląd i zabezpieczające tapicerkę przed wysychaniem, pękaniem oraz codziennym zużyciem.$$,
    $$130 zł$$,
    130,
    40,
    2,
    true,
    array['card', 'skora']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'skora'),
    'skora-tylna-kanapa',
    $$Tylna Kanapa$$,
    $$Czyszczenie i impregnacja tylnej kanapy skórzanej, przywracające świeży wygląd i zabezpieczające tapicerkę przed wysychaniem, pękaniem oraz codziennym zużyciem.$$,
    $$od 145 zł$$,
    145,
    50,
    3,
    true,
    array['card', 'skora']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'skora'),
    'skora-wszystkie-fotele',
    $$Wszytkie Fotele$$,
    $$Czyszczenie i impregnacja wszystkich foteli skórzanych, przywracające świeży wygląd i zabezpieczające tapicerkę przed wysychaniem, pękaniem oraz codziennym zużyciem.$$,
    $$od 255 zł$$,
    255,
    75,
    4,
    true,
    array['card', 'skora']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'skora'),
    'skora-czyszczenie-skory',
    $$Czyszczenie Skóry$$,
    $$Dokładne czyszczenie deski rozdzielczej, kierownicy, gałki zmiany biegów oraz elementów wokół kokpitu, usuwające kurz, zabrudzenia i tłuste osady, przywracające czysty i estetyczny wygląd skórzanego wnętrza.$$,
    $$od 105 zł$$,
    105,
    35,
    6,
    true,
    array['card', 'skora']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'skora'),
    'skora-czyszczenie-podlokietnikow',
    $$Czyszczenie Podłokietników$$,
    $$Dokładne czyszczenie skórzanych podłokietników oraz skórzanych boczków drzwi, usuwające zabrudzenia, tłuste ślady i kurz, przywracające czystość oraz estetyczny wygląd elementów wnętrza.$$,
    $$od 120 zł$$,
    120,
    25,
    7,
    true,
    array['card', 'skora']::text[]
  ),
  (
    (select id from public.service_categories where slug = 'skora'),
    'skora-czyszczenie-boczkow-drzwi',
    $$Czyszczenie Boczków Drzwi$$,
    $$Dokładne czyszczenie skórzanych boczków drzwi, usuwające zabrudzenia i przywracające estetyczny wygląd elementów wnętrza.$$,
    $$od 120 zł$$,
    120,
    25,
    8,
    true,
    array['card', 'skora']::text[]
  );

insert into public.packages (
  slug,
  name_html,
  description_html,
  display_order,
  is_active,
  css_classes
)
values
  (
    'basic',
    $$Basic$$,
    $$Pakiet obejmuje odkurzanie wnętrza pojazdu oraz czyszczenie plastików, przywracające świeży wygląd i czystość całemu wnętrzu samochodu.$$,
    1,
    true,
    array['card', 'normal', 'selectn']::text[]
  ),
  (
    'standard',
    $$Standard$$,
    $$Mycie zewnętrzne pojazdu, odkurzanie wnętrza oraz czyszczenie plastików, przywracające świeży wygląd i czystość całemu wnętrzu samochodu.$$,
    2,
    true,
    array['card', 'normal', 'selectn']::text[]
  ),
  (
    'standard-premium',
    $$Standard <span class="premium-text">PREMIUM</span>$$,
    $$Mycie zewnętrzne pojazdu <span class="premium-text">z dokładnym czyszczeniem felg oraz opon</span>, <span class="dressing-text">aplikacją dressingu opon</span>, odkurzanie wnętrza oraz czyszczenie plastików <span class="premium-text">zakończone aplikacją QD</span>, przywracające świeży wygląd i czystość całemu wnętrzu samochodu.$$,
    3,
    true,
    array['card', 'premium', 'selectpr']::text[]
  ),
  (
    'pranie',
    $$Pranie$$,
    $$Pakiet obejmuje kompleksowe pranie tapicerki, foteli, dywaników oraz podłogi, usuwające zabrudzenia i nieprzyjemne zapachy, a także przywraca wnętrzu świeży i zadbany wygląd.$$,
    4,
    true,
    array['card', 'pranie']::text[]
  ),
  (
    'skora-premium',
    $$Skóra <span class="premium-text">PREMIUM</span>$$,
    $$Kompleksowe czyszczenie i pielęgnacja skórzanej tapicerki obejmujące dokładne usunięcie zabrudzeń, odtłuszczenie powierzchni, bezpieczne czyszczenie skóry <span class="premium-text">oraz impregnację zabezpieczającą przed wysychaniem i pękaniem</span>, przywracając świeży wygląd i miękkość tapicerki.$$,
    5,
    true,
    array['card', 'premium']::text[]
  ),
  (
    'full-pakiet',
    $$Full Pakiet$$,
    $$Kompleksowe odświeżenie auta obejmujące dokładne czyszczenie wnętrza oraz mycie zewnętrzne. Pakiet stworzony dla osób, które chcą przywrócić samochodowi świeży, zadbany wygląd i czystość w każdym detalu.$$,
    6,
    true,
    array['card', 'full']::text[]
  ),
  (
    'full-pakiet-skora',
    $$Full Pakiet Skóra$$,
    $$Kompletne odświeżenie samochodu stworzone dla osób, które chcą przywrócić autu świeżość, czystość i zadbany wygląd w każdym detalu. Usługa obejmuje kompleksową pielęgnację wnętrza oraz karoserii, dzięki czemu samochód prezentuje się estetycznie zarówno z zewnątrz, jak i w środku.$$,
    7,
    true,
    array['card', 'full']::text[]
  );

insert into public.package_items (package_id, service_id, item_order)
values
  (
    (select id from public.packages where slug = 'basic'),
    (select id from public.services where slug = 'odkurzanie-wnetrza'),
    1
  ),
  (
    (select id from public.packages where slug = 'basic'),
    (select id from public.services where slug = 'czyszczenie-plastikow'),
    2
  ),
  (
    (select id from public.packages where slug = 'standard'),
    (select id from public.services where slug = 'mycie-zewnetrzne'),
    1
  ),
  (
    (select id from public.packages where slug = 'standard'),
    (select id from public.services where slug = 'czyszczenie-plastikow'),
    2
  ),
  (
    (select id from public.packages where slug = 'standard'),
    (select id from public.services where slug = 'odkurzanie-wnetrza'),
    3
  ),
  (
    (select id from public.packages where slug = 'standard-premium'),
    (select id from public.services where slug = 'mycie-zewnetrzne-premium'),
    1
  ),
  (
    (select id from public.packages where slug = 'standard-premium'),
    (select id from public.services where slug = 'czyszczenie-plastikow-premium'),
    2
  ),
  (
    (select id from public.packages where slug = 'standard-premium'),
    (select id from public.services where slug = 'odkurzanie-wnetrza'),
    3
  ),
  (
    (select id from public.packages where slug = 'standard-premium'),
    (select id from public.services where slug = 'dressing-opon'),
    4
  ),
  (
    (select id from public.packages where slug = 'pranie'),
    (select id from public.services where slug = 'pranie-dywanikow-premium'),
    1
  ),
  (
    (select id from public.packages where slug = 'pranie'),
    (select id from public.services where slug = 'pranie-wszystkie-fotele'),
    2
  ),
  (
    (select id from public.packages where slug = 'pranie'),
    (select id from public.services where slug = 'pranie-podlokietnikow'),
    3
  ),
  (
    (select id from public.packages where slug = 'skora-premium'),
    (select id from public.services where slug = 'impregnacja-skory'),
    1
  ),
  (
    (select id from public.packages where slug = 'skora-premium'),
    (select id from public.services where slug = 'skora-czyszczenie-skory'),
    2
  ),
  (
    (select id from public.packages where slug = 'skora-premium'),
    (select id from public.services where slug = 'skora-tylna-kanapa'),
    3
  ),
  (
    (select id from public.packages where slug = 'skora-premium'),
    (select id from public.services where slug = 'skora-czyszczenie-podlokietnikow'),
    4
  ),
  (
    (select id from public.packages where slug = 'skora-premium'),
    (select id from public.services where slug = 'skora-czyszczenie-boczkow-drzwi'),
    5
  ),
  (
    (select id from public.packages where slug = 'full-pakiet'),
    (select id from public.services where slug = 'mycie-zewnetrzne-premium'),
    1
  ),
  (
    (select id from public.packages where slug = 'full-pakiet'),
    (select id from public.services where slug = 'czyszczenie-plastikow-premium'),
    2
  ),
  (
    (select id from public.packages where slug = 'full-pakiet'),
    (select id from public.services where slug = 'odkurzanie-wnetrza'),
    3
  ),
  (
    (select id from public.packages where slug = 'full-pakiet'),
    (select id from public.services where slug = 'dressing-opon'),
    4
  ),
  (
    (select id from public.packages where slug = 'full-pakiet'),
    (select id from public.services where slug = 'pranie-dywanikow-premium'),
    5
  ),
  (
    (select id from public.packages where slug = 'full-pakiet'),
    (select id from public.services where slug = 'pranie-wszystkie-fotele'),
    6
  ),
  (
    (select id from public.packages where slug = 'full-pakiet'),
    (select id from public.services where slug = 'pranie-podlokietnikow'),
    7
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'mycie-zewnetrzne-premium'),
    1
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'czyszczenie-plastikow-premium'),
    2
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'odkurzanie-wnetrza'),
    3
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'dressing-opon'),
    4
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'pranie-dywanikow-premium'),
    5
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'pranie-wszystkie-fotele'),
    6
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'pranie-podlokietnikow'),
    7
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'impregnacja-skory'),
    8
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'skora-czyszczenie-skory'),
    9
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'skora-tylna-kanapa'),
    10
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'skora-czyszczenie-podlokietnikow'),
    11
  ),
  (
    (select id from public.packages where slug = 'full-pakiet-skora'),
    (select id from public.services where slug = 'skora-czyszczenie-boczkow-drzwi'),
    12
  );
