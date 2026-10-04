-- B12 Steak live Wix menu correction/additions - 2026-10-02
-- Idempotent live-menu correction pack. Safe to re-run after the base schema/seeds.
do $$ declare cat bigint; sec bigint; itm bigint;
begin
 select id into cat from public.menu_categories where slug='alkollu';
 if cat is null then return; end if;

 -- Missing sections
 insert into public.menu_sections(category_id,title_tr,title_en,title_ru,sort_order,is_active)
 select cat,'Bira','Beers','Пиво',50,true where not exists(select 1 from public.menu_sections where category_id=cat and title_tr='Bira');
 insert into public.menu_sections(category_id,title_tr,title_en,title_ru,sort_order,is_active)
 select cat,'Rakı','Raki','Ракы',60,true where not exists(select 1 from public.menu_sections where category_id=cat and title_tr='Rakı');

 -- Complete LIQUOR & VERMOUTH
 select id into sec from public.menu_sections where category_id=cat and title_tr='LIQUOR & VERMOUTH' limit 1;
 if sec is not null then
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,'Jagermeister','Jagermeister','Jagermeister',0,30,true where not exists(select 1 from public.menu_items where section_id=sec and name_tr='Jagermeister');
   select id into itm from public.menu_items where section_id=sec and name_tr='Jagermeister' limit 1;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'Shot 5 CL','Shot 5 CL','Шот 5 CL',280,10,true where not exists(select 1 from public.menu_item_variants where item_id=itm);

   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,'Grappa','Grappa','Граппа',0,40,true where not exists(select 1 from public.menu_items where section_id=sec and name_tr='Grappa');
   select id into itm from public.menu_items where section_id=sec and name_tr='Grappa' limit 1;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'Shot 5 CL','Shot 5 CL','Шот 5 CL',240,10,true where not exists(select 1 from public.menu_item_variants where item_id=itm);

   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,'Limoncello','Lemonchello','Лимончелло',0,50,true where not exists(select 1 from public.menu_items where section_id=sec and name_tr='Limoncello');
   select id into itm from public.menu_items where section_id=sec and name_tr='Limoncello' limit 1;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'Shot 5 CL','Shot 5 CL','Шот 5 CL',240,10,true where not exists(select 1 from public.menu_item_variants where item_id=itm);

   select id into itm from public.menu_items where section_id=sec and name_tr='Baileys' limit 1;
   if itm is not null and not exists(select 1 from public.menu_item_variants where item_id=itm) then
     insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Shot 5 CL','Shot 5 CL','Шот 5 CL',240,10,true);
   end if;
 end if;

 -- Beers
 select id into sec from public.menu_sections where category_id=cat and title_tr='Bira' limit 1;
 if sec is not null then
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,x.n,x.e,x.r,x.p,x.s,true from (values
    ('MILLER 33 CL','Miller','Miller',280::numeric,10),
    ('EFES PİLSEN 33 CL','EFES PİLSEN','EFES PILSEN',210::numeric,20),
    ('EFES MALT 50 CL','EFES MALT','EFES MALT',290::numeric,30),
    ('BOMONTİ FİLTRESİZ 50 CL','BOMONTİ FİLTRESİZ','BOMONTI UNFILTERED',300::numeric,40),
    ('CORONA 33 CL','Corona','Corona',390::numeric,50)
   ) x(n,e,r,p,s) where not exists(select 1 from public.menu_items i where i.section_id=sec and i.name_tr=x.n);
 end if;

 -- Rakı: add confirmed product shell; detailed sizes can be completed from live source/admin.
 select id into sec from public.menu_sections where category_id=cat and title_tr='Rakı' limit 1;
 if sec is not null then
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,'BEYLERBEYİ GÖBEK','BEYLERBEYİ GÖBEK','BEYLERBEYİ GÖBEK',0,10,true where not exists(select 1 from public.menu_items where section_id=sec and name_tr='BEYLERBEYİ GÖBEK');
   select id into itm from public.menu_items where section_id=sec and name_tr='BEYLERBEYİ GÖBEK' limit 1;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,x.t,x.e,x.r,x.p,x.s,true from (values
    ('4 CL','4 CL','4 CL',370::numeric,10),
    ('8 CL','8 CL','8 CL',520::numeric,20),
    ('20 CL','20 CL','20 CL',1400::numeric,30)
   ) x(t,e,r,p,s) where not exists(select 1 from public.menu_item_variants v where v.item_id=itm and v.label_tr=x.t);
 end if;
end $$;

-- Additional Rakı corrections verified against live Wix menu
do $$ declare cat bigint; sec bigint; itm bigint; rec record;
begin
 select id into cat from public.menu_categories where slug='alkollu';
 select id into sec from public.menu_sections where category_id=cat and title_tr='Rakı' limit 1;
 if sec is null then return; end if;
 for rec in select * from (values
 ('YENİ RAKI',1600::numeric,2900::numeric,20),
 ('YENİ RAKI- YENİ SERİ',1750::numeric,3100::numeric,30),
 ('YENİ RAKI- ALA',1450::numeric,2600::numeric,40),
 ('TEKİRDAĞ RAKISI',1700::numeric,3100::numeric,50),
 ('TEKİRDAĞ RAKISI GOLD',2000::numeric,3400::numeric,60),
 ('GOLD EFE RAKI',1800::numeric,3200::numeric,70)
 ) x(n,p35,p70,s)
 loop
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,rec.n,rec.n,rec.n,0,rec.s,true where not exists(select 1 from public.menu_items where section_id=sec and name_tr=rec.n);
   select id into itm from public.menu_items where section_id=sec and name_tr=rec.n limit 1;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'35 CL','35 CL','35 CL',rec.p35,10,true where not exists(select 1 from public.menu_item_variants where item_id=itm and label_tr='35 CL');
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'70 CL','70 CL','70 CL',rec.p70,20,true where not exists(select 1 from public.menu_item_variants where item_id=itm and label_tr='70 CL');
 end loop;
 select id into itm from public.menu_items where section_id=sec and name_tr in ('BEYLERBEYİ GÖBEK','BEYLER BEYİ GÖBEK') limit 1;
 if itm is not null then
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,x.l,x.l,x.l,x.p,x.s,true from (values ('35 CL',2300::numeric,40),('70 CL',3900::numeric,50)) x(l,p,s)
   where not exists(select 1 from public.menu_item_variants where item_id=itm and label_tr=x.l);
 end if;
end $$;

-- Normalize whisky variant labels for all three languages without changing prices
update public.menu_item_variants v set
 label_tr=case when lower(coalesce(v.label_en,'')) like 'shot%' or lower(v.label_tr)='tek' then 'Tek 5 CL' when lower(coalesce(v.label_en,'')) like 'double%' or lower(v.label_tr)='duble' then 'Duble 10 CL' when lower(coalesce(v.label_en,''))='bottle' or lower(v.label_tr)='şişe' then 'Şişe' else v.label_tr end,
 label_en=case when lower(coalesce(v.label_en,'')) like 'shot%' or lower(v.label_tr) in ('tek','tek 5 cl') then 'Shot 5 CL' when lower(coalesce(v.label_en,'')) like 'double%' or lower(v.label_tr) in ('duble','duble 10 cl') then 'Double 10 CL' when lower(coalesce(v.label_en,''))='bottle' or lower(v.label_tr)='şişe' then 'Bottle' else v.label_en end,
 label_ru=case when lower(coalesce(v.label_en,'')) like 'shot%' or lower(v.label_tr) in ('tek','tek 5 cl') then 'Порция 5 CL' when lower(coalesce(v.label_en,'')) like 'double%' or lower(v.label_tr) in ('duble','duble 10 cl') then 'Двойная 10 CL' when lower(coalesce(v.label_en,''))='bottle' or lower(v.label_tr)='şişe' then 'Бутылка' else coalesce(v.label_ru,v.label_tr) end
where v.item_id in (
 select i.id from public.menu_items i join public.menu_sections s on s.id=i.section_id join public.menu_categories c on c.id=s.category_id where c.slug='viski'
);

