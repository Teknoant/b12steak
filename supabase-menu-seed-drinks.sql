-- B12 Steak verified alcoholic + whisky + wine seed (snapshot 2026-10-01)
begin;
delete from public.menu_sections where category_id in (select id from public.menu_categories where slug in ('alkollu','viski','sarap'));
insert into public.menu_sections(category_id,title_tr,title_en,sort_order) values
((select id from public.menu_categories where slug='alkollu'),'Tekila','Tequila',10),
((select id from public.menu_categories where slug='alkollu'),'Votka','Vodka',20),
((select id from public.menu_categories where slug='alkollu'),'Cin','Gin',30),
((select id from public.menu_categories where slug='alkollu'),'LIQUOR & VERMOUTH','LIQUOR & VERMOUTH',40),
((select id from public.menu_categories where slug='viski'),'Scotch Viski','Scotch Whiskey',10),
((select id from public.menu_categories where slug='viski'),'Bourbon Viski','Bourbon Whiskey',20),
((select id from public.menu_categories where slug='viski'),'Tennessee Viski','Tennessee Whiskey',30),
((select id from public.menu_categories where slug='viski'),'İrish Viski','Irish Whiskey',40),
((select id from public.menu_categories where slug='viski'),'Malt Viski','Malt Whiskey',50),
((select id from public.menu_categories where slug='sarap'),'Kırmızı','Red',10),
((select id from public.menu_categories where slug='sarap'),'Beyaz','White',20),
((select id from public.menu_categories where slug='sarap'),'Rose','Rosé',30),
((select id from public.menu_categories where slug='sarap'),'İthal','Imported',40);

-- Items with variants use base price 0; display should use variants.
insert into public.menu_items(section_id,name_tr,description_tr,price,sort_order) values
((select id from public.menu_sections where title_tr='Tekila'),'Olmeca',null,0,10),
((select id from public.menu_sections where title_tr='Votka'),'Smirnoff Red',null,0,10),
((select id from public.menu_sections where title_tr='Votka'),'Absolut',null,0,20),
((select id from public.menu_sections where title_tr='Votka'),'Belvedere',null,0,30),
((select id from public.menu_sections where title_tr='Cin'),'Beefeater',null,0,10),
((select id from public.menu_sections where title_tr='Cin'),'Gordon''s',null,0,20),
((select id from public.menu_sections where title_tr='LIQUOR & VERMOUTH'),'Campari',null,0,10),
((select id from public.menu_sections where title_tr='LIQUOR & VERMOUTH'),'Baileys',null,0,20),
((select id from public.menu_sections where title_tr='Scotch Viski'),'CHIVAS REGAL 12. Y. O',null,0,10),
((select id from public.menu_sections where title_tr='Scotch Viski'),'CHIVAS REGAL 18. Y. O',null,0,20),
((select id from public.menu_sections where title_tr='Scotch Viski'),'JOHNNIE WALKER BLACK LABEL',null,0,30),
((select id from public.menu_sections where title_tr='Bourbon Viski'),'Bulleit Bourbon',null,0,10),
((select id from public.menu_sections where title_tr='Tennessee Viski'),'Jack Daniels Tennessee',null,0,10),
((select id from public.menu_sections where title_tr='İrish Viski'),'Jameson İrish',null,0,10),
((select id from public.menu_sections where title_tr='Malt Viski'),'Glenmorangie 10 Y.O. %40','İskoçya/Highland (Tain Bölgesi) 1843 yılından bu yana Faaliyette Olan Vanilya, Tarçın ve Limon Kabuğu Aromaları Hissedildiği Tek Malt Viskisi',0,10),
((select id from public.menu_sections where title_tr='Malt Viski'),'Talisker 10. Y.O. %45,8','İskoçya/Sky Adası Ekşi elma, Bol İyot (Tuz), İstiridye Rayihalarının Hissedildiği Tek Malt Viskisi.',0,20),
((select id from public.menu_sections where title_tr='Malt Viski'),'The Glenlivet 18. Y.O. %43',null,0,30),
((select id from public.menu_sections where title_tr='Malt Viski'),'The Macallan 12 Y.O. Sherry Oak Cask',null,0,40);

