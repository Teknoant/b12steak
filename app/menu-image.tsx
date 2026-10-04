"use client";
import Image from "next/image";
import {useState} from "react";

export default function MenuImage({src,alt}:{src:string;alt:string}){
 const [open,setOpen]=useState(false);
 return <>
  <button type="button" className="menuImageButton" onClick={()=>setOpen(true)} aria-label={alt+" görselini büyüt"}>
   <Image className="menuItemImage" src={src} alt={alt} width={192} height={192} sizes="(max-width:390px) 82px, (max-width:700px) 96px, 92px" quality={72} loading="lazy"/>
  </button>
  {open&&<div className="menuImageLightbox" role="dialog" aria-modal="true" aria-label={alt} onClick={()=>setOpen(false)}>
   <button type="button" className="menuImageClose" onClick={()=>setOpen(false)} aria-label="Kapat">×</button>
   <Image src={src} alt={alt} width={1200} height={1200} sizes="96vw" quality={82} onClick={e=>e.stopPropagation()} className="menuLightboxImage"/>
  </div>}
 </>;
}
