using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SoruOnergeleriTakipSistemiCalısma.Models;
using System.Net;
using System.IO;


namespace SoruOnergeleriTakipSistemiCalısma.Controllers
{
    public class KullaniciController : Controller
    {

        OnergeDBDataContext vt = new OnergeDBDataContext();
   

        public ActionResult Index(string durum)
        {
            ViewBag.sayi = 0;
            var KullaniciGoster = from o in vt.Mesajs
                                  from p in vt.Kullanicilars
                                  where o.kurumID == p.KurumID

                                  select new
                                  {
                                      p.ID,
                                      o.IDM,
                                      o.mesajKonusu,
                                      o.okunma,
                                      o.onergeID

                                  };


            if (KullaniciGoster.Count() > 0)
            { 

                ViewBag.sayi = 1;

                List<KullaniciHelper> mList = new List<KullaniciHelper>();
             

                foreach (var item in KullaniciGoster)
                {
                    if (item.ID == Convert.ToInt32(Session["id"]))
                    {

                        KullaniciHelper detay = new KullaniciHelper();
               

                        detay.mesaj = item.mesajKonusu;
                        detay.mesajID = item.IDM;
                        detay.okunma = Convert.ToInt32(item.okunma);

                        detay.onergeID = Convert.ToInt32(item.onergeID);

                        mList.Add(detay);

                    }

                }
               
                ViewBag.onergeList = mList;

                if (!String.IsNullOrEmpty(durum))
                {

                    if (durum == "onaykaldir")
                    {

                        //ViewBag.mesaj = "Okunmadı";

                    }
                    else
                    {

                        //ViewBag.mesaj = "Okundu";

                    }

                }

                return View(mList);
            }

            else
            {
                return View();
                ViewBag.sayi = 0;
           
            }
        }

        public ActionResult Onergeler(string id)
        {
            ViewBag.sayi = 0;

            var KullaniciGoster = from o in vt.Onerges
                                  from p in vt.Kullanicilars
                                  from c in vt.Cevaps

                                  join k in vt.GKurums on o.GeldigiKurumID equals k.ID
                                  join q in vt.Durums on o.durumID equals q.ID
                                  join qw in vt.MilletVekilis on o.milletvekiliID equals qw.ID
                                  join t in vt.OnergeKonuGruplarıs on o.KonuGrupID equals t.ID
                                  where o.kurumID == p.KurumID && p.ID == Convert.ToInt32(Session["id"]) && c.onergeID==o.ID

                                  select new
                                  {

                                      o.EvrakTarihi,
                                      o.Donem,
                                      o.YasamaYili,
                                      o.EsasNo,
                                      qw.milletvekiliAdı,
                                      o.MilletvekilPartisiIli,
                                      q.Durum1,
                                      t.OnergeKonusu,
                                      o.Extension,
                                      k.GeldigiKurumAdi,
                                      o.ID,
                                      o.BitisTarihi,
                                      c.uzanti,
                                      qw.partisi,
                                      qw.ili


                                  };

         
            double sayfa = Convert.ToDouble(id);
            if (sayfa == 0)
            {
                sayfa = 1;
            }

            double kacar = 3;
            double kactan = (sayfa * kacar) - kacar;
            double tamsayi = KullaniciGoster.Count();

            ViewBag.sayfasayisi = Math.Ceiling(tamsayi / kacar);
         

            if (KullaniciGoster.Count() > 0)
            {
                ViewBag.sayi = 1;


                var query2 = KullaniciGoster.Skip(Convert.ToInt32(kactan)).Take(Convert.ToInt32(kacar));

                List<KullaniciHelper> mList = new List<KullaniciHelper>();
             
                foreach (var item in query2)
                {

                    KullaniciHelper detay = new KullaniciHelper();
             
                    detay.evrakTime = Convert.ToDateTime(item.EvrakTarihi);
                    detay.donem = Convert.ToInt32(item.Donem);
                    detay.yasamaYili = Convert.ToInt32(item.YasamaYili);
                    detay.esasNo = Convert.ToInt32(item.EsasNo);
                    detay.milletvekiliAd = item.milletvekiliAdı;
                    detay.milletvekilParti = item.partisi;
                    detay.milletvekilIli = item.ili;
                    detay.durum = item.Durum1;

                    detay.gKurum = item.GeldigiKurumAdi;
                    detay.dosya = item.Extension;
                    detay.onergeID = item.ID;
                    detay.konu = item.OnergeKonusu;
                    detay.bitisTarihi = Convert.ToDateTime(item.BitisTarihi);
                    detay.uzanti = item.uzanti;

                    mList.Add(detay);

                }
                
                ViewBag.onergeList = mList;
                return View(mList);
            }
            else
            {
                return View();
                ViewBag.sayi = 0;
            }

        }
        [HttpGet]
        public ActionResult DosyaYukle(int id)
        {
            var KullaniciGoster = from o in vt.Onerges
                                  from p in vt.Kullanicilars

                                  join k in vt.GKurums on o.GeldigiKurumID equals k.ID

                                  where o.kurumID == p.KurumID && o.ID == id && p.ID == Convert.ToInt32(Session["id"])

                                  select new
                                  {
                                      o.Extension
                                  };


            foreach (var item in KullaniciGoster)
            {
                string FilePath = Server.MapPath(item.Extension);
                WebClient User = new WebClient();
                Byte[] FileBuffer = User.DownloadData(FilePath);

                Response.Clear();
                Response.ClearHeaders();
                Response.AppendHeader("content-disposition", "attachment; filename=" + item.Extension);
                Response.TransmitFile(item.Extension);
                Response.Flush();
                Response.End();

            }

            return View();

        }

