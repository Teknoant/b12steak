"use client";
import {useMemo,useState} from "react";

export default function ProductBrowser({children,categories}:{children:React.ReactNode;categories:{id:number;title:string}[]}){
 const [q,setQ]=useState("");
 const [cat,setCat]=useState("all");
 const filter=useMemo(()=>({q:q.trim().toLocaleLowerCase("tr-TR"),cat}),[q,cat]);
 return <div className="adminProductBrowser">
  <div className="adminTools">
   <label className="adminSearch"><span>Ürün ara</span><input value={q} onChange={e=>setQ(e.target.value)} placeholder="Dallas, Coca Cola, şarap..."/></label>
   <label><span>Kategori</span><select value={cat} onChange={e=>setCat(e.target.value)}><option value="all">Tüm kategoriler</option>{categories.map(x=><option key={x.id} value={String(x.id)}>{x.title}</option>)}</select></label>
  </div>
  <div className="adminFilteredProducts" data-query={filter.q} data-category={filter.cat}>{children}</div>
  <style jsx global>{`
   .adminFilteredProducts[data-query]:not([data-query=""]) .productEdit:not([data-search*="__never__"]){display:none}
  `}</style>
  <FilterStyle query={filter.q} category={filter.cat}/>
 </div>;
}
function FilterStyle({query,category}:{query:string;category:string}){
 const q=query.replace(/[\\"']/g,"").slice(0,80);
 const c=category.replace(/[^0-9]/g,"");
 return <style>{`
  ${q?`.adminFilteredProducts .productEdit[data-search*="${CSS.escape(q)}"]{display:block!important}`:""}
  ${category!=="all"&&c?`.adminFilteredProducts .productEdit:not([data-category="${c}"]){display:none!important}`:""}
 `}</style>
}
