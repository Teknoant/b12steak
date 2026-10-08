-- B12 Steak: restore original TR descriptions and calorie ranges from supplied menu screenshots (2026-10-08).
-- Safe/idempotent: updates descriptions only; prices, images, names, variants, ordering untouched.
-- Applies only to Ana Yemek and Tatlı categories.
WITH fixes(name_tr,description_tr) AS (
 VALUES
  ('Dallas', 'Dallas 450-500 Gr (700 ila 900 kalori). Brokoli, karnabahar ve havuç ile servis edilir. (123 kalori)'),
  ('T-Bone', 'T-Bone 450-500 Gr (954 ila 1115 kalori). Brokoli, karnabahar ve havuç ile servis edilir. (123 kalori)'),
  ('New-York', 'New-York 350-400 Gr (1000 ila 1300 kalori). Brokoli, karnabahar ve havuç ile servis edilir. (123 kalori)'),
  ('Ribeye', 'Ribeye 350 Gr (740 ila 882 kalori). Brokoli, karnabahar ve havuç ile servis edilir. (123 kalori)'),
  ('Takoz Bonfile', 'Takoz Bonfile 250 Gr (550 ila 700 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Bonfile Lokum', 'Bonfile Lokum 220 Gr (450 ila 600 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Şaşlık', 'Şaşlık 300 Gr (3 şiş) (750 ila 950 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Yaprak Antrikot', 'Yaprak Antrikot 300 Gr (850 ila 1100 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Kuzu Pirzola', 'Kuzu Pirzola 250 Gr (650 ila 850 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Demi Glace Bonfile', 'Demi Glace Bonfile 220 Gr (550 ila 750 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Kuzu Küşleme', 'Kuzu Küşleme 220 Gr (600 ila 800 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Kuzu Sırt (Karski)', 'Kuzu Sırt (Karski) 250 Gr (700 ila 950 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Kuzu Kafes', 'Kuzu Kafes 1,3 KG (3500 ila 4500 kalori). Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (123 kalori)'),
  ('Dilim Asado', 'Dilim Asado ön sipariş alınarak servis edilir.'),
  ('Kasap Köfte', 'Kızarmış patates ile servis edilmektedir. (900 ila 1100 kalori)'),
  ('Cheddar Köfte', 'Kızarmış patates ile servis edilmektedir. (1100 ila 1300 kalori)'),
  ('Cheese Burger', 'Cheese Burger (180 Gr burger köftesi). Kızarmış patates ile servis edilmektedir. (1000 ila 1200 kalori)'),
  ('Mexican Burger', 'Mexican Burger (180 Gr burger köftesi). Cheddar peyniri, jalapeno biberi, iceberg ve kızarmış patates ile servis edilmektedir. (1100 ila 1300 kalori)'),
  ('Lokum Burger', 'Lokum Dana Burger (150 Gr ince dilimlenmiş bonfile). Dip sos, turşu, iceberg ve kızarmış patates ile servis edilmektedir. (900 ila 1100 kalori)'),
  ('Bacon Cheese Burger', 'Bacon Cheese Burger (180 Gr burger köftesi). Cheddar peyniri, dana bacon, dip sos, turşu, domates, iceberg ve kızarmış patates ile servis edilmektedir. (1200 ila 1400 kalori)'),
  ('Solo 1', '1 Ad. Lokum, 1 Ad. Cheddar Köfte, 1 Ad. Kuzu Pirzola, 1 Ad. Sucuk. Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (1500 ila 1800 kalori)'),
  ('Solo 2', '1 Ad. Yaprak Antrikot, 1 Ad. Küşleme, 1 Ad. Kasap Köfte. Haşlanmış brokoli, haşlanmış karnabahar ve havuç ile servis edilmektedir. (1600 ila 2000 kalori)'),
  ('Tiramisu', 'Tiramisu (390 kalori)'),
  ('Katmer', '4 kişilik (1800 kalori)')
)
UPDATE public.menu_items AS i
SET description_tr=f.description_tr
FROM fixes AS f, public.menu_sections AS s, public.menu_categories AS c
WHERE i.name_tr=f.name_tr AND i.section_id=s.id AND s.category_id=c.id
AND c.slug IN ('anayemek','tatli')
AND i.description_tr IS DISTINCT FROM f.description_tr;
