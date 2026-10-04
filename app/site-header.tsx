"use client";
import {usePathname} from "next/navigation";

export default function SiteHeader(){
 const pathname=usePathname();
 const lang=pathname.startsWith("/en")?"en":pathname.startsWith("/ru")?"ru":"tr";
 const isMenu=pathname==="/menu"||pathname.startsWith("/en/menu")||pathname.startsWith("/ru/menu");
 const home=lang==="en"?"/en":lang==="ru"?"/ru":"/";
 const menu=lang==="en"?"/en/menu":lang==="ru"?"/ru/menu":"/menu";
 const labels=lang==="en"?{home:"Home",menu:"Menu",open:"Menu"}:lang==="ru"?{home:"Главная",menu:"Меню",open:"Меню"}:{home:"Ana Sayfa",menu:"Menü",open:"Menü"};
 const links=<><a href={home}>{labels.home}</a><a href={menu}>{labels.menu}</a></>;
 return <header className={"siteHeader "+(isMenu?"menuSiteHeader":"")}><a href={home} className="siteBrand">{isMenu?<img src="/images/site/logo/b12logo.webp" alt="B12 Steak"/>:"B12 Steak"}</a><nav className="desktopNav">{links}</nav><details className="mobileNav"><summary>{labels.open}</summary><div>{links}</div></details></header>;
}
