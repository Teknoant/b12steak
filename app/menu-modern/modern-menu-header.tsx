"use client";
import {useState} from "react";

export default function ModernMenuHeader({menu}:{menu?:string}){
 const [open,setOpen]=useState(false);
 const q=menu?"?menu="+encodeURIComponent(menu):"";
 return <>
  <header className="modernTop">
   <button className="modernHamb" type="button" aria-label="Menüyü aç" aria-expanded={open} onClick={()=>setOpen(v=>!v)}>
    <span/><span/><span/>
   </button>
   <a className="modernLogo" href="/"><img src="/images/site/logo/logo-siyah.webp" alt="B12 Steak"/></a>
   <div className="modernTools">
    <details className="modernLang">
     <summary>🇹🇷 <b>TR</b><span>⌄</span></summary>
     <div className="modernLangMenu">
      <a className="active" href={"/menu-modern"+q}>🇹🇷 Türkçe</a>
      <a href={"/en/menu-modern"+q}>🇬🇧 English</a>
      <a href={"/ru/menu-modern"+q}>🇷🇺 Русский</a>
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