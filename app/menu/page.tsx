import {createServerSupabase} from "../../lib/supabase/server";
export const dynamic="force-dynamic";
type Cat={id:number;slug:string;title_tr:string};type Sec={id:number;category_id:number;title_tr:string};type Item={id:number;section_id:number;name_tr:string;description_tr:string|null;price:number;tags:string[];image_path:string|null};type Variant={id:number;item_id:number;label_tr:string;price:number;sort_order:number};
const localImage=(name:string)=>{
 const n=name.toLocaleLowerCase("tr-TR").trim();
 const images:Record<string,string>={
  "peynir tabağı":"/images/menu/baslangic/peynir-taba─ş─▒.webp",
  "şarküteri tabağı":"/images/menu/baslangic/┼şarkuteri-taba─ş─▒.webp",
  "dana carpaccio":"/images/menu/baslangic/danakarpa├ğyo.webp",
  "steak tartar":"/images/menu/baslangic/Steak-tartar.webp",
  "domates":"/images/menu/salatalar/Domates-salatas─▒.webp",
  "roka":"/images/menu/salatalar/Roka-Salatas─▒.webp",
  "akdeniz":"/images/menu/salatalar/Akdenizsalata.webp",
  "tulum":"/images/menu/salatalar/tulumsalata.webp",
  "steak salata":"/images/menu/salatalar/Steak-salata.webp",
  "dallas":"/images/menu/ana-yemek/dry-aged/Dallas.webp",
  "t-bone":"/images/menu/ana-yemek/dry-aged/T-BONE.webp",
  "new-york":"/images/menu/ana-yemek/dry-aged/newyork.webp",
  "ribeye":"/images/menu/ana-yemek/dry-aged/ribeye.webp",
  "takoz bonfile":"/images/menu/ana-yemek/beef/Takoz-Bonfile.webp",
  "bonfile lokum":"/images/menu/ana-yemek/beef/Bonfile-Lokum.webp",
  "şaşlık":"/images/menu/ana-yemek/beef/┼Şa┼şl─▒k.webp",
  "yaprak antrikot":"/images/menu/ana-yemek/beef/yaprakantikot.webp",
  "kuzu pirzola":"/images/menu/ana-yemek/beef/Kuzu-Pirzola.webp",
  "kuzu küşleme":"/images/menu/ana-yemek/beef/Kuzu-K├╝┼şleme.webp",
  "kuzu sırt (karski)":"/images/menu/ana-yemek/beef/karski.webp",
  "kuzu kafes":"/images/menu/ana-yemek/beef/Kuzu-Kafes.webp",
  "dilim asado":"/images/menu/ana-yemek/beef/dana-asado.webp",
  "file şato beef 4 kişilik":"/images/menu/ana-yemek/beef/satobiryan.webp",
  "file şato beef 2 kişilik":"/images/menu/ana-yemek/beef/satobiryan.webp",
  "cheddar köfte":"/images/menu/kofte/cheddar-k├Âfte.webp",
  "cheese burger":"/images/menu/burger/chesse-burger.webp",
  "lokum burger":"/images/menu/burger/Lokum-Dana-Burger.webp",
  "solo 1":"/images/menu/solo/Solo1.webp",
  "solo 2":"/images/menu/solo/solo2.webp",
  "s.pellegrino":"/images/menu/soft/St.Pellegrino.webp",
  "soda":"/images/menu/soft/Soda.webp",
  "uludağ soda":"/images/menu/soft/uludag.webp",
  "tiramisu":"/images/menu/tatli/Tiramisu.webp"
 };
 return images[n]||null;
};
const itemImage=(i:Item)=>i.image_path?process.env.NEXT_PUBLIC_SUPABASE_URL+"/storage/v1/object/public/menu-images/"+i.image_path:localImage(i.name_tr);
const money=(v:number)=>new Intl.NumberFormat("tr-TR",{style:"currency",currency:"TRY",maximumFractionDigits:0}).format(Number(v));
export default async function Menu({searchParams}:{searchParams:Promise<{menu?:string}>}){const sp=await searchParams;const db=await createServerSupabase();const [{data:cats},{data:secs},{data:items},{data:variants}]=await Promise.all([db.from("menu_categories").select("*").eq("is_active",true).order("sort_order"),db.from("menu_sections").select("*").eq("is_active",true).order("sort_order"),db.from("menu_items").select("*").eq("is_active",true).order("sort_order"),db.from("menu_item_variants").select("*").eq("is_active",true).order("sort_order")]);const categories=(cats||[]) as Cat[];const active=categories.find(c=>c.slug===sp.menu)||categories[0];const sections=((secs||[]) as Sec[]).filter(s=>s.category_id===active?.id);const allItems=(items||[]) as Item[];const allVariants=(variants||[]) as Variant[];return <main className="menuPage"><section className="menuTop"><h1>Menü</h1><nav className="menuTabs">{categories.map(c=><a className={active?.id===c.id?"active":""} href={"/menu?menu="+c.slug} key={c.id}>{c.title_tr}</a>)}</nav></section><section className="wixMenu"><h2 className="menuCategoryTitle">{active?.title_tr||"Menü"}</h2>{sections.map(s=><section className="menuSection" key={s.id}><h2>{s.title_tr}</h2><div className="sectionRule"/>{allItems.filter(i=>i.section_id===s.id).map(i=>{const vs=allVariants.filter(v=>v.item_id===i.id);return <article className="dish" key={i.id}><div className="dishCopy">{itemImage(i)&&<img className="menuItemImage" src={itemImage(i)!} alt={i.name_tr}/>}<h3>{i.name_tr}</h3>{i.description_tr&&<p>{i.description_tr}</p>}{i.tags?.length>0&&<p className="dishTags">{i.tags.join(" · ")}</p>}</div><div className="dishPrice">{vs.length?vs.map(v=><div className="variant" key={v.id}><span>{v.label_tr}</span><strong>{money(v.price)}</strong></div>):<strong>{money(i.price)}</strong>}</div></article>})}</section>)}</section></main>}