-- Normalize soft-drink sizes as variants
do $$ declare itm bigint;
begin
 select id into itm from public.menu_items where name_tr='Şalgam Suyu 330 ml' limit 1;
 if itm is not null then
   update public.menu_items set price=0,description_tr='Şalgam Suyu',name_en=coalesce(name_en,'Turnip Juice'),name_ru=coalesce(name_ru,'Шалгам') where id=itm;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,x.t,x.e,x.r,x.p,x.s,true from (values
    ('330 ML','330 ML','330 МЛ',80::numeric,10),
    ('1 LT','1 L','1 Л',220::numeric,20)
   ) x(t,e,r,p,s) where not exists(select 1 from public.menu_item_variants v where v.item_id=itm and v.label_tr=x.t);
 end if;

 select id into itm from public.menu_items where name_tr='Uludağ Soda' limit 1;
 if itm is not null then
   update public.menu_items set price=0,name_en=coalesce(name_en,'Uludağ Mineral Water'),name_ru=coalesce(name_ru,'Минеральная вода Uludağ') where id=itm;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,x.t,x.e,x.r,x.p,x.s,true from (values
    ('250 ML','250 ML','250 МЛ',90::numeric,10),
    ('750 ML','750 ML','750 МЛ',195::numeric,20)
   ) x(t,e,r,p,s) where not exists(select 1 from public.menu_item_variants v where v.item_id=itm and replace(upper(v.label_tr),' ','')=replace(upper(x.t),' ',''));
 end if;
end $$;


-- Complete remaining Rakı products verified against live Wix menu on 2026-10-02
do $$ declare cat bigint; sec bigint; itm bigint; rec record;
begin
 select id into cat from public.menu_categories where slug='alkollu';
 select id into sec from public.menu_sections where category_id=cat and title_tr='Rakı' limit 1;
 if sec is null then return; end if;

 for rec in select * from (values
  ('BEYLERBEYİ TERRA GOLD',1800::numeric,3200::numeric,80),
  ('BEYLERBEYİ MAVİ',1750::numeric,3000::numeric,90),
  ('KLÜP RAKI',2000::numeric,3400::numeric,100)
 ) x(n,p35,p70,s)
 loop
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,rec.n,rec.n,rec.n,0,rec.s,true
   where not exists(select 1 from public.menu_items where section_id=sec and name_tr=rec.n);
   select id into itm from public.menu_items where section_id=sec and name_tr=rec.n limit 1;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'35 CL','35 CL','35 CL',rec.p35,10,true
   where not exists(select 1 from public.menu_item_variants where item_id=itm and label_tr='35 CL');
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'70 CL','70 CL','70 CL',rec.p70,20,true
   where not exists(select 1 from public.menu_item_variants where item_id=itm and label_tr='70 CL');
 end loop;

 for rec in select * from (values
  ('SARI ZEYBEK 3 MEŞE 70 CL',4300::numeric,110),
  ('MERCAN 70 CL',3500::numeric,120)
 ) x(n,p,s)
 loop
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,rec.n,rec.n,rec.n,rec.p,rec.s,true
   where not exists(select 1 from public.menu_items where section_id=sec and name_tr=rec.n);
 end loop;
end $$;


-- Complete imported wines missing from the original seed, verified against live Wix menu 2026-10-02
do $$ declare cat bigint; sec bigint; itm bigint; rec record;
begin
 select id into cat from public.menu_categories where slug='sarap';
 if cat is null then return; end if;
 select id into sec from public.menu_sections where category_id=cat and title_tr='İthal' limit 1;
 if sec is null then return; end if;

 for rec in select * from (values
  ('Şili / Casabalnca Valley Montes, Merlot',null,2600::numeric,20),
  ('İtalya / Docg, Chanti LA Terre',null,1750::numeric,30),
  ('Fransa / Aoc, Bourgogne, Jaffelin Pinot Noir',null,2450::numeric,40),
  ('Şili / Casabalnca Valley Montes, Cabernet Sauvignon',null,2600::numeric,50),
  ('Maison Kavaklıdere / La Croix Lortique',null,4400::numeric,60),
  ('Maison Kavaklıdere / La Folie',null,2400::numeric,70),
  ('Muga Reserva','Tempranillo Garnacha (Grenache), Mazuelo ve Graciano',3900::numeric,80),
  ('Marchesi Di Barolo & Serrragilli Barbaresco','Nebbiolo',6200::numeric,90),
  ('Tomassi Amarone Della Valpolicella Classico','Corvina Corvinone Rondinella Oseleta',6200::numeric,100)
 ) x(n,d,p,s)
 loop
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,description_tr,price,sort_order,is_active)
   select sec,rec.n,rec.n,rec.n,rec.d,rec.p,rec.s,true
   where not exists(select 1 from public.menu_items where section_id=sec and name_tr=rec.n);
 end loop;

 select id into itm from public.menu_items where section_id=sec and name_tr='İtalya / Docg, Chanti LA Terre' limit 1;
 if itm is not null then
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'Kadeh','Glass','Бокал',380,10,true
   where not exists(select 1 from public.menu_item_variants where item_id=itm and label_tr='Kadeh');
 end if;

 -- Wix currently shows the Köpüklü heading with no listed products.
 insert into public.menu_sections(category_id,title_tr,title_en,title_ru,sort_order,is_active)
 select cat,'Köpüklü','Sparkling','Игристое',50,true
 where not exists(select 1 from public.menu_sections where category_id=cat and title_tr='Köpüklü');
end $$;


-- Correct live alcoholic prices/sizes verified against Wix on 2026-10-02
do $$ declare itm bigint;
begin
 select id into itm from public.menu_items where name_tr='Absolut' limit 1;
 if itm is not null then
   update public.menu_item_variants set price=220 where item_id=itm and (upper(label_tr) like 'SHOT%' or upper(label_tr) like 'TEK%');
   update public.menu_item_variants set price=380 where item_id=itm and (upper(label_tr) like 'DUBLE%' or upper(coalesce(label_en,'')) like 'DOUBLE%');
   update public.menu_item_variants set price=2400 where item_id=itm and (upper(label_tr) like 'ŞİŞE%' or upper(coalesce(label_en,''))='BOTTLE');
 end if;

 select id into itm from public.menu_items where name_tr='Gordon''s' limit 1;
 if itm is not null then
   update public.menu_item_variants set price=200 where item_id=itm and (upper(label_tr) like 'SHOT%' or upper(label_tr) like 'TEK%');
   update public.menu_item_variants set price=360 where item_id=itm and (upper(label_tr) like 'DUBLE%' or upper(coalesce(label_en,'')) like 'DOUBLE%');
   update public.menu_item_variants set price=2400 where item_id=itm and (upper(label_tr) like 'ŞİŞE%' or upper(coalesce(label_en,''))='BOTTLE');
 end if;

 -- EFES PİLSEN is 33 CL bottle / 210 TL on the current Wix menu.
 update public.menu_items
 set name_tr='EFES PİLSEN 33 CL',name_en='EFES PİLSEN',name_ru='EFES PILSEN',price=210
 where name_tr in ('EFES PİLSEN 50 CL','EFES PİLSEN 33 CL');

 -- Keep current live beer names/sizes normalized.
 update public.menu_items set name_tr='MILLER 33 CL',price=280 where name_tr in ('MILLER 33 CL','Miller');
 update public.menu_items set name_tr='EFES MALT 50 CL',price=290 where name_tr='EFES MALT 50 CL';
 update public.menu_items set name_tr='BOMONTİ FİLTRESİZ 50 CL',price=300 where name_tr='BOMONTİ FİLTRESİZ 50 CL';
 update public.menu_items set name_tr='CORONA 33 CL',price=390 where name_tr in ('CORONA 35,5 CL','CORONA 33 CL');
end $$;


