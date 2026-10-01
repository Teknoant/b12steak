-- B12 Steak verified food/soft/dessert seed. Re-runnable.
-- Source snapshot verified 2026-10-01 from current Wix menu.
begin;

delete from public.menu_sections where category_id in (select id from public.menu_categories where slug in ('baslangic','anayemek','soft','tatli'));

insert into public.menu_sections(category_id,title_tr,title_en,sort_order) values
((select id from public.menu_categories where slug='baslangic'),'Başlangıç','Starter',10),
((select id from public.menu_categories where slug='baslangic'),'Ara Sıcak','Hot Starter',20),
((select id from public.menu_categories where slug='baslangic'),'Salata','Salad',30),
((select id from public.menu_categories where slug='anayemek'),'Dry Aged Steaks','Dry Aged Steaks',10),
((select id from public.menu_categories where slug='anayemek'),'BEFF','BEEF',20),
((select id from public.menu_categories where slug='anayemek'),'Köfte','Meatballs',30),
((select id from public.menu_categories where slug='anayemek'),'Burger','Burger',40),
((select id from public.menu_categories where slug='anayemek'),'Solo Et','Solo Meat',50),
((select id from public.menu_categories where slug='soft'),'Soft İçecek','Soft Drinks',10),
((select id from public.menu_categories where slug='soft'),'Kahve','Coffee',20),
((select id from public.menu_categories where slug='tatli'),'Tatlı','Dessert',10);

