"use client";
import {useState} from "react";

export default function MenuImage({src,alt}:{src:string;alt:string}){
 const [open,setOpen]=useState(false);
 return <>
  <button type="button" className="menuImageButton" onClick={()=>setOpen(true)} aria-label={alt+" görselini büyüt"}>
   <img className="menuItemImage" src={src} alt={alt}/>
  </button>
  {open&&<div className="menuImageLightbox" role="dialog" aria-modal="true" aria-label={alt} onClick={()=>setOpen(false)}>
   <button type="button" className="menuImageClose" onClick={()=>setOpen(false)} aria-label="Kapat">×</button>
   <img src={src} alt={alt} onClick={e=>e.stopPropagation()}/>
  </div>}
 </>;
}
