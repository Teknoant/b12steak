"use client";
import {usePathname,useSearchParams} from "next/navigation";

export default function SiteHeader(){
 const pathname=usePathname();
 const params=useSearchParams();
 const lang=pathname.startsWith("/en")?"en":pathname.startsWith("/ru")?"ru":"tr";
 const isMenu=pathname==="/menu"||pathname.startsWith("/en/menu")||pathname.startsWith("/ru/menu");
 const home=lang==="en"?"/en":lang==="ru"?"/ru":"/";
 const menu=lang==="en"?"/en/menu":lang==="ru"?"/ru/menu":"/menu";
 const labels=lang==="en"?{home:"Home",menu:"Menu",open:"Menu"}:lang==="ru"?{home:"Главная",menu:"Меню",open:"Меню"}:{home:"Ana Sayfa",menu:"Menü",open:"Menü"};
 const target=(l:"tr"|"en"|"ru")=>{
   const base=isMenu?(l==="tr"?"/menu":`/${l}/menu`):(l==="tr"?"/":`/${l}`);
   const selected=isMenu?params.get("menu"):null;
   return selected?`${base}?menu=${encodeURIComponent(selected)}`:base;
 };
 const links=<><a href={home}>{labels.home}</a><a href={menu}>{labels.menu}</a><span className="langs"><a href={target("tr")}>TR</a><a href={target("en")}>EN</a><a href={target("ru")}>RU</a></span></>;
 return <header className="siteHeader"><a href={home} className="siteBrand">B12 Steak</a><nav className="desktopNav">{links}</nav><details className="mobileNav"><summary>{labels.open}</summary><div>{links}</div></details></header>;
}