"use client";
import {useRouter} from "next/navigation";

type Lang="tr"|"en"|"ru";
const labels:Record<Lang,string>={tr:"Türkçe",en:"English",ru:"Русский"};

export default function MenuLanguageSwitcher({lang,menu}:{lang:Lang;menu?:string}){
 const router=useRouter();
 const change=(next:Lang)=>{
  const base=next==="tr"?"/menu":`/${next}/menu`;
  router.push(menu?`${base}?menu=${encodeURIComponent(menu)}`:base);
 };
 return <div className="menuLanguage">
  <span className="menuLanguagePin" aria-hidden="true">⌖</span>
  <select aria-label="Menü dili" value={lang} onChange={e=>change(e.target.value as Lang)}>
   <option value="tr">{labels.tr}</option>
   <option value="en">{labels.en}</option>
   <option value="ru">{labels.ru}</option>
  </select>
 </div>;
}