        public ActionResult Cikis()
        {

            return RedirectToAction("Login", "Login");

        }
       
        [HttpGet]
        public ActionResult okunmaDurumu(string sayfa, string id)
        {
            int okunma = 0;
            int ID = Convert.ToInt32(id);
            if (sayfa != "onaykaldir")
                okunma = 1;

            var oku = vt.Mesajs.FirstOrDefault(x => x.IDM == ID);
            oku.okunma = okunma;
            vt.SubmitChanges();
            if (sayfa == "onaykaldir")

                return RedirectToAction("Index", new { durum = "okunmadı" });

            else return RedirectToAction("Index", new { durum = "okundu" });
        }


        public ActionResult sifreDegis()
        {


            return View();

        }
        
        public ActionResult Sil(int id)
        {
            if (id != null)
            {
              
                Mesaj m = vt.Mesajs.First(x => x.IDM == id);
               
                vt.Mesajs.DeleteOnSubmit(m);
                vt.SubmitChanges();
                ViewBag.mSil = "Mesajınız Silindi.";
                return RedirectToAction("Index");

            }

            return View();

        }



        public void durum()
        {
            List<SelectListItem> durumList = new List<SelectListItem>();
            durumList.Add(new SelectListItem { Text = "Durum Seçiniz", Value = null });
            var durumSorgu = from k in vt.Durums select k;

            foreach (var item in durumSorgu)
            {
                durumList.Add(new SelectListItem { Text = item.Durum1, Value = item.ID.ToString() });


            }

            ViewBag.durumlar = durumList;
        }
        public void kurum()
        {
            List<SelectListItem> kurumList = new List<SelectListItem>();
            kurumList.Add(new SelectListItem { Text = "Kurumunuzu Seçiniz", Value = null });
            var kurumSorgu = from k in vt.Kurums select k;

            foreach (var item in kurumSorgu)
            {
                kurumList.Add(new SelectListItem { Text = item.KurumAd, Value = item.ID.ToString() });


            }

            ViewBag.kurumlar = kurumList;
        }
     

        public ActionResult onergeCevap()
        {
            durum();
            kurum();
           
            return View();
        }

        [HttpPost]
        public ActionResult onergeCevap(FormCollection frm, HttpPostedFileBase file, int id)
        {

            durum();
            kurum();


            

                if (frm.Get("kurumlar") != "Kurumunuzu Seçiniz")
                {

                    if (frm.Get("durumlar") != "Durum Seçiniz")
                    {


                        int durumID = Convert.ToInt32(frm.Get("durumlar"));
                        int kurumID = Convert.ToInt32(frm.Get("kurumlar"));

                        int OID = 0;

                        var dosyaAdi = Path.GetFileName(file.FileName);
                        var dosya = Path.Combine(Server.MapPath("~/CevapFile/"), dosyaAdi);
                        file.SaveAs(dosya);
                        string dosyayolu = "~/CevapFile/" + dosyaAdi;

                        OnergeDBDataContext vt = new OnergeDBDataContext();
                        Cevap k = new Cevap
                        {

                            durumID = durumID,
                            kurumID = kurumID,
                            onergeID = id,
                            uzanti = dosyayolu,

                        };
                        vt.Cevaps.InsertOnSubmit(k);


                        Onerge onerge = vt.Onerges.First(p => p.ID == id);
                        onerge.durumID = durumID;
                        vt.SubmitChanges();
                        OID++;
                        MesajAdmin m = new MesajAdmin
                        {

                            IDM = OID,
                            mesajKonusu = "Yeni cevap  Var!!",
                            kurumID = kurumID,
                            onergeID = k.onergeID,

                        };


                        vt.MesajAdmins.InsertOnSubmit(m);
                        vt.SubmitChanges();
                        ViewBag.cevaplandi = "Önerge Cevaplandı!!";
                   
                }
           
            else
            {
                ViewBag.durumUyari = "Önergenin Durumunu Giriniz!";
                
            }
            }
            else
            {

                ViewBag.kurumUyari = "Kurumunuzu Giriniz!";

            }
                    return View();
        }