-- Wix-reference normalization: alcoholic menu labels and missing items/images review 2026-10-03
do $$ declare itm bigint;
begin
  -- Keep Wix Turkish display names exact.
  update public.menu_items set name_tr='Olmeca' where lower(name_tr)='olmeca';
  update public.menu_items set name_tr='Smirnoff Red' where lower(name_tr)='smirnoff red';
  update public.menu_items set name_tr='Absolut' where lower(name_tr)='absolut';
  update public.menu_items set name_tr='Belvedere' where lower(name_tr)='belvedere';
  update public.menu_items set name_tr='Beefeater' where lower(name_tr)='beefeater';
  update public.menu_items set name_tr='Gordon''s' where lower(name_tr)='gordon''s';
  update public.menu_items set name_tr='Campari' where lower(name_tr)='campari';
  update public.menu_items set name_tr='Baileys' where lower(name_tr)='baileys';
  update public.menu_items set name_tr='Jagermeister' where lower(name_tr)='jagermeister';
  update public.menu_items set name_tr='Grappa' where lower(name_tr)='grappa';
  update public.menu_items set name_tr='Limoncello' where lower(name_tr)='limoncello';

  -- Wix uses Shot / Duble / Şişe wording in Turkish alcoholic menu.
  update public.menu_item_variants v set label_tr='Shot 5 CL'
  where v.item_id in (select i.id from public.menu_items i join public.menu_sections s on s.id=i.section_id join public.menu_categories c on c.id=s.category_id where c.slug='alkollu')
    and (upper(v.label_tr) like 'TEK%' or upper(v.label_tr) like 'SHOT%');
  update public.menu_item_variants v set label_tr='Duble 10 CL'
  where v.item_id in (select i.id from public.menu_items i join public.menu_sections s on s.id=i.section_id join public.menu_categories c on c.id=s.category_id where c.slug='alkollu')
    and (upper(v.label_tr) like 'DUBLE%' or upper(coalesce(v.label_en,'')) like 'DOUBLE%');
  update public.menu_item_variants v set label_tr='Şişe'
  where v.item_id in (select i.id from public.menu_items i join public.menu_sections s on s.id=i.section_id join public.menu_categories c on c.id=s.category_id where c.slug='alkollu')
    and (upper(v.label_tr) like 'ŞİŞE%' or upper(coalesce(v.label_en,''))='BOTTLE');

  -- Exact Wix values visible in the current reference.
  select id into itm from public.menu_items where name_tr='Absolut' limit 1;
  if itm is not null then
    update public.menu_item_variants set price=220 where item_id=itm and upper(label_tr)='SHOT 5 CL';
    update public.menu_item_variants set price=380 where item_id=itm and upper(label_tr)='DUBLE 10 CL';
    update public.menu_item_variants set price=2400 where item_id=itm and label_tr='Şişe';
  end if;

  -- Rakı labels exactly as Wix reference.
  update public.menu_items set name_tr='BEYLERBEYİ GÖBEK' where name_tr in ('BEYLER BEYİ GÖBEK','BEYLERBEYİ GÖBEK');
  update public.menu_items set name_tr='YENİ RAKI' where name_tr='YENİ RAKI';
  update public.menu_items set name_tr='YENİ RAKI- YENİ SERİ' where name_tr in ('YENİ RAKI - YENİ SERİ','YENİ RAKI- YENİ SERİ');
  update public.menu_items set name_tr='YENİ RAKI- ALA' where name_tr in ('YENİ RAKI - ALA','YENİ RAKI- ALA');
  update public.menu_items set name_tr='TEKİRDAĞ RAKISI' where name_tr='TEKİRDAĞ RAKISI';
  update public.menu_items set name_tr='TEKİRDAĞ RAKISI GOLD' where name_tr='TEKİRDAĞ RAKISI GOLD';
  update public.menu_items set name_tr='GOLD EFE RAKI' where name_tr='GOLD EFE RAKI';
  update public.menu_items set name_tr='BEYLERBEYİ TERRA GOLD' where name_tr='BEYLERBEYİ TERRA GOLD';
  update public.menu_items set name_tr='BEYLERBEYİ MAVİ' where name_tr='BEYLERBEYİ MAVİ';
  update public.menu_items set name_tr='KLÜP RAKI' where name_tr='KLÜP RAKI';
end $$;


-- Complete wine list against live Wix reference - 2026-10-03
do $$ declare cat bigint; sec bigint;
begin
 select id into cat from public.menu_categories where slug='sarap';
 if cat is null then return; end if;

 select id into sec from public.menu_sections where category_id=cat and title_tr='Kırmızı' limit 1;
 if sec is not null then
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,'Selection / Öküzgözü-Bogazkere','Selection / Öküzgözü-Bogazkere','Selection / Öküzgözü-Bogazkere',3800,70,true
   where not exists(select 1 from public.menu_items where section_id=sec and name_tr='Selection / Öküzgözü-Bogazkere');
   update public.menu_items set price=1850 where section_id=sec and name_tr='Suvla / Cabarnet Sauvignon-Merlot';
   update public.menu_items set price=1750 where section_id=sec and name_tr='Suvla / ÖküzGözü/Boğazkere';
   update public.menu_items set price=3900 where section_id=sec and name_tr='Kavaklıdere / Egeo Merlot';
   update public.menu_items set price=3900 where section_id=sec and name_tr='Kavaklıdere / Egeo Cabernet Sauvignon';
   update public.menu_items set price=3700 where section_id=sec and name_tr='Kavaklıdere / Egeo Syrah';
   update public.menu_items set price=4900 where section_id=sec and name_tr='Kavaklıdere / Prestige Kalecik Karası';
   update public.menu_items set price=4900 where section_id=sec and name_tr='Kavaklıdere / Pendore Syrah';
 end if;

 select id into sec from public.menu_sections where category_id=cat and title_tr='Rose' limit 1;
 if sec is not null then
   insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
   select sec,'Sartori Pinot Grigio','Sartori Pinot Grigio','Sartori Pinot Grigio',2050,10,true
   where not exists(select 1 from public.menu_items where section_id=sec and name_tr='Sartori Pinot Grigio');
 end if;
end $$;


-- Wine variants verified against live Wix - 2026-10-03
do $$ declare itm bigint;
begin
 -- Ancyra Narince: bottle 1800 + glass 380
 select mi.id into itm from public.menu_items mi join public.menu_sections ms on ms.id=mi.section_id
 join public.menu_categories mc on mc.id=ms.category_id
 where mc.slug='sarap' and mi.name_tr='Kavaklıdere / Ancyra Narince' limit 1;
 if itm is not null then
   update public.menu_items set price=1800 where id=itm;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'Kadeh','Glass','Бокал',380,10,true
   where not exists(select 1 from public.menu_item_variants where item_id=itm and lower(label_tr)='kadeh');
 end if;

 -- Ancyra Blush: bottle 1800 + glass 380
 select mi.id into itm from public.menu_items mi join public.menu_sections ms on ms.id=mi.section_id
 join public.menu_categories mc on mc.id=ms.category_id
 where mc.slug='sarap' and mi.name_tr='Kavaklıdere / Ancyra Blush' limit 1;
 if itm is not null then
   update public.menu_items set price=1800 where id=itm;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'Kadeh','Glass','Бокал',380,10,true
   where not exists(select 1 from public.menu_item_variants where item_id=itm and lower(label_tr)='kadeh');
 end if;

 -- Suvla Öküzgözü/Boğazkere: bottle 1750 + glass 380
 select mi.id into itm from public.menu_items mi join public.menu_sections ms on ms.id=mi.section_id
 join public.menu_categories mc on mc.id=ms.category_id
 where mc.slug='sarap' and mi.name_tr='Suvla / ÖküzGözü/Boğazkere' limit 1;
 if itm is not null then
   update public.menu_items set price=1750 where id=itm;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
   select itm,'Kadeh','Glass','Бокал',380,10,true
   where not exists(select 1 from public.menu_item_variants where item_id=itm and lower(label_tr)='kadeh');
 end if;
end $$;


