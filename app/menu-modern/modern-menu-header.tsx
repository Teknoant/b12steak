"use client";
import {useState} from "react";
import {usePathname} from "next/navigation";

export default function ModernMenuHeader({menu}:{menu?:string}){
 const [open,setOpen]=useState(false);
 const pathname=usePathname();
 const lang=pathname.startsWith("/en/")?"EN":pathname.startsWith("/ru/")?"RU":"TR";
 const flag=lang==="EN"?"🇬🇧":lang==="RU"?"🇷🇺":"🇹🇷";
 const q=menu?"?menu="+encodeURIComponent(menu):"";
 return <>
  <header className="modernTop">
   <button className="modernHamb" type="button" aria-label="Menüyü aç" aria-expanded={open} onClick={()=>setOpen(v=>!v)}>
    <span/><span/><span/>
   </button>
   <a className="modernLogo" href="/"><img src="/images/site/logo/logo-siyah.webp" alt="B12 Steak"/></a>
   <div className="modernTools">
    <details className="modernLang">
     <summary>{flag} <b>{lang}</b><span>⌄</span></summary>
     <div className="modernLangMenu">
      <a className={lang==="TR"?"active":""} href={"/menu-modern"+q}>🇹🇷 Türkçe</a>
      <a className={lang==="EN"?"active":""} href={"/en/menu-modern"+q}>🇬🇧 English</a>
      <a className={lang==="RU"?"active":""} href={"/ru/menu-modern"+q}>🇷🇺 Русский</a>
     </div>
    </details>
   </div>
  </header>
  {open&&<div className="modernDrawer">
   <button type="button" className="modernDrawerClose" onClick={()=>setOpen(false)}>×</button>
   <a href="/">Ana Sayfa</a>
   <a href="/menu-modern">Modern Menü</a>
   <a href="/menu">Klasik Menü</a>
  </div>}
  {open&&<button className="modernDrawerBackdrop" aria-label="Menüyü kapat" onClick={()=>setOpen(false)}/>}
 </>;
}