        public ActionResult sonOnerge(int id)
        {
            ViewBag.sayi = 0;

            AdminController c = new AdminController();
            c.OnergeKayit();

            var sonOnerge = from o in vt.Onerges
                            from p in vt.Kullanicilars
                            from h in vt.Mesajs
                            from j in vt.MilletVekilis
                            from re in vt.OnergeKonuGruplarıs
                          
                            join k in vt.GKurums on o.GeldigiKurumID equals k.ID
                            join q in vt.Durums on o.durumID equals q.ID
                            join qw in vt.MilletVekilis on o.milletvekiliID equals qw.ID
                            orderby o.ID ascending

                            where o.ID == h.onergeID && h.onergeID == id && o.kurumID == p.KurumID && o.KonuGrupID==re.ID && p.ID == Convert.ToInt32(Session["id"])

                            select new
                            {

                                o.EvrakTarihi,
                                o.Donem,
                                o.YasamaYili,
                                o.EsasNo,
                                qw.milletvekiliAdı,
                                o.MilletvekilPartisiIli,
                                re.OnergeKonusu,
                                o.Extension,
                                k.GeldigiKurumAdi,
                                o.ID,
                                q.Durum1,
                                h.IDM,
                                o.BitisTarihi,
                                qw.ili,
                                qw.partisi

                            };


            if (sonOnerge.Count() > 0)
            { 

                ViewBag.sayi = 1;

                List<KullaniciHelper> mList = new List<KullaniciHelper>();
               
                foreach (var item in sonOnerge)
                {

                    if (item.IDM == id)
                    {
                        KullaniciHelper detay = new KullaniciHelper();
                      

                        detay.evrakTime = Convert.ToDateTime(item.EvrakTarihi);
                        detay.donem = Convert.ToInt32(item.Donem);
                        detay.yasamaYili = Convert.ToInt32(item.YasamaYili);
                        detay.esasNo = Convert.ToInt32(item.EsasNo);
                        detay.milletvekiliAd = item.milletvekiliAdı;
                        detay.milletvekilParti = item.MilletvekilPartisiIli;
                        detay.durum = item.Durum1;
                        detay.konu = item.OnergeKonusu;
                        detay.gKurum = item.GeldigiKurumAdi;
                        detay.dosya = item.Extension;
                        detay.onergeID = item.ID;
                        detay.bitisTarihi = Convert.ToDateTime(item.BitisTarihi);
                        detay.milletvekilParti = item.partisi;
                        detay.milletvekilIli = item.ili;

                        mList.Add(detay);

                    }
                }
                ViewBag.onergeList = mList;
                return View(mList);
            }

            else
            {

                return View();
                ViewBag.sayi = 0;

            }

        }
        public ActionResult KsifreDegistir()
        {


               if (Request.HttpMethod == "POST")
            {

                string sifreEski = Request.Form.Get("txtEskiSifreD");
                string sifreYeni = Request.Form.Get("txtYeniSifreD");
                string sifreOnay = Request.Form.Get("txtSifreOnayD");


                OnergeDBDataContext dc = new OnergeDBDataContext();
             

                Kullanicilar kitap = dc.Kullanicilars.First(k => k.ID == Convert.ToInt32(Session["id"]));
                if (sifreEski != null && sifreYeni != null && sifreOnay != null)
                {
                    if (sifreEski != kitap.Sifre)
                    {
                        ViewBag.uyari = "Yanlis Sifre Girdiniz.Lütfen şifrenizi doğru giriniz!!";
                    }
                    else
                    {
                        kitap.Sifre = sifreYeni;
                        if (sifreYeni.Contains("ğ") || sifreYeni.Contains("ü") || sifreYeni.Contains("i")||
                            sifreYeni.Contains("ş") || sifreYeni.Contains("ç") || sifreYeni.Contains("ö") || sifreYeni.Contains("Ğ")
                            || sifreYeni.Contains("Ü") || sifreYeni.Contains("İ") || sifreYeni.Contains("Ş")
                            || sifreYeni.Contains("Ç") || sifreYeni.Contains("Ö"))
                        {

                            ViewBag.uyari1 = "Türkçe Karakter girmeyiniz!!";
                        }
                        else { 
                            if(sifreYeni.Contains(""))
                        if (sifreOnay == sifreYeni)
                        {

                           
                            dc.SubmitChanges();
                            ViewBag.Sifre = "Sifre Değişti.";
                            return RedirectToAction("Index");
                        }
                        else
                            ViewBag.Sifre123 = "Onay Şifrenizi Yanlış Girdiniz!!";
                    }
                }
                }
            }
            else ViewBag.bos = "Lütfen Gerekli Alanları Giriniz!!";

            return View();
        }