insert into public.menu_items(section_id,name_tr,description_tr,price,tags,sort_order) values
((select id from public.menu_sections where title_tr='Başlangıç' and category_id=(select id from public.menu_categories where slug='baslangic')),'Peynir Tabağı','Edam, Permasan, İsli Çerkez Peyniri, Gouda Emmantel ile servis edilmektedir (1300 ila 1600 kalori)',880,'{}',10),
((select id from public.menu_sections where title_tr='Başlangıç' and category_id=(select id from public.menu_categories where slug='baslangic')),'Şarküteri Tabağı','Edam, Permasan, Ezine, İsli Çerkez, dana Catto, Dana Füme, Rosebeef ve kuru et ile servis edilmektedir (775 ila 830 kalori)',1260,'{}',20),
((select id from public.menu_sections where title_tr='Başlangıç' and category_id=(select id from public.menu_categories where slug='baslangic')),'Dana Carpaccio','Dijon Hardal ve taze baharatlar ile marine edilmiş ince bonfile, Permasan ve Balzemik sos ile servis edilmektedir (150 ila 240 kalori)',1030,'{}',30),
((select id from public.menu_sections where title_tr='Başlangıç' and category_id=(select id from public.menu_categories where slug='baslangic')),'Steak Tartar','Kapari çiçeği, kırmızı soğan, turşu, Tabasco, Dijon Hardal, yumurta sarısı ve kızarmış ekmek ile servis edilmektedir (153 ila 285 kalori)',1100,'{}',40),
((select id from public.menu_sections where title_tr='Ara Sıcak' and category_id=(select id from public.menu_categories where slug='baslangic')),'CHEDDAR FÜME','Dana Füme, Cheddar sos ve kızarmış ekmek ile servis edilmektedir (536 ila 558 kalori)',850,'{}',10),
((select id from public.menu_sections where title_tr='Ara Sıcak' and category_id=(select id from public.menu_categories where slug='baslangic')),'SPAGETTİ 200 Gr','Şerit kesilmiş bonfile dilimleri tereyağında pişirilerek servis edilmektedir (530 ila 582 kalori)',990,'{}',20),
((select id from public.menu_sections where title_tr='Salata' and category_id=(select id from public.menu_categories where slug='baslangic')),'Domates Salatası','Cherry domates, kırmızı soğan, siyah zeytin ve salata sosu ile servis edilmektedir (470 ila 500 kalori)',450,ARRAY['Vejetaryen','Organik','Vegan'],10),
((select id from public.menu_sections where title_tr='Salata' and category_id=(select id from public.menu_categories where slug='baslangic')),'Roka Salatası','Roka, Permesan peyniri ve salata sosu ile servis edilmektedir (330 ila 368 kalori)',450,ARRAY['Vejetaryen','Organik'],20),
((select id from public.menu_sections where title_tr='Salata' and category_id=(select id from public.menu_categories where slug='baslangic')),'Akdeniz Salatası','Mevsim yeşillikleri, avokado, cherry domates ve salata sosu ile servis edilmektedir (473 ila 513 kalori)',500,ARRAY['Vejetaryen','Organik','Vegan'],30),
((select id from public.menu_sections where title_tr='Salata' and category_id=(select id from public.menu_categories where slug='baslangic')),'Tulum Salatası','Mevsim yeşillikleri, cherry domates, tulum peyniri, ceviz, kuru üzüm, kuru kayısı, nar ve salata sosu ile servis edilmektedir (430 ila 450 kalori)',550,ARRAY['Vejetaryen','Organik'],40),
((select id from public.menu_sections where title_tr='Salata' and category_id=(select id from public.menu_categories where slug='baslangic')),'Steak Salata','Bonfile dilimleri, mevsim yeşillikleri, cherry domates ve salata sosu ile servis edilmektedir (441 ila 481 kalori)',880,'{}',50),
((select id from public.menu_sections where title_tr='Dry Aged Steaks'),'Dallas','Dallas 450-500 Gr; brokoli, karnabahar ve havuç ile servis edilir.',2200,'{}',10),
((select id from public.menu_sections where title_tr='Dry Aged Steaks'),'T-Bone','T-Bone 450-500 Gr; brokoli, karnabahar ve havuç ile servis edilir.',2200,'{}',20),
((select id from public.menu_sections where title_tr='Dry Aged Steaks'),'New-York','New-York 350-400 Gr; brokoli, karnabahar ve havuç ile servis edilir.',1800,'{}',30),
((select id from public.menu_sections where title_tr='Dry Aged Steaks'),'Ribeye','Ribeye 350 Gr; brokoli, karnabahar ve havuç ile servis edilir.',1850,'{}',40),
((select id from public.menu_sections where title_tr='BEFF'),'Takoz Bonfile','Takoz Bonfile 250 Gr; haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',1800,'{}',10),
((select id from public.menu_sections where title_tr='BEFF'),'Bonfile Lokum','Bonfile Lokum 220 Gr; haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',1600,'{}',20),
((select id from public.menu_sections where title_tr='BEFF'),'Şaşlık','Şaşlık 300 Gr (3 şiş); haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',1700,'{}',30),
((select id from public.menu_sections where title_tr='BEFF'),'Yaprak Antrikot','Yaprak Antrikot 300 Gr; haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',1600,'{}',40),
((select id from public.menu_sections where title_tr='BEFF'),'Kuzu Pirzola','Kuzu Pirzola 250 Gr; haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',1400,'{}',50),
((select id from public.menu_sections where title_tr='BEFF'),'Demi Glace Bonfile','Demi Glace Bonfile 220 Gr; haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',1600,'{}',60),
((select id from public.menu_sections where title_tr='BEFF'),'Kuzu Küşleme','Kuzu Küşleme 220 Gr; haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',1400,'{}',70),
((select id from public.menu_sections where title_tr='BEFF'),'Kuzu Sırt (Karski)','Kuzu Sırt (Karski) 250 Gr; haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',1450,'{}',80),
((select id from public.menu_sections where title_tr='BEFF'),'Kuzu Kafes','Kuzu Kafes 1.3 KG; haşlanmış brokoli, karnabahar ve havuç ile servis edilmektedir.',4800,'{}',90),
((select id from public.menu_sections where title_tr='BEFF'),'Dilim Asado','Ön sipariş alınarak servis edilir.',2150,'{}',100),
((select id from public.menu_sections where title_tr='BEFF'),'File Şato Beef 4 kişilik',null,6000,'{}',110),
((select id from public.menu_sections where title_tr='BEFF'),'File Şato Beef 2 kişilik',null,3500,'{}',120),
((select id from public.menu_sections where title_tr='Köfte'),'Kasap Köfte','Kızarmış patates ile servis edilmektedir.',750,'{}',10),
((select id from public.menu_sections where title_tr='Köfte'),'Cheddar Köfte','Kızarmış patates ile servis edilmektedir.',900,'{}',20),
((select id from public.menu_sections where title_tr='Burger'),'Cheese Burger','180 Gr burger köftesi, kızarmış patates ile servis edilmektedir.',720,'{}',10),
((select id from public.menu_sections where title_tr='Burger'),'Mexican Burger','180 Gr burger köftesi, Cheddar peyniri, jalapeno biberi, iceberg ve kızarmış patates ile servis edilmektedir.',720,ARRAY['Ekstra Acılı'],20),
((select id from public.menu_sections where title_tr='Burger'),'Lokum Burger','150 Gr ince dilimlenmiş bonfile, dip sos, turşu, iceberg ve kızarmış patates ile servis edilmektedir.',950,'{}',30),
((select id from public.menu_sections where title_tr='Burger'),'Bacon Cheese Burger','180 Gr burger köftesi, Cheddar peyniri, dana bacon, dip sos, turşu, domates, iceberg ve kızarmış patates ile servis edilmektedir.',770,'{}',40),
((select id from public.menu_sections where title_tr='Solo Et'),'Solo 1','1 Ad. Lokum, 1 Ad. Cheddar Köfte, 1 Ad. Kuzu Pirzola, 1 Ad. Sucuk; sebzeler ile servis edilmektedir.',1300,'{}',10),
((select id from public.menu_sections where title_tr='Solo Et'),'Solo 2','1 Ad. Yaprak Antrikot, 1 Ad. Küşleme, 1 Ad. Kasap Köfte; sebzeler ile servis edilmektedir.',1400,'{}',20),
((select id from public.menu_sections where title_tr='Soft İçecek'),'SU','SU 0,75 ML',80,'{}',10),
((select id from public.menu_sections where title_tr='Soft İçecek'),'S.Pellegrino','St.Pellegrino 750ML',380,'{}',20),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Soda','Soda',80,'{}',30),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Şalgam Suyu 330 ml','Şalgam Suyu 1 LT - 220 TL',80,'{}',40),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Ayran','Ayran',90,'{}',50),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Sprite','Sprite',125,'{}',60),
((select id from public.menu_sections where title_tr='Soft İçecek'),'COCA COLA','CocaCola / Light / Zero',125,'{}',70),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Fanta','Fanta',125,'{}',80),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Cappy Meyve Suyu','Vişne, Şeftali',130,'{}',90),
((select id from public.menu_sections where title_tr='Soft İçecek'),'FUSE TEA','Limon / Şeftali',130,'{}',100),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Redbull','Redbull',190,'{}',110),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Taze Portakal Suyu','Taze Portakal Suyu',190,'{}',120),
((select id from public.menu_sections where title_tr='Soft İçecek'),'Uludağ Soda','250ML',90,'{}',130),
((select id from public.menu_sections where title_tr='Tatlı'),'Tiramisu','Tiramisu',310,'{}',10),
((select id from public.menu_sections where title_tr='Tatlı'),'Katmer','4 kişilik',950,'{}',20);

-- Uludağ Soda second size
insert into public.menu_item_variants(item_id,label_tr,label_en,price,sort_order)
select id,'750ML','750ML',195,20 from public.menu_items where name_tr='Uludağ Soda';
commit;