-- Alcohol/whisky variants verified from current indexed menu.
insert into public.menu_item_variants(item_id,label_tr,label_en,price,sort_order)
select id,'Shot (5 CL)','Shot 5 CL',275,10 from public.menu_items where name_tr='Olmeca'
union all select id,'Şişe','Bottle',3500,30 from public.menu_items where name_tr='Olmeca'
union all select id,'Shot 5 CL','Shot 5 CL',250,10 from public.menu_items where name_tr='Smirnoff Red'
union all select id,'Duble 10 CL','Double 10 CL',500,20 from public.menu_items where name_tr='Smirnoff Red'
union all select id,'Şişe','Bottle',3200,30 from public.menu_items where name_tr='Smirnoff Red'
union all select id,'Shot 5 CL','Shot 5 CL',250,10 from public.menu_items where name_tr='Absolut'
union all select id,'Duble 10 CL','Double 10 CL',500,20 from public.menu_items where name_tr='Absolut'
union all select id,'Şişe','Bottle',3200,30 from public.menu_items where name_tr='Absolut'
union all select id,'Shot 5 CL','Shot 5 CL',700,10 from public.menu_items where name_tr='Belvedere'
union all select id,'Duble 10 CL','Double 10 CL',1200,20 from public.menu_items where name_tr='Belvedere'
union all select id,'Şişe','Bottle',7000,30 from public.menu_items where name_tr='Belvedere'
union all select id,'Shot 5 CL','Shot 5 CL',300,10 from public.menu_items where name_tr='Beefeater'
union all select id,'Duble 10 CL','Double 10 CL',600,20 from public.menu_items where name_tr='Beefeater'
union all select id,'Şişe','Bottle',3600,30 from public.menu_items where name_tr='Beefeater'
union all select id,'Shot 5 CL','Shot 5 CL',275,10 from public.menu_items where name_tr='Gordon''s'
union all select id,'Duble 10 CL','Double 10 CL',550,20 from public.menu_items where name_tr='Gordon''s'
union all select id,'Şişe','Bottle',3300,30 from public.menu_items where name_tr='Gordon''s'
union all select id,'Shot 5 CL','Shot 5 CL',240,10 from public.menu_items where name_tr='Campari'
union all select id,'Tek','Shot 5 CL',400,10 from public.menu_items where name_tr='CHIVAS REGAL 12. Y. O'
union all select id,'Duble','Double 10 CL',700,20 from public.menu_items where name_tr='CHIVAS REGAL 12. Y. O'
union all select id,'Şişe','Bottle',4600,30 from public.menu_items where name_tr='CHIVAS REGAL 12. Y. O'
union all select id,'Tek','Shot 5 CL',650,10 from public.menu_items where name_tr='CHIVAS REGAL 18. Y. O'
union all select id,'Duble','Double 10 CL',1300,20 from public.menu_items where name_tr='CHIVAS REGAL 18. Y. O'
union all select id,'Şişe','Bottle',8500,30 from public.menu_items where name_tr='CHIVAS REGAL 18. Y. O'
union all select id,'Tek','Shot 5 CL',350,10 from public.menu_items where name_tr='JOHNNIE WALKER BLACK LABEL'
union all select id,'Duble','Double 10 CL',650,20 from public.menu_items where name_tr='JOHNNIE WALKER BLACK LABEL'
union all select id,'Şişe','Bottle',4400,30 from public.menu_items where name_tr='JOHNNIE WALKER BLACK LABEL'
union all select id,'Tek','Shot 5 CL',435,10 from public.menu_items where name_tr='Bulleit Bourbon'
union all select id,'Duble','Double 10 CL',800,20 from public.menu_items where name_tr='Bulleit Bourbon'
union all select id,'Şişe','Bottle',5000,30 from public.menu_items where name_tr='Bulleit Bourbon'
union all select id,'Tek','Shot 5 CL',350,10 from public.menu_items where name_tr='Jack Daniels Tennessee'
union all select id,'Duble','Double 10 CL',650,20 from public.menu_items where name_tr='Jack Daniels Tennessee'
union all select id,'Şişe','Bottle',3900,30 from public.menu_items where name_tr='Jack Daniels Tennessee'
union all select id,'Tek','Shot 5 CL',400,10 from public.menu_items where name_tr='Jameson İrish'
union all select id,'Duble','Double 10 CL',700,20 from public.menu_items where name_tr='Jameson İrish'
union all select id,'Şişe','Bottle',3900,30 from public.menu_items where name_tr='Jameson İrish'
union all select id,'Tek','Shot 5 CL',400,10 from public.menu_items where name_tr='Glenmorangie 10 Y.O. %40'
union all select id,'Duble','Double 10 CL',780,20 from public.menu_items where name_tr='Glenmorangie 10 Y.O. %40'
union all select id,'Şişe','Bottle',4370,30 from public.menu_items where name_tr='Glenmorangie 10 Y.O. %40'
union all select id,'Tek','Shot 5 CL',430,10 from public.menu_items where name_tr='Talisker 10. Y.O. %45,8'
union all select id,'Duble','Double 10 CL',840,20 from public.menu_items where name_tr='Talisker 10. Y.O. %45,8'
union all select id,'Şişe','Bottle',6800,30 from public.menu_items where name_tr='Talisker 10. Y.O. %45,8'
union all select id,'Tek','Shot 5 CL',575,10 from public.menu_items where name_tr='The Glenlivet 18. Y.O. %43'
union all select id,'Duble','Double 10 CL',1030,20 from public.menu_items where name_tr='The Glenlivet 18. Y.O. %43'
union all select id,'Şişe','Bottle',9500,30 from public.menu_items where name_tr='The Glenlivet 18. Y.O. %43'
union all select id,'Tek','Shot 5 CL',800,10 from public.menu_items where name_tr='The Macallan 12 Y.O. Sherry Oak Cask'
union all select id,'Duble','Double 10 CL',1350,20 from public.menu_items where name_tr='The Macallan 12 Y.O. Sherry Oak Cask'
union all select id,'Şişe','Bottle',8750,30 from public.menu_items where name_tr='The Macallan 12 Y.O. Sherry Oak Cask';

