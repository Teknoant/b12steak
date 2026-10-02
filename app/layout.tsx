import "./globals.css";
import SiteHeader from "./site-header";

export const metadata={title:"B12 Steak",description:"B12 Steak - Kasap Ali Kuruluşudur."};

export default function RootLayout({children}:{children:React.ReactNode}){
 return <html lang="tr"><body><SiteHeader/>{children}<footer><span>B12 Steak</span><span>©2022, B12 Steak. Teknoant.com ile kurulmuştur.</span></footer></body></html>;
}