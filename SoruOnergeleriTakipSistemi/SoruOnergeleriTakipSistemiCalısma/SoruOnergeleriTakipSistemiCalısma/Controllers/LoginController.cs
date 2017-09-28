using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SoruOnergeleriTakipSistemiCalısma.Controllers
{
    public class LoginController : Controller
    {
        OnergeDBDataContext vt = new OnergeDBDataContext();
        //
        // GET: /AdminKullanici/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Login(FormCollection frm)
        {
            string kullaniciAdi = frm.Get("txtKullaniciAdi").Trim();
            string sifre = frm.Get("txtSifre").Trim();
            if (kullaniciAdi == "" || sifre == "")
            {
                ViewBag.Bos = true;
            }
            else
            {

                var kayit2 = from m in vt.Kullanicilars
                             where m.KullaniciAdi == kullaniciAdi &&
                                m.Sifre == sifre
                             select new { m.ID };
                var kayit = from k in vt.Yöneticilers
                            where k.kullaniciAdi == kullaniciAdi &&
                                k.Sifre == sifre
                            select new { k.ID };

                if (kayit.ToList().Count > 0)
                {
                   
                    Session.Add("giris", true);
                    foreach (var item in kayit)
                    {
                        Session.Add("id", item.ID);

                    }
                    return RedirectToAction("Index", "Admin");

                }

                if (kayit2.ToList().Count > 0)
                {
                  
                    Session.Add("giris", true);
                    foreach (var item in kayit2)
                    {
                        Session.Add("id", item.ID);

                    }
                    return RedirectToAction("Index", "Kullanici");

                }
                else
                {
                    ViewBag.onay = false;
                }

            }
            return View();
        }
    }
}