-- Wines
insert into public.menu_items(section_id,name_tr,description_tr,price,sort_order) values
((select id from public.menu_sections where title_tr='Kırmızı'),'Suvla / Cabarnet Sauvignon-Merlot',null,1850,10),
((select id from public.menu_sections where title_tr='Kırmızı'),'Suvla / ÖküzGözü/Boğazkere',null,1750,20),
((select id from public.menu_sections where title_tr='Kırmızı'),'Kavaklıdere / Egeo Merlot',null,3900,30),
((select id from public.menu_sections where title_tr='Kırmızı'),'Kavaklıdere / Egeo Cabernet Sauvignon',null,3900,40),
((select id from public.menu_sections where title_tr='Kırmızı'),'Kavaklıdere / Egeo Syrah',null,3700,50),
((select id from public.menu_sections where title_tr='Kırmızı'),'Kavaklıdere / Prestige Kalecik Karası',null,4900,60),
((select id from public.menu_sections where title_tr='Kırmızı'),'Selection / Öküzgözü-Bogazkere',null,3800,70),
((select id from public.menu_sections where title_tr='Kırmızı'),'Kavaklıdere / Pendore Syrah',null,4900,80),
((select id from public.menu_sections where title_tr='Kırmızı'),'Oguz Vigna Nord','MERLOT/CALROSSO',2500,90),
((select id from public.menu_sections where title_tr='Kırmızı'),'Consensus / Shiraz & Cabernet Sauvignon & Merlot',null,3500,100),
((select id from public.menu_sections where title_tr='Kırmızı'),'Ament Blend',null,3750,110),
((select id from public.menu_sections where title_tr='Kırmızı'),'Kavaklıdere / Ancyra Öküzgözü',null,1800,120),
((select id from public.menu_sections where title_tr='Kırmızı'),'Kavaklıdere / Ancyra Merlot',null,1800,130),
((select id from public.menu_sections where title_tr='Kırmızı'),'Yedi Bilgeler Pythgoras','Cabarnet Sauvignon Cabarnet Franc Merlot Petit Verdot',3400,140),
((select id from public.menu_sections where title_tr='Kırmızı'),'Chamlıja Nevi Şahsına Münasır',null,3900,150),
((select id from public.menu_sections where title_tr='Beyaz'),'Suvla / Chardonnay',null,3050,10),
((select id from public.menu_sections where title_tr='Beyaz'),'Kavaklıdere / Selection, Emir& Narince',null,3500,20),
((select id from public.menu_sections where title_tr='Beyaz'),'Kavaklıdere / Misket',null,2900,30),
((select id from public.menu_sections where title_tr='Beyaz'),'Kavaklıdere / Sultaniye Y.Tatlı',null,1900,40),
((select id from public.menu_sections where title_tr='Beyaz'),'Kavaklıdere / Ancyra Narince',null,1800,50),
((select id from public.menu_sections where title_tr='Beyaz'),'Suvla Sauvignon Blanc & Semıllon',null,1850,60),
((select id from public.menu_sections where title_tr='Beyaz'),'Marchesi Dı Barolo & Gavı Dı Gavı','Cortese',3900,70),
((select id from public.menu_sections where title_tr='Beyaz'),'Tomassi Soave Classico','Garganega',2700,80),
((select id from public.menu_sections where title_tr='Beyaz'),'Chablis Le Finage AOC','Chardonnay',4100,90),
((select id from public.menu_sections where title_tr='Beyaz'),'Roc De I''Abbaye Sancerre Blanc','Sauvignon Blanc',3900,100),
((select id from public.menu_sections where title_tr='Beyaz'),'Yedi Bilgeler Khilon','Sauvignon Blanc',2600,110),
((select id from public.menu_sections where title_tr='Beyaz'),'Yedi Bilgeler Anaxagoras','Chardonnay',2600,120),
((select id from public.menu_sections where title_tr='Beyaz'),'Chamlıja Quartz Füme','Sauvignon Blanc',3750,130),
((select id from public.menu_sections where title_tr='Rose'),'Sartori Pinot Grigio',null,2050,10),
((select id from public.menu_sections where title_tr='Rose'),'Kavaklıdere / Ancyra Blush',null,1800,20),
((select id from public.menu_sections where title_tr='Rose'),'Bodvar Cotes De Pronence','Grenache, Cinsault ve Rolle (Vermentino)',3150,30),
((select id from public.menu_sections where title_tr='İthal'),'Arjantin / Kaiken Reserva Malbec',null,2800,10);

insert into public.menu_item_variants(item_id,label_tr,label_en,price,sort_order)
select id,'Kadeh','Glass',380,10 from public.menu_items where name_tr='Suvla / ÖküzGözü/Boğazkere'
union all select id,'Kadeh','Glass',380,10 from public.menu_items where name_tr='Kavaklıdere / Ancyra Narince'
union all select id,'Kadeh','Glass',380,10 from public.menu_items where name_tr='Kavaklıdere / Ancyra Blush';
commit;