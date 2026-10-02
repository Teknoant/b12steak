"use server";
import {revalidatePath} from "next/cache";
import {redirect} from "next/navigation";
import {createServerSupabase} from "../../lib/supabase/server";
async function adminDb(){const db=await createServerSupabase();const{data:{user}}=await db.auth.getUser();if(!user)redirect("/admin/login");const{data:a}=await db.from("admin_users").select("role").eq("user_id",user.id).maybeSingle();if(!a)redirect("/admin/login");return db}
export async function saveItem(form:FormData){const db=await adminDb();const id=String(form.get("id")||"");const row={section_id:Number(form.get("section_id")),name_tr:String(form.get("name_tr")||""),name_en:String(form.get("name_en")||"")||null,name_ru:String(form.get("name_ru")||"")||null,description_tr:String(form.get("description_tr")||"")||null,description_en:String(form.get("description_en")||"")||null,description_ru:String(form.get("description_ru")||"")||null,price:Number(form.get("price")||0),is_active:form.get("is_active")==="on"};if(id)await db.from("menu_items").update(row).eq("id",Number(id));else await db.from("menu_items").insert(row);revalidatePath("/admin");revalidatePath("/menu");revalidatePath("/en/menu");revalidatePath("/ru/menu")}
export async function deleteItem(form:FormData){const db=await adminDb();await db.from("menu_items").delete().eq("id",Number(form.get("id")));revalidatePath("/admin");revalidatePath("/menu");revalidatePath("/en/menu");revalidatePath("/ru/menu")}
export async function logout(){const db=await createServerSupabase();await db.auth.signOut();redirect("/admin/login")}