-- MASTER WINE ALIGNMENT: live Wix order/names/prices - 2026-10-03
do $$
declare cat bigint; sec bigint; itm bigint; r record;
begin
 select id into cat from public.menu_categories where slug='sarap';
 if cat is null then return; end if;

 -- Exact Wix section order
 update public.menu_sections set sort_order=10 where category_id=cat and title_tr='Kırmızı';
 update public.menu_sections set sort_order=20 where category_id=cat and title_tr='Beyaz';
 update public.menu_sections set sort_order=30 where category_id=cat and title_tr='Rose';
 update public.menu_sections set sort_order=40 where category_id=cat and title_tr='İthal';
 update public.menu_sections set sort_order=50 where category_id=cat and title_tr='Köpüklü';

 -- Ensure the two items absent from the original seed exist.
 select id into sec from public.menu_sections where category_id=cat and title_tr='Kırmızı' limit 1;
 insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
 select sec,'Selection / Öküzgözü-Bogazkere','Selection / Öküzgözü-Bogazkere','Selection / Öküzgözü-Bogazkere',3800,70,true
 where sec is not null and not exists(select 1 from public.menu_items where section_id=sec and name_tr='Selection / Öküzgözü-Bogazkere');

 select id into sec from public.menu_sections where category_id=cat and title_tr='Rose' limit 1;
 insert into public.menu_items(section_id,name_tr,name_en,name_ru,price,sort_order,is_active)
 select sec,'Sartori Pinot Grigio','Sartori Pinot Grigio','Sartori Pinot Grigio',2050,10,true
 where sec is not null and not exists(select 1 from public.menu_items where section_id=sec and name_tr='Sartori Pinot Grigio');

 -- Exact Wix item order and bottle/base prices.
 for r in
   select * from (values
   ('Kırmızı','Suvla / Cabarnet Sauvignon-Merlot',1850::numeric,10),
   ('Kırmızı','Suvla / ÖküzGözü/Boğazkere',1750,20),
   ('Kırmızı','Kavaklıdere / Egeo Merlot',3900,30),
   ('Kırmızı','Kavaklıdere / Egeo Cabernet Sauvignon',3900,40),
   ('Kırmızı','Kavaklıdere / Egeo Syrah',3700,50),
   ('Kırmızı','Kavaklıdere / Prestige Kalecik Karası',4900,60),
   ('Kırmızı','Selection / Öküzgözü-Bogazkere',3800,70),
   ('Kırmızı','Kavaklıdere / Pendore Syrah',4900,80),
   ('Kırmızı','Oguz Vigna Nord',2500,90),
   ('Kırmızı','Consensus / Shiraz & Cabernet Sauvignon & Merlot',3500,100),
   ('Kırmızı','Ament Blend',3750,110),
   ('Kırmızı','Kavaklıdere / Ancyra Öküzgözü',1800,120),
   ('Kırmızı','Kavaklıdere / Ancyra Merlot',1800,130),
   ('Kırmızı','Yedi Bilgeler Pythgoras',3400,140),
   ('Kırmızı','Chamlıja Nevi Şahsına Münasır',3900,150),
   ('Beyaz','Suvla / Chardonnay',3050,10),
   ('Beyaz','Kavaklıdere / Selection, Emir& Narince',3500,20),
   ('Beyaz','Kavaklıdere / Misket',2900,30),
   ('Beyaz','Kavaklıdere / Sultaniye Y.Tatlı',1900,40),
   ('Beyaz','Kavaklıdere / Ancyra Narince',1800,50),
   ('Beyaz','Suvla Sauvignon Blanc & Semıllon',1850,60),
   ('Beyaz','Marchesi Dı Barolo & Gavı Dı Gavı',3900,70),
   ('Beyaz','Tomassi Soave Classico',2700,80),
   ('Beyaz','Chablis Le Finage AOC',4100,90),
   ('Beyaz','Roc De I''Abbaye Sancerre Blanc',3900,100),
   ('Beyaz','Yedi Bilgeler Khilon',2600,110),
   ('Beyaz','Yedi Bilgeler Anaxagoras',2600,120),
   ('Beyaz','Chamlıja Quartz Füme',3750,130),
   ('Rose','Sartori Pinot Grigio',2050,10),
   ('Rose','Kavaklıdere / Ancyra Blush',1800,20),
   ('Rose','Bodvar Cotes De Pronence',3150,30),
   ('İthal','Arjantin / Kaiken Reserva Malbec',2800,10),
   ('İthal','Şili / Casabalnca Valley Montes, Merlot',2600,20),
   ('İthal','İtalya / Docg, Chanti LA Terre',1750,30),
   ('İthal','Fransa / Aoc, Bourgogne, Jaffelin Pinot Noir',2450,40),
   ('İthal','Şili / Casabalnca Valley Montes, Cabernet Sauvignon',2600,50),
   ('İthal','Maison Kavaklıdere / La Croix Lortique',4400,60),
   ('İthal','Maison Kavaklıdere / La Folie',2400,70),
   ('İthal','Muga Reserva',3900,80),
   ('İthal','Marchesi Di Barolo & Serrragilli Barbaresco',6200,90),
   ('İthal','Tomassi Amarone Della Valpolicella Classico',6200,100)
   ) as v(section_name,item_name,item_price,item_order)
 loop
   update public.menu_items mi
   set price=r.item_price, sort_order=r.item_order, is_active=true
   from public.menu_sections ms
   where mi.section_id=ms.id and ms.category_id=cat
     and ms.title_tr=r.section_name and mi.name_tr=r.item_name;
 end loop;

 -- Exact Wix grape/description lines.
 update public.menu_items mi set description_tr='MERLOT/CALROSSO'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr='Oguz Vigna Nord';
 update public.menu_items mi set description_tr='Cabarnet Sauvignon Cabarnet Franc Merlot Petit Verdot'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr='Yedi Bilgeler Pythgoras';
 update public.menu_items mi set description_tr='Cortese'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr='Marchesi Dı Barolo & Gavı Dı Gavı';
 update public.menu_items mi set description_tr='Garganega'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr='Tomassi Soave Classico';
 update public.menu_items mi set description_tr='Chardonnay'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr in ('Chablis Le Finage AOC','Yedi Bilgeler Anaxagoras');
 update public.menu_items mi set description_tr='Sauvignon Blanc'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr in ('Roc De I''Abbaye Sancerre Blanc','Yedi Bilgeler Khilon','Chamlıja Quartz Füme');
 update public.menu_items mi set description_tr='Grenache, Cinsault ve Rolle (Vermentino)'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr='Bodvar Cotes De Pronence';
 update public.menu_items mi set description_tr='Tempranillo Garnacha (Grenache), Mazuelo ve Graciano'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr='Muga Reserva';
 update public.menu_items mi set description_tr='Nebbiolo'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr='Marchesi Di Barolo & Serrragilli Barbaresco';
 update public.menu_items mi set description_tr='Corvina Corvinone Rondinella Oseleta'
 from public.menu_sections ms where mi.section_id=ms.id and ms.category_id=cat and mi.name_tr='Tomassi Amarone Della Valpolicella Classico';

 -- Wix glass options: exactly these four wine items at 380.
 for r in select * from (values
   ('Suvla / ÖküzGözü/Boğazkere'),
   ('Kavaklıdere / Ancyra Narince'),
   ('Kavaklıdere / Ancyra Blush'),
   ('İtalya / Docg, Chanti LA Terre')
 ) as v(item_name)
 loop
   select mi.id into itm from public.menu_items mi
   join public.menu_sections ms on ms.id=mi.section_id
   where ms.category_id=cat and mi.name_tr=r.item_name limit 1;
   if itm is not null then
     update public.menu_item_variants set price=380,sort_order=10,is_active=true
       where item_id=itm and lower(label_tr)='kadeh';
     insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active)
       select itm,'Kadeh','Glass','Бокал',380,10,true
       where not exists(select 1 from public.menu_item_variants where item_id=itm and lower(label_tr)='kadeh');
   end if;
 end loop;
end $$;