        public ActionResult KonuAra()
        {
            return View();
        }

        [HttpPost]
        public ActionResult KonuAra(FormCollection frm)
        {

            string konuAdi = frm.Get("txtKAd");
            ViewBag.sayi = 0;
            var ad = from m in vt.OnergeKonuGruplarıs
                     from o in vt.Onerges
                     join k in vt.Kurums on o.kurumID equals k.ID
                     join gk in vt.GKurums on o.GeldigiKurumID equals gk.ID
                     join d in vt.Durums on o.durumID equals d.ID
                     join v in vt.MilletVekilis on o.milletvekiliID equals v.ID


                     where konuAdi == m.OnergeKonusu && o.KonuGrupID == m.ID
                     select new
                     {
                         o.Donem,
                         o.YasamaYili,
                         o.EsasNo,
                         o.EvrakTarihi,
                         gk.GeldigiKurumAdi,
                         v.milletvekiliAdı,
                         o.MilletvekilPartisiIli,
                         k.KurumAd,
                         d.Durum1,
                         m.OnergeKonusu




                     };

            if (ad.Count() > 0)
            {

                ViewBag.sayi = 1;

                List<DetayliHelper> mList = new List<DetayliHelper>();


                foreach (var item in ad)
                {

                    DetayliHelper detay = new DetayliHelper();


                    detay.Donem = Convert.ToInt32(item.Donem);
                    detay.YasamaYili = Convert.ToInt32(item.YasamaYili);
                    detay.EsasNo = Convert.ToInt32(item.EsasNo);
                    detay.MilletvekilAd = item.milletvekiliAdı;
                    detay.EvrakTarihi = Convert.ToDateTime(item.EvrakTarihi);
                    detay.OnergeDurumu = item.Durum1;
                    detay.GeldigiKurum = item.GeldigiKurumAdi;
                    detay.sorumluPersonel = item.KurumAd;
                    detay.onergeKonusu = item.OnergeKonusu;
                    detay.MilletvekilPartisiIli = item.MilletvekilPartisiIli;


                    mList.Add(detay);




                }

                return View(mList);
            }
            else
            {

                return View();
                ViewBag.sayi = 0;
 }
 }

        public ActionResult onergeCevaplandi()
        {

            return View();
        }

        public ActionResult profilGuncelle()
        {

            ViewBag.duzenle = "";
            var duzenle = vt.Kullanicilars.First(x => x.ID == Convert.ToInt32(Session["id"]));


            return View(duzenle);

        }

        [HttpPost, ValidateInput(false)]
        public ActionResult profilGuncelle(Kullanicilar o, FormCollection frm, HttpPostedFileBase file)
        {

            var yoneticiDuz = vt.Kullanicilars.First(x => x.ID == o.ID);

            yoneticiDuz.KullaniciAdi = o.KullaniciAdi;
           
            yoneticiDuz.Email = o.Email;
            yoneticiDuz.Adi = o.Adi;
            yoneticiDuz.Soyadi = o.Soyadi;





            vt.SubmitChanges();

            ViewBag.duzenle = "Kullanıcı Güncellendi!!";

            return View();
        }

    }
}











           