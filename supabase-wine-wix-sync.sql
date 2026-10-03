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