-- FULL WIX MENU AUDIT corrections - 2026-10-03
do $$
declare itm bigint;
begin
 -- Soft: current Wix names/base prices.
 update public.menu_items set price=80 where name_tr='SU';
 update public.menu_items set price=380 where name_tr='S.Pellegrino';
 update public.menu_items set price=80 where name_tr='Soda';
 update public.menu_items set price=80 where name_tr='Şalgam Suyu 330 ml';
 update public.menu_items set price=90 where name_tr='Ayran';
 update public.menu_items set price=125 where name_tr='Sprite';
 update public.menu_items set price=125 where name_tr='COCA COLA';
 update public.menu_items set price=125 where name_tr='Fanta';
 update public.menu_items set price=130 where name_tr='Cappy Meyve Suyu';
 update public.menu_items set price=130 where name_tr='FUSE TEA';
 update public.menu_items set price=190 where name_tr='Redbull';
 update public.menu_items set price=190 where name_tr='Taze Portakal Suyu';
 update public.menu_items set price=90 where name_tr='Uludağ Soda';
 select id into itm from public.menu_items where name_tr='Uludağ Soda' limit 1;
 if itm is not null then
   delete from public.menu_item_variants where item_id=itm;
   insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values
   (itm,'250ML','250ML','250ML',90,10,true),(itm,'750ML','750ML','750ML',195,20,true);
 end if;

 -- Desserts.
 update public.menu_items set price=310 where name_tr='Tiramisu';
 update public.menu_items set price=950 where name_tr='Katmer';

 -- Alcohol current Wix spelling/prices.
 update public.menu_items set name_tr='EFES PİLSEN 50 CL',price=290 where name_tr in ('EFES PİLSEN 33 CL','EFES PİLSEN 50 CL');
 update public.menu_items set name_tr='CORONA 35,5 CL',price=390 where name_tr in ('CORONA 33 CL','CORONA 35,5 CL');
 update public.menu_items set price=280 where name_tr='MILLER 33 CL';
 update public.menu_items set price=290 where name_tr='EFES MALT 50 CL';
 update public.menu_items set price=300 where name_tr='BOMONTİ FİLTRESİZ 50 CL';

 -- Rebuild exact Wix variants for named spirits.
 for itm in select id from public.menu_items where name_tr in ('Olmeca','Smirnoff Red','Absolut','Belvedere','Beefeater','Gordon''s','Campari','Baileys','Jagermeister','Grappa','Limoncello') loop
   delete from public.menu_item_variants where item_id=itm;
 end loop;
 select id into itm from public.menu_items where name_tr='Olmeca' limit 1;
 if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values (itm,'Shot (5 CL)','Shot (5 CL)','Shot (5 CL)',225,10,true),(itm,'Şişe','Bottle','Бутылка',3000,20,true); end if;
 select id into itm from public.menu_items where name_tr='Smirnoff Red' limit 1;
 if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values (itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',250,10,true),(itm,'Dubne 10 CL','Double 10 CL','Двойной 10 CL',500,20,true),(itm,'Şişe','Bottle','Бутылка',3200,30,true); end if;
 select id into itm from public.menu_items where name_tr='Absolut' limit 1;
 if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values (itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',250,10,true),(itm,'Duble 10 CL','Double 10 CL','Двойной 10 CL',500,20,true),(itm,'Şişe','Bottle','Бутылка',3200,30,true); end if;
 select id into itm from public.menu_items where name_tr='Belvedere' limit 1;
 if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values (itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',500,10,true),(itm,'Duble 10 CL','Double 10 CL','Двойной 10 CL',1000,20,true),(itm,'Şişe','Bottle','Бутылка',6000,30,true); end if;
 select id into itm from public.menu_items where name_tr='Beefeater' limit 1;
 if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values (itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',275,10,true),(itm,'Duble 10 CL','Double 10 CL','Двойной 10 CL',550,20,true),(itm,'Şişe','Bottle','Бутылка',3300,30,true); end if;
 select id into itm from public.menu_items where name_tr='Gordon''s' limit 1;
 if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values (itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',275,10,true),(itm,'Duble 10 CL','Double 10 CL','Двойной 10 CL',550,20,true),(itm,'Şişe','Bottle','Бутылка',3300,30,true); end if;
 select id into itm from public.menu_items where name_tr='Campari' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',240,10,true); end if;
 select id into itm from public.menu_items where name_tr='Baileys' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',240,10,true); end if;
 select id into itm from public.menu_items where name_tr='Jagermeister' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',280,10,true); end if;
 select id into itm from public.menu_items where name_tr='Grappa' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',240,10,true); end if;
 select id into itm from public.menu_items where name_tr='Limoncello' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Shot 5 CL','Shot 5 CL','Shot 5 CL',240,10,true); end if;

 -- Whisky: remove item not present on current Wix and rebuild exact current Wix variants.
 update public.menu_items set is_active=false where name_tr='The Glenlivet 18. Y.O. %43';
 for itm in select id from public.menu_items where name_tr in ('CHIVAS REGAL 12. Y. O','CHIVAS REGAL 18. Y. O','JOHNNIE WALKER BLACK LABEL','Bulleit Bourbon','Jack Daniels Tennessee','Jameson İrish','Glenmorangie 10 Y.O. %40','Talisker 10. Y.O. %45,8','The Macallan 12 Y.O. Sherry Oak Cask') loop
   delete from public.menu_item_variants where item_id=itm;
 end loop;
 select id into itm from public.menu_items where name_tr='CHIVAS REGAL 12. Y. O' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'SHOT','SHOT','SHOT',400,10,true),(itm,'DUBLE','DOUBLE','ДВОЙНОЙ',700,20,true),(itm,'ŞİŞE','BOTTLE','БУТЫЛКА',4100,30,true); end if;
 select id into itm from public.menu_items where name_tr='CHIVAS REGAL 18. Y. O' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'SHOT','SHOT','SHOT',600,10,true),(itm,'DUBLE','DOUBLE','ДВОЙНОЙ',1100,20,true),(itm,'ŞİŞE','BOTTLE','БУТЫЛКА',7000,30,true); end if;
 select id into itm from public.menu_items where name_tr='JOHNNIE WALKER BLACK LABEL' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'SHOT','SHOT','SHOT',350,10,true),(itm,'DUBLE','DOUBLE','ДВОЙНОЙ',650,20,true),(itm,'ŞİŞE','BOTTLE','БУТЫЛКА',3900,30,true); end if;
 select id into itm from public.menu_items where name_tr='Bulleit Bourbon' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Duble','Double','Двойной',800,10,true),(itm,'Şişe','Bottle','Бутылка',5000,20,true); end if;
 select id into itm from public.menu_items where name_tr='Jack Daniels Tennessee' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Tek','Single','Одинарный',350,10,true),(itm,'Duble','Double','Двойной',650,20,true),(itm,'Şişe','Bottle','Бутылка',3900,30,true); end if;
 select id into itm from public.menu_items where name_tr='Jameson İrish' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Tek','Single','Одинарный',350,10,true),(itm,'Duble','Double','Двойной',650,20,true),(itm,'Şişe','Bottle','Бутылка',3900,30,true); end if;
 select id into itm from public.menu_items where name_tr='Glenmorangie 10 Y.O. %40' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Tek','Single','Одинарный',400,10,true),(itm,'Duble','Double','Двойной',780,20,true),(itm,'Şişe','Bottle','Бутылка',4370,30,true); end if;
 select id into itm from public.menu_items where name_tr='Talisker 10. Y.O. %45,8' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Tek','Single','Одинарный',430,10,true),(itm,'Duble','Double','Двойной',840,20,true),(itm,'Şişe','Bottle','Бутылка',4620,30,true); end if;
 select id into itm from public.menu_items where name_tr='The Macallan 12 Y.O. Sherry Oak Cask' limit 1; if itm is not null then insert into public.menu_item_variants(item_id,label_tr,label_en,label_ru,price,sort_order,is_active) values(itm,'Tek','Single','Одинарный',1200,10,true),(itm,'Duble','Double','Двойной',1900,20,true),(itm,'Şişe','Bottle','Бутылка',12000,30,true); end if;
end $$;


-- Complete active multilingual menu text for the unified TR / EN / RU menu.
-- Safe to re-run. Does not change prices, images, ordering or Turkish source text.
update public.menu_categories set
 title_en=case slug when 'baslangic' then 'Beginning' when 'anayemek' then 'Main course' when 'soft' then 'Soft drink' when 'tatli' then 'Dessert' when 'alkollu' then 'Alcoholic beverage' when 'viski' then 'Whisky' when 'sarap' then 'Wine' else title_en end,
 title_ru=case slug when 'baslangic' then 'ХОЛОДНЫЕ ЗАКУСКИ' when 'anayemek' then 'МЯСНОЕ МЕНЮ' when 'soft' then 'БЕЗАЛКОГОЛЬНЫЕ НАПИТКИ' when 'tatli' then 'ДЕСЕРТЫ' when 'alkollu' then 'АЛКОГОЛЬНЫЕ НАПИТКИ' when 'viski' then 'ВИСКИ' when 'sarap' then 'ВИНО' else title_ru end
where slug in ('baslangic','anayemek','soft','tatli','alkollu','viski','sarap');

update public.menu_sections set
 title_en=case title_tr
  when 'Başlangıç' then 'Beginning' when 'Ara Sıcak' then 'Hot Starters' when 'Salata' then 'Salads'
  when 'Dry Aged Steaks' then 'Dry Aged Steaks' when 'BEFF' then 'BEEF' when 'Köfte' then 'Meatballs'
  when 'Burger' then 'Burgers' when 'Solo Et' then 'Solo Meat' when 'Soft İçecek' then 'Soft Drinks'
  when 'Kahve' then 'Coffee' when 'Tatlı' then 'Desserts' when 'Tekila' then 'Tequila'
  when 'Votka' then 'Vodka' when 'Cin' then 'Gin' when 'LIQUOR & VERMOUTH' then 'LIQUOR & VERMOUTH'
  when 'Bira' then 'Beer' when 'Rakı' then 'Raki' when 'Scotch Viski' then 'Scotch Whisky'
  when 'Bourbon Viski' then 'Bourbon Whisky' when 'Tennessee Viski' then 'Tennessee Whisky'
  when 'İrish Viski' then 'Irish Whisky' when 'Malt Viski' then 'Malt Whisky'
  when 'Kırmızı' then 'Red Wine' when 'Beyaz' then 'White Wine' when 'Rose' then 'Rosé'
  when 'İthal' then 'Imported Wines' when 'Köpüklü' then 'Sparkling Wine' else title_en end,
 title_ru=case title_tr
  when 'Başlangıç' then 'ХОЛОДНЫЕ ЗАКУСКИ' when 'Ara Sıcak' then 'ГОРЯЧИЕ ЗАКУСКИ' when 'Salata' then 'САЛАТЫ'
  when 'Dry Aged Steaks' then 'СТЕЙКИ СУХОЙ ВЫДЕРЖКИ' when 'BEFF' then 'ГОВЯДИНА' when 'Köfte' then 'КЁФТЕ'
  when 'Burger' then 'БУРГЕРЫ' when 'Solo Et' then 'МЯСНЫЕ НАБОРЫ' when 'Soft İçecek' then 'БЕЗАЛКОГОЛЬНЫЕ НАПИТКИ'
  when 'Kahve' then 'КОФЕ' when 'Tatlı' then 'ДЕСЕРТЫ' when 'Tekila' then 'ТЕКИЛА'
  when 'Votka' then 'ВОДКА' when 'Cin' then 'ДЖИН' when 'LIQUOR & VERMOUTH' then 'ЛИКЕРЫ И ВЕРМУТ'
  when 'Bira' then 'ПИВО' when 'Rakı' then 'РАКЫ' when 'Scotch Viski' then 'ШОТЛАНДСКИЙ ВИСКИ'
  when 'Bourbon Viski' then 'БУРБОН' when 'Tennessee Viski' then 'ТЕННЕССИЙСКИЙ ВИСКИ'
  when 'İrish Viski' then 'ИРЛАНДСКИЙ ВИСКИ' when 'Malt Viski' then 'СОЛОДОВЫЙ ВИСКИ'
  when 'Kırmızı' then 'КРАСНОЕ ВИНО' when 'Beyaz' then 'БЕЛОЕ ВИНО' when 'Rose' then 'РОЗОВОЕ ВИНО'
  when 'İthal' then 'ИМПОРТНЫЕ ВИНА' when 'Köpüklü' then 'ИГРИСТОЕ ВИНО' else title_ru end;

-- Food / soft drink / dessert names and descriptions.
update public.menu_items set name_en='Cheese Plate',name_ru='СЫРНАЯ ТАРЕЛКА',
 description_en='Served with Edam, Parmesan, smoked Circassian cheese, Gouda and Emmental. (1300–1600 calories)',
 description_ru='Сыры Эдам, Пармезан, копченый черкесский сыр, Гауда и Эмменталь. (1300–1600 калорий)' where name_tr='Peynir Tabağı';
update public.menu_items set name_en='Deli Platter',name_ru='ДЕЛИКАТЕСНАЯ ТАРЕЛКА',
 description_en='Served with Edam, Parmesan, Ezine, smoked Circassian cheese, veal cotto, smoked beef, roast beef and dried meat. (775–830 calories)',
 description_ru='Эдам, Пармезан, Эзине, копченый черкесский сыр, телятина котто, копченая говядина, ростбиф и вяленое мясо. (775–830 калорий)' where name_tr='Şarküteri Tabağı';
update public.menu_items set name_en='Veal Carpaccio',name_ru='КАРПАЧЧО ИЗ ГОВЯДИНЫ',
 description_en='Thin fillet slices marinated with Dijon mustard and fresh herbs, served with Parmesan and balsamic sauce. (150–240 calories)',
 description_ru='Тонкие ломтики филе, маринованные с дижонской горчицей и свежими специями, подаются с пармезаном и бальзамическим соусом. (150–240 калорий)' where name_tr='Dana Carpaccio';
update public.menu_items set name_en='Steak Tartare',name_ru='СТЕЙК ТАРТАР',
 description_en='Served with capers, red onion, pickles, Tabasco, Dijon mustard, egg yolk and toast. (153–285 calories)',
 description_ru='Каперсы, красный лук, соленья, соус Табаско, дижонская горчица, яичный желток и тост. (153–285 калорий)' where name_tr='Steak Tartar';
update public.menu_items set name_en='CHEDDAR SMOKED',name_ru='ЧЕДДЕР С КОПЧЕНОСТЯМИ',
 description_en='Served with smoked beef, cheddar sauce and toasted bread. (536–558 calories)',
 description_ru='Копченая говядина с соусом чеддер и обжаренным хлебом. (536–558 калорий)' where name_tr='CHEDDAR FÜME';
update public.menu_items set name_en='SPAGHETTI 200 Gr',name_ru='СПАГЕТТИ 200 гр.',
 description_en='Strip-cut fillet slices cooked in butter and served. (530–582 calories)',
 description_ru='Нарезанные полосками ломтики филе, приготовленные на сливочном масле. (530–582 калории)' where name_tr='SPAGETTİ 200 Gr';

update public.menu_items set name_en='Tomato Salad',name_ru='САЛАТ ИЗ ПОМИДОРОВ',
 description_en='Cherry tomatoes, red onion, black olives and salad dressing. (470–500 calories)',
 description_ru='Помидоры черри, красный лук, черные оливки и салатная заправка. (470–500 калорий)' where name_tr='Domates Salatası';
update public.menu_items set name_en='Rocket Salad',name_ru='САЛАТ С РУККОЛОЙ',
 description_en='Rocket, Parmesan cheese and salad dressing. (330–368 calories)',
 description_ru='Руккола, сыр пармезан и салатная заправка. (330–368 калорий)' where name_tr='Roka Salatası';
update public.menu_items set name_en='Mediterranean Salad',name_ru='СРЕДИЗЕМНОМОРСКИЙ САЛАТ',
 description_en='Seasonal greens, avocado, cherry tomatoes and salad dressing. (473–513 calories)',
 description_ru='Сезонная зелень, авокадо, помидоры черри и салатная заправка. (473–513 калорий)' where name_tr='Akdeniz Salatası';
update public.menu_items set name_en='Tulum Cheese Salad',name_ru='САЛАТ С СЫРОМ ТУЛУМ',
 description_en='Seasonal greens, cherry tomatoes, Tulum cheese, walnuts, raisins, dried apricots, pomegranate and salad dressing. (430–450 calories)',
 description_ru='Сезонная зелень, помидоры черри, сыр тулум, грецкие орехи, изюм, курага, гранат и салатная заправка. (430–450 калорий)' where name_tr='Tulum Salatası';
update public.menu_items set name_en='Steak Salad',name_ru='СТЕЙК-САЛАТ',
 description_en='Fillet slices, seasonal greens, cherry tomatoes and salad dressing. (441–481 calories)',
 description_ru='Ломтики филе, сезонная зелень, помидоры черри и салатная заправка. (441–481 калорий)' where name_tr='Steak Salata';

update public.menu_items set name_en=name_tr,name_ru=name_tr,
 description_en=replace(replace(description_tr,'brokoli','broccoli'),'karnabahar','cauliflower')
 where name_tr in ('Dallas','T-Bone','New-York','Ribeye') and description_tr is not null;
update public.menu_items set name_en='Block Fillet',name_ru='ТАКОЗ БОНФИЛЕ' where name_tr='Takoz Bonfile';
update public.menu_items set name_en='Fillet Lokum',name_ru='БОНФИЛЕ ЛОКУМ' where name_tr='Bonfile Lokum';
update public.menu_items set name_en='Shashlik',name_ru='ШАШЛЫК' where name_tr='Şaşlık';
update public.menu_items set name_en='Sliced Ribeye',name_ru='ТОНКИЙ АНТРЕКОТ' where name_tr='Yaprak Antrikot';
update public.menu_items set name_en='Lamb Chops',name_ru='БАРАНЬИ ОТБИВНЫЕ' where name_tr='Kuzu Pirzola';
update public.menu_items set name_en='Demi-Glace Fillet',name_ru='БОНФИЛЕ ДЕМИ-ГЛАС' where name_tr='Demi Glace Bonfile';
update public.menu_items set name_en='Lamb Tenderloin',name_ru='БАРАНЬЯ ВЫРЕЗКА' where name_tr='Kuzu Küşleme';
update public.menu_items set name_en='Lamb Loin (Karski)',name_ru='КАРЕ ЯГНЕНКА (КАРСКИ)' where name_tr='Kuzu Sırt (Karski)';
update public.menu_items set name_en='Lamb Rack',name_ru='КАРЕ ЯГНЕНКА' where name_tr='Kuzu Kafes';
update public.menu_items set name_en='Sliced Asado',name_ru='АСАДО ЛОМТИКАМИ' where name_tr='Dilim Asado';
update public.menu_items set name_en='File Château Beef for 4',name_ru='ФИЛЕ ШАТО НА 4 ПЕРСОНЫ' where name_tr='File Şato Beef 4 kişilik';
update public.menu_items set name_en='File Château Beef for 2',name_ru='ФИЛЕ ШАТО НА 2 ПЕРСОНЫ' where name_tr='File Şato Beef 2 kişilik';

update public.menu_items set name_en='Butcher Meatballs',name_ru='МЯСНЫЕ КОТЛЕТЫ',description_en='Served with French fries.',description_ru='Подается с картофелем фри.' where name_tr='Kasap Köfte';
update public.menu_items set name_en='Cheddar Meatballs',name_ru='КОТЛЕТЫ С ЧЕДДЕРОМ',description_en='Served with French fries.',description_ru='Подается с картофелем фри.' where name_tr='Cheddar Köfte';
update public.menu_items set name_en='Cheese Burger',name_ru='ЧИЗБУРГЕР' where name_tr='Cheese Burger';
update public.menu_items set name_en='Mexican Burger',name_ru='МЕКСИКАНСКИЙ БУРГЕР' where name_tr='Mexican Burger';
update public.menu_items set name_en='Lokum Burger',name_ru='БУРГЕР ЛОКУМ' where name_tr='Lokum Burger';
update public.menu_items set name_en='Bacon Cheese Burger',name_ru='БУРГЕР С БЕКОНОМ И ЧЕДДЕРОМ' where name_tr='Bacon Cheese Burger';
update public.menu_items set name_en='Solo 1',name_ru='СОЛО 1' where name_tr='Solo 1';
update public.menu_items set name_en='Solo 2',name_ru='СОЛО 2' where name_tr='Solo 2';

update public.menu_items set name_en='Water',name_ru='ВОДА',description_en='Water 0.75 L',description_ru='Вода 0,75 л' where name_tr='SU';
update public.menu_items set name_en='S.Pellegrino',name_ru='S.PELLEGRINO' where name_tr='S.Pellegrino';
update public.menu_items set name_en='Mineral Water',name_ru='МИНЕРАЛЬНАЯ ВОДА' where name_tr='Soda';
update public.menu_items set name_en='Turnip Juice 330 ml',name_ru='ШАЛГАМ 330 МЛ' where name_tr='Şalgam Suyu 330 ml';
update public.menu_items set name_en='Ayran',name_ru='АЙРАН' where name_tr='Ayran';
update public.menu_items set name_en='Sprite',name_ru='SPRITE' where name_tr='Sprite';
update public.menu_items set name_en='COCA COLA',name_ru='COCA COLA' where name_tr='COCA COLA';
update public.menu_items set name_en='Fanta',name_ru='FANTA' where name_tr='Fanta';
update public.menu_items set name_en='Cappy Fruit Juice',name_ru='СОК CAPPY' where name_tr='Cappy Meyve Suyu';
update public.menu_items set name_en='FUSE TEA',name_ru='FUSE TEA' where name_tr='FUSE TEA';
update public.menu_items set name_en='Red Bull',name_ru='RED BULL' where name_tr='Redbull';
update public.menu_items set name_en='Fresh Orange Juice',name_ru='СВЕЖЕВЫЖАТЫЙ АПЕЛЬСИНОВЫЙ СОК' where name_tr='Taze Portakal Suyu';
update public.menu_items set name_en='Uludağ Mineral Water',name_ru='МИНЕРАЛЬНАЯ ВОДА ULUDAĞ' where name_tr='Uludağ Soda';
update public.menu_items set name_en='Tiramisu',name_ru='ТИРАМИСУ' where name_tr='Tiramisu';
update public.menu_items set name_en='Katmer',name_ru='КАТМЕР',description_en='For 4 people',description_ru='На 4 персоны' where name_tr='Katmer';

-- Fill any still-empty translated labels for brand/product names so switching language never renders a blank field.
update public.menu_items set name_en=name_tr where nullif(btrim(name_en),'') is null;
update public.menu_items set name_ru=name_tr where nullif(btrim(name_ru),'') is null;
update public.menu_sections set title_en=title_tr where nullif(btrim(title_en),'') is null;
update public.menu_sections set title_ru=title_tr where nullif(btrim(title_ru),'') is null;
update public.menu_categories set title_en=title_tr where nullif(btrim(title_en),'') is null;
update public.menu_categories set title_ru=title_tr where nullif(btrim(title_ru),'') is null;
update public.menu_item_variants set label_en=label_tr where nullif(btrim(label_en),'') is null;
update public.menu_item_variants set label_ru=label_tr where nullif(btrim(label_ru),'') is null;


-- EXACT WIX RUSSIAN COPY from supplied Wix reference screenshots - 2026-10-04
-- Preserve Wix wording/casing/spelling exactly where visible.
update public.menu_categories set title_ru='ХОЛОДНЫЕ ЗАКУСКИ' where slug='baslangic';
update public.menu_categories set title_ru='МЯСНОЕ — ГЛАВНЫЕ БЛЮДА' where slug='anayemek';
update public.menu_categories set title_ru='БЕЗАЛКОГОЛЬНЫЕ НАПИТКИ' where slug='soft';
update public.menu_categories set title_ru='СЛАДКИЕ ДЕСЕРТЫ' where slug='tatli';

update public.menu_sections set title_ru=case title_tr
 when 'Başlangıç' then 'ХОЛОДНЫЕ ЗАКУСКИ'
 when 'Ara Sıcak' then 'ГОРЯЧИЕ БЛЮДА'
 when 'Salata' then 'САЛАТЫ'
 when 'Dry Aged Steaks' then 'DRY-AGED СТЕЙК'
 when 'BEFF' then 'бефф'
 when 'Köfte' then 'КОТЛЕТЫ'
 when 'Burger' then 'БУРГЕРЫ'
 when 'Solo Et' then 'СОЛО МЯСНЫЕ'
 when 'Soft İçecek' then 'БЕЗАЛКОГОЛЬНЫЕ НАПИТКИ'
 when 'Tatlı' then 'СЛАДКИЕ ДЕСЕРТЫ'
 else title_ru end;

update public.menu_items set name_ru='СЫРНАЯ ТАРЕЛКА',description_ru='Сыры Эдам, Пармезан, Ысыплы Черкез, Гауда, Эмменталь (1300&1650 калория)' where name_tr='Peynir Tabağı';
update public.menu_items set name_ru='ДЕЛИКАТЕСНАЯ ТАРЕЛКА',description_ru='Сыры Эдам, Пармезан, Эзине, Ысыплы Черкез'||E'\n'||'Котто из говядины, Копченая говядина, Ростбиф, Ломтики сушеного мя 775&830 калория)' where name_tr='Şarküteri Tabağı';
update public.menu_items set name_ru='КАРПАЧЧО ИЗ ГОВЯДИНЫ',description_ru='Тонкие ломтики Бон-Филе, замаринованные в Дижонской горчице и свежих специях, с сыром Пармезан и Бальзамическим соусом.(150&240 калория)' where name_tr='Dana Carpaccio';
update public.menu_items set name_ru='СТЕЙК ТАРТАР',description_ru='Каперсы, Красный лук, Соленья, Соус Табаско, Дижонская горчица, Яичные желтки, Тосты (153&285 калория)' where name_tr='Steak Tartar';
update public.menu_items set name_ru='ЧЕДДЕР С КОПЧЕНОСТЯМИ',description_ru='Копченая говядина с соусом Чеддер на обжаренных тостах (536&558 калория)' where name_tr='CHEDDAR FÜME';
update public.menu_items set name_ru='СПАГЕТТИ 200 гр.',description_ru='СПАГЕТТИ 200 гр (530&582 калория)' where name_tr='SPAGETTİ 200 Gr';

update public.menu_items set name_ru='САЛАТ ИЗ ПОМИДОРОВ',description_ru='Помидоры Черри, красный лук, черные оливки и салатный соус (1600&1625 калория)' where name_tr='Domates Salatası';
update public.menu_items set name_ru='САЛАТ РОКА',description_ru='Рока, Пармезан и салатный соус (330&368 калория)' where name_tr='Roka Salatası';
update public.menu_items set name_ru='СРЕДИЗЕМНОМОРСКИЙ САЛАТ',description_ru='Сезонная зелень, авокадо, помидоры Черри и салатный соус(473&513 калория)' where name_tr='Akdeniz Salatası';
update public.menu_items set name_ru='САЛАТ ТУЛУМ',description_ru='Сезонная зелень, помидоры Черри, сыр Тулум, орехи, виноград, абрикосы, гранат и салатный соус 430&450 калория)' where name_tr='Tulum Salatası';
update public.menu_items set name_ru='СТЕЙК-САЛАТ',description_ru='Ломтики Бон-Филе, сезонная зелень, помидоры Черри и салатный соус (441&481 калория)' where name_tr='Steak Salata';

update public.menu_items set name_ru='ДАЛЛАС',description_ru='ДАЛЛАС 450-500 гр (1100-1400 калория) , Подается с брокколи, цветной капустой и морковью.(123 калория)' where name_tr='Dallas';
update public.menu_items set name_ru='ТИ-БОУН',description_ru='ТИ-БОУН 450-500 гр (1200-1500 калория) , Подается с брокколи, цветной капустой и морковью.(123 калория)' where name_tr='T-Bone';
update public.menu_items set name_ru='НЬЮ-ЙОРК',description_ru='НЬЮ-ЙОРК 350-400 гр (1000-1300 калория), Подается с брокколи, цветной капустой и морковью.(123 калория)' where name_tr='New-York';
update public.menu_items set name_ru='РИБАЙ',description_ru='РИБАЙ 350 гр (900-1100 калория) , Подается с брокколи, цветной капустой и морковью.(123 калория)' where name_tr='Ribeye';
update public.menu_items set name_ru='ТАКОЗ БОНФИЛЕ /',description_ru='Широкая нарезка Бон-Филе (250 гр)(550-700 калория)' where name_tr='Takoz Bonfile';
update public.menu_items set name_ru='БОН-ФИЛЕ ЛОКУМ /',description_ru='Тонкая нарезка Бон-Филе (220 гр)(450-600 калория)' where name_tr='Bonfile Lokum';
update public.menu_items set name_ru='ШАШЛЫК',description_ru='ШАШЛЫК (300 гр)(750-950 калория)' where name_tr='Şaşlık';
update public.menu_items set name_ru='ТОНКО НАРЕЗАННЫЙ АНТРЕКОТ',description_ru='ТОНКО НАРЕЗАННЫЙ АНТРЕКОТ (300 гр)(850-1100 калория)' where name_tr='Yaprak Antrikot';
update public.menu_items set name_ru='БАРАНЬИ ОТБИВНЫЕ',description_ru='БАРАНЬИ ОТБИВНЫЕ (250 гр) (650-850 калория)' where name_tr='Kuzu Pirzola';
update public.menu_items set name_ru='БОН-ФИЛЕ В СОУСЕ ДЕМИГЛАС',description_ru='БОН-ФИЛЕ В СОУСЕ ДЕМИГЛАС (220 гр)(550-750 калория)' where name_tr='Demi Glace Bonfile';
update public.menu_items set name_ru='ФИЛЕ БАРАНИНЫ ТЕНДЕРЛОЙН',description_ru='ФИЛЕ БАРАНИНЫ ТЕНДЕРЛОЙН (220 гр)(600-800 калория)' where name_tr='Kuzu Küşleme';
update public.menu_items set name_ru='ФИЛЕ БАРАНИНЫ ПО КАРСКИ',description_ru='ФИЛЕ БАРАНИНЫ ПО КАРСКИ (250 гр)' where name_tr='Kuzu Sırt (Karski)';
update public.menu_items set name_ru='БАРАНЬЯ КОРЕЙКА НА КОСТИ',description_ru='БАРАНЬЯ КОРЕЙКА НА КОСТИ (1,3 кг)(3500-4500 калория)' where name_tr='Kuzu Kafes';
update public.menu_items set name_ru='дана ребра',description_ru='дана ребра (по резервации)' where name_tr='Dilim Asado';
update public.menu_items set name_ru='ФИЛЕШАТОБРИАН ГОВЯДИНА' where name_tr='File Şato Beef 4 kişilik';
update public.menu_items set name_ru='ФИЛЕШАТОБРИАН ГОВЯДИНА Корузасы' where name_tr='File Şato Beef 2 kişilik';

update public.menu_items set name_ru='КОТЛЕТЫ КЛАССИЧЕСКИЕ',description_ru='Kızarmış Patates İle Servis edilir.(900-1100 калория)' where name_tr='Kasap Köfte';
update public.menu_items set name_ru='КОТЛЕТЫ С СЫРОМ ЧЕДДЕР',description_ru='Kızarmış Patates İle Servis edilir. (1100-1300 калория)' where name_tr='Cheddar Köfte';
update public.menu_items set name_ru='ЧИЗБУРГЕР',description_ru='ЧИЗБУРГЕР (180 гр)'||E'\n'||'Котлета для бургеров, сыр Чеддер, соус Дип, помидоры, маринованные огурцы (1000-1200 калория)' where name_tr='Cheese Burger';
update public.menu_items set name_ru='МЕКСИКАНСКИЙ БУРГЕР',description_ru='МЕКСИКАНСКИЙ БУРГЕР (180 гр)'||E'\n'||'Котлета для бургеров, сыр Чеддер, перец Халапеньо, острый Мексиканский соус, помидоры, маринованные огурцы (1100-1300 калория)' where name_tr='Mexican Burger';
update public.menu_items set name_ru='БУРГЕР ИЗ СТЕЙКА ГОВЯДИНЫ',description_ru='БУРГЕР ИЗ СТЕЙКА ГОВЯДИНЫ (150 гр)'||E'\n'||'Тонко нарезанные ломтики стейка говядины, соус Дип, помидоры, маринованные огурцы (900-1100 калория)' where name_tr='Lokum Burger';
update public.menu_items set name_ru='БЕКОН ЧИЗБУРГЕР',description_ru='БЕКОН ЧИЗБУРГЕР (180 гр)'||E'\n'||'Котлета для бургеров, сыр Чеддер, говяжий бекон, соус Дип, помидоры, маринованные огурцы (1200-1400 калория)' where name_tr='Bacon Cheese Burger';
update public.menu_items set name_ru='СОЛО 1',description_ru='1 Тонко нарезанный стейк'||E'\n'||'1 Котлета с сыром Чеддер'||E'\n'||'1 Баранья Корейка'||E'\n'||'1 Колбаска Суджук (1500-1800 калория)' where name_tr='Solo 1';
update public.menu_items set name_ru='СОЛО 2',description_ru='1 Говяжий антрекот без кости'||E'\n'||'1 Филе-Тендерлойн'||E'\n'||'1 Классическая котлета (1600-2000 калория)' where name_tr='Solo 2';

update public.menu_items set name_ru='ВОДА',description_ru='ВОДА 0,75 МЛ' where name_tr='SU';
update public.menu_items set name_ru='St.Pellegrino',description_ru='МИНЕРАЛЬНАЯ ВОДА ST.PELLEGRINO (750 мл)' where name_tr='S.Pellegrino';
update public.menu_items set name_ru='ГАЗИРОВАННАЯ ВОДА',description_ru='ГАЗИРОВАННАЯ ВОДА' where name_tr='Soda';
update public.menu_items set name_ru='ШАЛГАМ 330 ML',description_ru='ШАЛГАМ 1 LT - 220 TL'||E'\n'||'ШАЛГАМ (острый напиток из красной репы)' where name_tr='Şalgam Suyu 330 ml';
update public.menu_items set name_ru='АЙРАН',description_ru='АЙРАН' where name_tr='Ayran';
update public.menu_items set name_ru='COCA COLA',description_ru='CocaCola / Light / Zero' where name_tr='COCA COLA';
update public.menu_items set name_ru='Sprite',description_ru='Sprite' where name_tr='Sprite';
update public.menu_items set name_ru='Fanta',description_ru='Fanta' where name_tr='Fanta';
update public.menu_items set name_ru='CAPPY ФРУКТОВЫЕ НАПИТКИ',description_ru='CAPPY ФРУКТОВЫЕ НАПИТКИ, Вишня, Персик' where name_tr='Cappy Meyve Suyu';
update public.menu_items set name_ru='FUSE ЧАЙ',description_ru='FUSE ЧАЙ (лимон/персик)' where name_tr='FUSE TEA';
update public.menu_items set name_ru='Redbull',description_ru='Redbull' where name_tr='Redbull';
update public.menu_items set name_ru='СВЕЖЕВЫЖАТЫЙ АПЕЛЬСИНОВЫЙ СОК',description_ru='СВЕЖЕВЫЖАТЫЙ АПЕЛЬСИНОВЫЙ СОК' where name_tr='Taze Portakal Suyu';
update public.menu_items set name_ru='Uludağ сода',description_ru='сода' where name_tr='Uludağ Soda';

update public.menu_items set name_ru='ТИРАМИСУ',description_ru='ТИРАМИСУ (390 калория)' where name_tr='Tiramisu';
update public.menu_items set name_ru='Katmer',description_ru='4 person (1800 калория)' where name_tr='Katmer';
