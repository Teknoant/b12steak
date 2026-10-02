-- B12 Steak live Wix menu correction/additions - 2026-10-02
-- Re-runnable where practical. Adds missing alcoholic sections/items and corrects known variants.
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
    ('EFES PİLSEN 50 CL','EFES PİLSEN','EFES PILSEN',290::numeric,20),
    ('EFES MALT 50 CL','EFES MALT','EFES MALT',290::numeric,30),
    ('BOMONTİ FİLTRESİZ 50 CL','BOMONTİ FİLTRESİZ','BOMONTI UNFILTERED',300::numeric,40),
    ('CORONA 35,5 CL','Corona','Corona',390::numeric,50)
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
