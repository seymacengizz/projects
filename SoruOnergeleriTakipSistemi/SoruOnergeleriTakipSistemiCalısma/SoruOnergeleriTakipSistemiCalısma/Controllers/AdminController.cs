using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SoruOnergeleriTakipSistemiCalısma.Models;
using System.Net.Mail;
using System.Web.Helpers;
using System.Net;
using Quartz;
using Quartz.Impl;

namespace SoruOnergeleriTakipSistemiCalısma.Controllers
{
    public class AdminController : Controller
    {
        public ActionResult Index(string durum)
        {
            ViewBag.sayi = 0;
            var adminMesaj = from o in vt.MesajAdmins
                             from p in vt.Kullanicilars
                             join k in vt.Kurums on p.KurumID equals k.ID
                             where o.kurumID == p.KurumID 
                             select new{
                                 p.ID,
                                 o.IDM,
                                 o.mesajKonusu,
                                 p.Adi,
                                 p.Soyadi,
                                 o.okunma,
                                 o.onergeID };

            if (adminMesaj.Count() > 0)
            { 

                ViewBag.sayi = 1;

                List<KullaniciHelper> mList = new List<KullaniciHelper>();
              
                foreach (var item in adminMesaj)
                {

                    KullaniciHelper detay = new KullaniciHelper();
                   
                    detay.Amesaj = item.mesajKonusu;
                    detay.AmesajID = item.IDM;
                    detay.onergeID = Convert.ToInt32(item.onergeID);
                   
                    detay.Ad = item.Adi;
                    detay.Soyad = item.Soyadi;
                    detay.okunma = Convert.ToInt32(item.okunma);

                    mList.Add(detay); }

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
                ViewBag.sayi = 0; }}

        [HttpGet]
        public ActionResult okunmaDurumu(string sayfa, string id)
        {
            int okunma = 0;
            int ID = Convert.ToInt32(id);
            if (sayfa != "onaykaldir")
                okunma = 1;

            var oku = vt.MesajAdmins.FirstOrDefault(x => x.IDM == ID);
            oku.okunma = okunma;
            vt.SubmitChanges();
            if (sayfa == "onaykaldir")

                return RedirectToAction("Index", new { durum = "okunmadı" });

            else return RedirectToAction("Index", new { durum = "okundu" });
        }
        OnergeDBDataContext vt = new OnergeDBDataContext();
     
        public void durum()
        {
            List<SelectListItem> durumList = new List<SelectListItem>();
            var durumSorgu = from k in vt.Durums select k;
            durumList.Add(new SelectListItem { Text = "Durum Seçiniz", Value = null });
            foreach (var item in durumSorgu)
            {
                durumList.Add(new SelectListItem { Text = item.Durum1, Value = item.ID.ToString() });


            }

            ViewBag.durumlar = durumList;



        }
        public void milletvekil()
        {
            List<SelectListItem> vekilList = new List<SelectListItem>();
            var vekilSorgu = from k in vt.MilletVekilis select k;
            vekilList.Add(new SelectListItem { Text = "Milletvekili Seçiniz", Value = null });
            
            foreach (var item in vekilSorgu)
            {
                vekilList.Add(new SelectListItem { Text = item.milletvekiliAdı, Value = item.ID.ToString() });


            }

            ViewBag.milletvekil = vekilList;



        }
        public void kurum()
        {
            List<SelectListItem> kurumList = new List<SelectListItem>();
            var kurumSorgu = from k in vt.Kurums select k;

            foreach (var item in kurumSorgu)
            {
                kurumList.Add(new SelectListItem { Text = item.KurumAd, Value = item.ID.ToString() });


            }

            ViewBag.kurumlar = kurumList;
        }
        public void Gkurum()
        {
            List<SelectListItem> kurumList = new List<SelectListItem>();
            kurumList.Add(new SelectListItem { Text = "Geldiği Kurumu Seçiniz", Value = null });
            var kurumSorgu = from k in vt.GKurums select k;

            foreach (var item in kurumSorgu)
            {
                kurumList.Add(new SelectListItem { Text = item.GeldigiKurumAdi, Value = item.ID.ToString() });


            }

            ViewBag.Gkurumlar = kurumList;
        }

        public void Konu()
        {
            List<SelectListItem> konuList = new List<SelectListItem>();
            konuList.Add(new SelectListItem { Text = "Konu Grubu Seçiniz", Value = null });
            var konuSorgu = from d in vt.OnergeKonuGruplarıs select d;

            foreach (var item in konuSorgu)
            {
                konuList.Add(new SelectListItem { Text = item.OnergeKonusu, Value = item.ID.ToString() });


            }

            ViewBag.konuGrupları = konuList;
        }


        public void Turu()
        {
            List<SelectListItem> TuruList = new List<SelectListItem>();
            var turSorgu = from k in vt.OnergeTurus select k;

            foreach (var item in turSorgu)
            {
                TuruList.Add(new SelectListItem { Text = item.TürAdı, Value = item.ID.ToString() });


            }

            ViewBag.Tür = TuruList;
        }
    

        public ActionResult OnergeKayit()
        {
           
          
            kurum();
            Gkurum();
            durum();
            milletvekil();
            Konu();
            Turu();
            OnergeDBDataContext vt = new OnergeDBDataContext();
            List<Kurum> kurumListesi = vt.Kurums.ToList();
            ViewBag.Nesli = kurumListesi;
            
            return View();
        }

        [HttpPost]
        public ActionResult OnergeKayit(FormCollection frm, HttpPostedFileBase file)
        {

            kurum();
            Gkurum();
            durum();
            milletvekil();
            Konu();
            Turu();

                int donem = Convert.ToInt32(frm.Get("txtDonem"));
                int yasamaYili = Convert.ToInt32(frm.Get("txtYasamaYili"));
                int esasNo = Convert.ToInt32(frm.Get("txtEsasNo"));
                if (Convert.ToString(frm.Get("txtBitisTarihi")) != "")
                {
                    if (Convert.ToString(frm.Get("txtEvrakTarihi")) != "")
                    {
                        if (frm.Get("milletvekil") != "Milletvekili Seçiniz")
                        {
                            if (frm.Get("durumlar") != "Durum Seçiniz")
                            {
                                if (frm.Get("konuGrupları") != "Konu Grubu Seçiniz")
                                {
                                    DateTime evrakTarih = Convert.ToDateTime(frm.Get("txtEvrakTarihi"));
                                    int milletvekilID = Convert.ToInt32(frm.Get("milletvekil"));
                                    int GkurumID = Convert.ToInt32(frm.Get("Gkurumlar"));
                                    int durumID = Convert.ToInt32(frm.Get("durumlar"));
                                    int turID = Convert.ToInt32(frm.Get("Tür"));
                                    int konuID = Convert.ToInt32(frm.Get("konuGrupları"));

                                    DateTime bitis = Convert.ToDateTime(frm.Get("txtBitisTarihi"));

                                    int sayac1 = 0;
                                    int OID = 0;
                                    Random rnd = new Random();
                                    string sayi = rnd.Next(0, 999999).ToString();
                                    var dosyaAdi = Path.GetFileName(file.FileName);
                                    var dosya = Path.Combine(Server.MapPath("~/File/"), dosyaAdi);
                                    file.SaveAs(dosya);
                                    string dosyayolu = "~/File/" + dosyaAdi;

                                    bool[] check = new bool[20];


                                    check[0] = !string.IsNullOrEmpty(Request.Form["tübitak"]);
                                    check[1] = !string.IsNullOrEmpty(Request.Form["kosgeb"]);
                                    check[2] = !string.IsNullOrEmpty(Request.Form["patent"]);
                                    check[3] = !string.IsNullOrEmpty(Request.Form["seker"]);
                                    check[4] = !string.IsNullOrEmpty(Request.Form["rehber"]);
                                    check[5] = !string.IsNullOrEmpty(Request.Form["ic"]);
                                    check[6] = !string.IsNullOrEmpty(Request.Form["sanayi"]);
                                    check[7] = !string.IsNullOrEmpty(Request.Form["bolge"]);
                                    check[8] = !string.IsNullOrEmpty(Request.Form["guven"]);
                                    check[9] = !string.IsNullOrEmpty(Request.Form["bilim"]);
                                    check[10] = !string.IsNullOrEmpty(Request.Form["verim"]);
                                    check[11] = !string.IsNullOrEmpty(Request.Form["meteoroloji"]);
                                    check[12] = !string.IsNullOrEmpty(Request.Form["AB"]);
                                    check[13] = !string.IsNullOrEmpty(Request.Form["Strateji"]);
                                    check[14] = !string.IsNullOrEmpty(Request.Form["Hukuk"]);
                                    check[15] = !string.IsNullOrEmpty(Request.Form["Personel"]);
                                    check[16] = !string.IsNullOrEmpty(Request.Form["Bilgi"]);
                                    check[17] = !string.IsNullOrEmpty(Request.Form["Destek"]);
                                    check[18] = !string.IsNullOrEmpty(Request.Form["TSE"]);
                                    check[19] = !string.IsNullOrEmpty(Request.Form["TÜBA"]);
                                    OnergeDBDataContext vt = new OnergeDBDataContext();
                                    for (int i = 0; i < 20; i++)
                                    {


                                        if (check[i] == true)
                                            sayac1 += 1;

                                    }

                                    for (int i = 0; i < sayac1; i++)
                                    {
                                        Onerge k = new Onerge
                                        {

                                            Donem = donem,
                                            YasamaYili = yasamaYili,
                                            EsasNo = esasNo,

                                            EvrakTarihi = evrakTarih,
                                            GeldigiKurumID = GkurumID,
                                            Extension = dosyayolu,
                                            durumID = durumID,
                                            TurID = turID,
                                            KonuGrupID = konuID,
                                            milletvekiliID = milletvekilID,
                                            BitisTarihi = bitis,
                                        };

                                        if (check[i] == true)
                                        {
                                            k.kurumID = i + 1;

                                        }


                                        var duzenle = vt.MilletVekilis.First(x => x.ID == k.milletvekiliID);
                                        duzenle.sayac += 1;



                                        var duzenle2 = vt.OnergeKonuGruplarıs.First(x => x.ID == k.KonuGrupID);
                                        duzenle2.KonuSayısı += 1;





                                        vt.Onerges.InsertOnSubmit(k);

                                        vt.SubmitChanges();
                                        OID++;


                                        Mesaj m = new Mesaj
                                        {

                                            IDM = OID,
                                            mesajKonusu = "Yeni Önergeniz Var!!",
                                            kurumID = i + 1,
                                            onergeID = k.ID


                                        };

                                        vt.Mesajs.InsertOnSubmit(m);


                                        vt.SubmitChanges();
                                        ViewBag.kaydedildi = "Önerge Başarıyla Kaydedilmiştir!";


                                    }
                                }
                                else
                                {
                                    ViewBag.konuUyari = "Önergenin Konu Grubunu Seçiniz!";



                                }
                            }
                            else
                            {
                                ViewBag.durumUyari = "Önergenin Durumunu Giriniz!";

                            }

                        }
                        else
                        {
                            ViewBag.vekilUyari = "Milletvekili Seçiniz!";

                        }
                    }
                    else
                    {
                        ViewBag.evrakUyari = "Evrak Tarihi Giriniz!";
                    }
                }
                else
                {
                    ViewBag.bitisUyari = "Bitiş Tarihini Giriniz!";
                }
        return View();
           
        }

        public ActionResult detayliGoster(string id)
        {
            ViewBag.sayi = 0;

            var detayliGoster = from o in vt.Onerges
                                join gk in vt.GKurums on o.GeldigiKurumID equals gk.ID
                               
                                join k in vt.Kurums on o.kurumID equals k.ID
                               
                                join d in vt.Durums on o.durumID equals d.ID
                                join m in vt.MilletVekilis on o.milletvekiliID equals m.ID
                                join kg  in vt.OnergeKonuGruplarıs on o.KonuGrupID equals kg.ID
                                select new
                                {
                                    o.ID,
                                    o.Donem,
                                    o.YasamaYili,
                                    o.EsasNo,
                                    o.BitisTarihi,
                                    o.EvrakTarihi,
                                    gk.GeldigiKurumAdi,
                                    k.KurumAd,
                                    d.Durum1,
                                    m.milletvekiliAdı,
                                    m.partisi,
                                    m.ili,
                                    kg.OnergeKonusu
                                   
                                };


            double sayfa = Convert.ToDouble(id);
            if (sayfa == 0)
            {
                sayfa = 1;
            }

         
            double kaçar = 3;

           
            double kaçtan = (sayfa * kaçar) - kaçar;

          
            double tamsayi = detayliGoster.Count();
            ViewBag.sayfasayisi = Math.Ceiling(tamsayi / kaçar);
           
            if (detayliGoster.Count() > 0)
            { 

                ViewBag.sayi = 1;
                var query2 = detayliGoster.Skip(Convert.ToInt32(kaçtan)).Take(Convert.ToInt32(kaçar));
                List<DetayliHelper> mList = new List<DetayliHelper>();
               
                foreach (var item in query2)
                {

                    DetayliHelper detay = new DetayliHelper();
                
                    detay.OnergeID = item.ID;
                    detay.Donem = Convert.ToInt32(item.Donem);
                    detay.YasamaYili = Convert.ToInt32(item.YasamaYili);
                    detay.EsasNo = Convert.ToInt32(item.EsasNo);
                    detay.MilletvekilAd = item.milletvekiliAdı;
                    detay.MPartisi = item.partisi;
                    detay.MIli = item.ili;
                    detay.EvrakTarihi = Convert.ToDateTime(item.EvrakTarihi);
                    detay.OnergeDurumu = item.Durum1;
                    detay.GeldigiKurum = item.GeldigiKurumAdi;
                    detay.sorumluPersonel = item.KurumAd;
                    detay.onergeKonusu = item.OnergeKonusu;
                  
                    detay.bitisTarihi = Convert.ToDateTime(item.BitisTarihi);
                    
                

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

     

        public ActionResult OnergeSil(int id)
        {
            if (id != null)
            {
                Onerge m = vt.Onerges.First(x => x.ID == id);

                Mesaj y = vt.Mesajs.First(x => x.IDM == id);
                Cevap c = new Cevap() ;

                MesajAdmin mA=new MesajAdmin();
                if (mA.onergeID != id && c.onergeID!=id)
                {
                    ViewBag.Mesaj = "Bu Önergeyi Silemesiniz.Silebilmeniz için Kullanıcının Bu Önergeyi Cevaplaması Gerekiyor!";
                }
                else { 
               
                    vt.Cevaps.First(x => x.onergeID== id);
                     vt.MesajAdmins.First(x => x.onergeID == id);

                vt.Onerges.DeleteOnSubmit(m);
                vt.Mesajs.DeleteOnSubmit(y);
                vt.Cevaps.DeleteOnSubmit(c);
                vt.MesajAdmins.DeleteOnSubmit(mA);
                vt.SubmitChanges();
                ViewBag.Sil = "Onerge Silindi.4 sn sonra yönlendiriliyorsunuz..";
              
                Response.AppendHeader("Refresh", "4;url=../detayliGoster");

                }
                return View();


            }

            return View();

        }


        public ActionResult kullaniciSil(int id)
        {

            if (id != null)
            {

                Kullanicilar m = vt.Kullanicilars.First(x => x.ID == id);

                vt.Kullanicilars.DeleteOnSubmit(m);
                vt.SubmitChanges();
                ViewBag.mASil = "Kullanıcı  silindi.";


                return RedirectToAction("KullaniciListele", "Admin");



            }

            return View();

        }


        public ActionResult KullaniciListele()
        {


            ViewBag.sayi = 0;

            var kullaniciListe = from o in vt.Kullanicilars
                                 join k in vt.Kurums on o.KurumID equals k.ID

                                 select new
                                 {
                                     o.ID,
                                     o.KullaniciAdi,
                                     o.Sifre,
                                     o.Email,
                                     o.Adi,
                                     o.Soyadi,
                                     k.KurumAd
                                 };


            if (kullaniciListe.Count() > 0)
            {



                ViewBag.sayi = 1;
                List<KullaniciHelper> mList = new List<KullaniciHelper>();
            
                foreach (var item in kullaniciListe)
                {

                    KullaniciHelper detay = new KullaniciHelper();
               
                    detay.KullaniciID = item.ID;
                    detay.kullaniciAdi = item.KullaniciAdi;
                    detay.sifre = item.Sifre;
                    detay.Email = item.Email;
                    detay.Ad = item.Adi;
                    detay.Soyad = item.Soyadi;
                    detay.kurumAd = item.KurumAd;


                    mList.Add(detay);


                }
                
                return View(mList);

            }
            else
            {
                ViewBag.sayi = 0;
                return View();
            }


        }

        public ActionResult kullaniciDuzenle(int id)
        {
            ViewBag.duzenle = "";
            var duzenle = vt.Kullanicilars.First(x => x.ID == id);


            return View(duzenle);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult kullaniciDuzenle(Kullanicilar o, FormCollection frm, HttpPostedFileBase file)
        {

            var onergeduz = vt.Kullanicilars.First(x => x.ID == o.ID);

            onergeduz.KullaniciAdi = o.KullaniciAdi;
            onergeduz.Sifre = o.Sifre;



            vt.SubmitChanges();

            ViewBag.duzenle = "Kullanıcı Düzenlendi!!";

            return View();
        }
      

        public ActionResult KullanıcıEkle()
        {

            kurum();
            if (Request.HttpMethod == "POST")
            {
                string ad = Request.Form.Get("txtAd");
                string soyad = Request.Form.Get("txtSoyAd");
                string Email = Request.Form.Get("txtEMail");
                string kullaniciAdi = Request.Form.Get("txtKullaniciAdi");
                int kurumID = Convert.ToInt32(Request.Form.Get("kurumlar"));




                string sifre = kullaniciAdi;
                string sifre1 = sifre.Substring(0, 5);




                OnergeDBDataContext vt = new OnergeDBDataContext();
                Kullanicilar k = new Kullanicilar
                {

                    Adi = ad,
                    Soyadi = soyad,
                    Email = Email,
                    KullaniciAdi = kullaniciAdi,
                    Sifre = sifre1,
                    KurumID = kurumID



                   
                };


                vt.Kullanicilars.InsertOnSubmit(k);
                vt.SubmitChanges();



            }

            return View();
        }
        public ActionResult sifreDegis()
        {




            if (Request.HttpMethod == "POST")
            {

                string sifreEski = Request.Form.Get("txtEskiSifreD");
                string sifreYeni = Request.Form.Get("txtYeniSifreD");
                string sifreOnay = Request.Form.Get("txtSifreOnayD");


                OnergeDBDataContext dc = new OnergeDBDataContext();


                Yöneticiler y = dc.Yöneticilers.First(k => k.ID == Convert.ToInt32(Session["id"]));
                if (sifreEski != null && sifreYeni != null && sifreOnay != null)
                {
                    if (sifreEski != y.Sifre)
                    {
                        ViewBag.uyari = "Yanlis Sifre Girdiniz.Lütfen şifrenizi doğru giriniz!!";
                    }
                    else
                    {
                        y.Sifre = sifreYeni;
                        if (sifreYeni.Contains("ğ") || sifreYeni.Contains("ü") || sifreYeni.Contains("i") ||
                            sifreYeni.Contains("ş") || sifreYeni.Contains("ç") || sifreYeni.Contains("ö") || sifreYeni.Contains("Ğ")
                            || sifreYeni.Contains("Ü") || sifreYeni.Contains("İ") || sifreYeni.Contains("Ş")
                            || sifreYeni.Contains("Ç") || sifreYeni.Contains("Ö"))
                        {

                            ViewBag.uyari1 = "Türkçe Karakter girmeyiniz!!";
                        }
                        else
                        {
                            if (sifreYeni.Contains(""))
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



      
     



        public ActionResult profilGuncelle()
        {
           
            ViewBag.duzenle = "";
            var duzenle = vt.Yöneticilers.First(x => x.ID == Convert.ToInt32(Session["id"]));


            return View(duzenle);

        }

        [HttpPost, ValidateInput(false)]
        public ActionResult profilGuncelle(Yöneticiler o, FormCollection frm, HttpPostedFileBase file)
        {

            var yoneticiDuz = vt.Yöneticilers.First(x => x.ID == o.ID);

            yoneticiDuz.kullaniciAdi = o.kullaniciAdi;
            yoneticiDuz.Sifre = o.Sifre;
            yoneticiDuz.Email = o.Email;
            yoneticiDuz.adi = o.adi;
            yoneticiDuz.soyadi = o.soyadi;
        




            vt.SubmitChanges();

            ViewBag.duzenle = "Yönetici Güncellendi!!";

            return View();
        }


        public void KurumlarDuzenle(int id)
        {
            List<SelectListItem> kurumList = new List<SelectListItem>();
            var kurumSorgu = from k in vt.Kurums select k;

            foreach (var item in kurumSorgu)
            {
                if (id == item.ID)
                {
                    kurumList.Add(new SelectListItem { Text = item.KurumAd, Value = item.ID.ToString(), Selected = true });
                }

                kurumList.Add(new SelectListItem { Text = item.KurumAd, Value = item.ID.ToString() });



            }

            ViewBag.kurumlar = kurumList;
        }


        public void GeldigiKurumDuzenle(int id)
        {
            List<SelectListItem> GeldigiKurumList = new List<SelectListItem>();
            var kurumSorgu = from k in vt.GKurums select k;

            foreach (var item in kurumSorgu)
            {
                if (id == item.ID)
                {
                    GeldigiKurumList.Add(new SelectListItem { Text = item.GeldigiKurumAdi, Value = item.ID.ToString(), Selected = true });
                }


                GeldigiKurumList.Add(new SelectListItem { Text = item.GeldigiKurumAdi, Value = item.ID.ToString() });


            }

            ViewBag.Gkurumlar = GeldigiKurumList;
        }






        public void KonuDuzenle(int id)
        {
            List<SelectListItem> konuList = new List<SelectListItem>();
            var konuSorgu = from d in vt.OnergeKonuGruplarıs select d;

            foreach (var item in konuSorgu)
            {
                if (id == item.ID)
                {
                    konuList.Add(new SelectListItem { Text = item.OnergeKonusu, Value = item.ID.ToString(), Selected = true });
                }

                konuList.Add(new SelectListItem { Text = item.OnergeKonusu, Value = item.ID.ToString() });

            }


            ViewBag.konuGrupları = konuList;
        }





        public void Onerge_MilletvekilDuzenle(int id)
        {
            List<SelectListItem> konuList = new List<SelectListItem>();
            var konuSorgu = from d in vt.MilletVekilis select d;

            foreach (var item in konuSorgu)
            {
                if (id == item.ID)
                {
                    konuList.Add(new SelectListItem { Text = item.milletvekiliAdı, Value = item.ID.ToString(), Selected = true });
                }

                konuList.Add(new SelectListItem { Text = item.milletvekiliAdı, Value = item.ID.ToString() });

            }


            ViewBag.milletvekil = konuList;
        }
        public void durumDuzenle(int id)
        {
            List<SelectListItem> konuList = new List<SelectListItem>();
            var konuSorgu = from d in vt.Durums select d;

            foreach (var item in konuSorgu)
            {
                if (id == item.ID)
                {
                    konuList.Add(new SelectListItem { Text = item.Durum1, Value = item.ID.ToString(), Selected = true });
                }

                konuList.Add(new SelectListItem { Text = item.Durum1, Value = item.ID.ToString() });

            }


            ViewBag.durumlar = konuList;
        }
       public ActionResult OnergeDuzenle(int id)
        {
            ViewBag.duzenle = "";
            var duzenle = vt.Onerges.First(x => x.ID == id);
            KurumlarDuzenle(Convert.ToInt32(duzenle.kurumID));
            GeldigiKurumDuzenle(Convert.ToInt32(duzenle.GeldigiKurumID));
            KonuDuzenle(Convert.ToInt32(duzenle.KonuGrupID));
            Onerge_MilletvekilDuzenle(Convert.ToInt32(duzenle.milletvekiliID));
            durumDuzenle(Convert.ToInt32(duzenle.durumID));

            return View(duzenle);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult OnergeDuzenle(Onerge o, FormCollection frm, HttpPostedFileBase file)
        {
            int kurumid = Convert.ToInt32(frm.Get("kurumlar"));
            int gkurumid = Convert.ToInt32(frm.Get("Gkurumlar"));
            int konuid = Convert.ToInt32(frm.Get("konuGrupları"));
            int miID = Convert.ToInt32(frm.Get("milletvekil"));
            int durumID = Convert.ToInt32(frm.Get("durumlar"));
            var onergeduz = vt.Onerges.First(x => x.ID == o.ID);
            
            onergeduz.YasamaYili = o.YasamaYili;
            onergeduz.EsasNo = o.EsasNo;
            onergeduz.EvrakTarihi = o.EvrakTarihi;
        
            onergeduz.Donem = o.Donem;
            onergeduz.milletvekiliID = miID;
            onergeduz.MilletvekilPartisiIli = o.MilletvekilPartisiIli;
            onergeduz.kurumID = kurumid;
            onergeduz.GeldigiKurumID = gkurumid;
            onergeduz.KonuGrupID = konuid;
            onergeduz.durumID = durumID;

            vt.SubmitChanges();
            kurum();
            Gkurum();
            Konu();
            milletvekil();
            durum();
            ViewBag.duzenle = "Onerge Düzenlendi";

            return View();
        }
        public ActionResult MilletvekiliEkle()
        {
            return View();
        }
        [HttpPost]
        public ActionResult MilletvekiliEkle(FormCollection frm)
        {
            string mIsim = frm.Get("txtAdıSoyadı");
            string mParti = frm.Get("txtPartisi");
            string mIl = frm.Get("txtIli"); 
            int onergeSayısı = 0;
            OnergeDBDataContext vt = new OnergeDBDataContext();
            MilletVekili m = new MilletVekili
            {
                milletvekiliAdı = mIsim,
               partisi=mParti,
               ili=mIl,
              
                sayac = onergeSayısı
            };

            vt.MilletVekilis.InsertOnSubmit(m);
            vt.SubmitChanges();

            return RedirectToAction("MilletvekiliListele", "Admin");

        }


        public ActionResult MilletvekilDüzenle(int id)
        {
            ViewBag.duzenle = "";
            var duzenle = vt.MilletVekilis.First(x => x.ID == id);
          

            return View(duzenle);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult MilletvekilDüzenle(MilletVekili o, FormCollection frm, HttpPostedFileBase file)
        {
        
            var vekilDuz = vt.MilletVekilis.First(x => x.ID == o.ID);
           
            vekilDuz.milletvekiliAdı = o.milletvekiliAdı;
            vekilDuz.partisi = o.partisi;
            vekilDuz.ili = o.ili;

            vt.SubmitChanges();
           
            ViewBag.duzenle = "Milletvekili Düzenlendi";

            return View();
        }
        public ActionResult MilletvekilSil(int id)
        {
 
            if (id != null)
            {

                MilletVekili m = vt.MilletVekilis.First(x => x.ID == id);

                vt.MilletVekilis.DeleteOnSubmit(m);
                vt.SubmitChanges();
                ViewBag.mASil = "Milletvekili  silindi.";

                return RedirectToAction("MilletvekiliListele", "Admin");
 
            }

            return View();

        }


        public ActionResult MilletvekiliListele()
        {

            List<MilletVekili> vekilListesi = vt.MilletVekilis.ToList();
            ViewBag.Milletvekilleri = vekilListesi;
            return View();
        }
        public void MilletvekiliAdı()
        {
            List<SelectListItem> vekilList = new List<SelectListItem>();
            var vekilSorgu = from d in vt.MilletVekilis select d;

            foreach (var item in vekilSorgu)
            {
                vekilList.Add(new SelectListItem { Text = item.milletvekiliAdı, Value = item.ID.ToString() });


            }

            ViewBag.milletvekiliAdı = vekilList;
        }
        public ActionResult KonuEkle()
        {
            return View();
        }
        [HttpPost]
        public ActionResult KonuEkle(FormCollection frm)
        {
            string kAdı = frm.Get("txtKonuAdı");
            int konuSayısı = 0;
            OnergeDBDataContext vt = new OnergeDBDataContext();
            OnergeKonuGrupları m = new OnergeKonuGrupları
            {
                OnergeKonusu = kAdı,
              
                KonuSayısı = konuSayısı
            };

            vt.OnergeKonuGruplarıs.InsertOnSubmit(m);
            vt.SubmitChanges();

            return View();
        }
      
        public ActionResult KonuListele()
        {

            List<OnergeKonuGrupları> konuListesi = vt.OnergeKonuGruplarıs.ToList();
            ViewBag.Konular = konuListesi;
            return View();
        }

        public ActionResult KonuDuzenle2(int id)
        {
            ViewBag.duzenle = "";
            var duzenle = vt.OnergeKonuGruplarıs.First(x => x.ID == id);


            return View(duzenle);
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult KonuDuzenle2(OnergeKonuGrupları o, FormCollection frm, HttpPostedFileBase file)
        {

            var onergeduz = vt.OnergeKonuGruplarıs.First(x => x.ID == o.ID);

            onergeduz.OnergeKonusu = o.OnergeKonusu;


            vt.SubmitChanges();

            ViewBag.duzenle = "Önerge Konusu Düzenlendi!!";

            return View();
        }
        public ActionResult KonuSil(int id)
        {

            if (id != null)
            {

                OnergeKonuGrupları m = vt.OnergeKonuGruplarıs.First(x => x.ID == id);

                vt.OnergeKonuGruplarıs.DeleteOnSubmit(m);
                vt.SubmitChanges();
                ViewBag.mASil = "Önerge Konusu   silindi.";


                return RedirectToAction("KonuListele", "Admin");



            }

            return View();

        }




        public ActionResult Cikis()
        {

            return RedirectToAction("Login", "Login");




        }



        public ActionResult SilA(int id)
        {
            if (id != null)
            {
               
                MesajAdmin m = vt.MesajAdmins.First(x => x.IDM == id);
               
                vt.MesajAdmins.DeleteOnSubmit(m);
                vt.SubmitChanges();
                ViewBag.mASil = "Mesaj Silindi.2 sn sonra yönlendiriliyorsunuz..";
                Response.AppendHeader("Refresh", "2;url=../Index");


                return View();


            }

            return View();

        }

        [HttpGet]
        public ActionResult dosyaPdfA(int id)
        {
            var cevapGoster = from o in vt.Cevaps
                              

                              where  o.CevapID == id 


                                
                                  select new
                                  {
                                     o.uzanti

                                  };



            foreach (var item in cevapGoster)
            {
                string FilePath = Server.MapPath(item.uzanti);
                WebClient User = new WebClient();
                Byte[] FileBuffer = User.DownloadData(FilePath);

                Response.Clear();
                Response.ClearHeaders();
                Response.AppendHeader("content-disposition", "attachment; filename=" + item.uzanti);
                Response.TransmitFile(item.uzanti);
                Response.Flush();
                Response.End();
            
               
            }
  return View();  }
       public ActionResult sonOnergeAdmin(int id)
        {


            ViewBag.sayi = 0;

            

            var sonOnergeA = from o in vt.Cevaps
                             from p in vt.Kullanicilars
                             from h in vt.MesajAdmins
                             from j in vt.MilletVekilis
                             from jk in vt.OnergeKonuGruplarıs

                           

                             join q in vt.Kurums on o.kurumID equals q.ID

                         


                             where o.onergeID == h.onergeID && h.onergeID == id && o.kurumID == p.KurumID

                             select new
                             {

                                 h.mesajKonusu,
                                 q.KurumAd,
                                 o.CevapID,
                                 o.uzanti
                             };


            if (sonOnergeA.Count() > 0)
            { 

                ViewBag.sayi = 1;

                List<KullaniciHelper> mList = new List<KullaniciHelper>();
             
                foreach (var item in sonOnergeA)
                {

                   
                    KullaniciHelper detay = new KullaniciHelper();



                
                    detay.Amesaj = item.mesajKonusu;
                    detay.kurumAd = item.KurumAd;
                    detay.cevapID = item.CevapID;
                  
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
      public ActionResult Rapor()
        {
            return View();
        }
      public ActionResult MilletvekiliAra()
      {
          return View();
      }

        [HttpPost]
      public ActionResult MilletvekiliAra(FormCollection frm)
      {

          string milletvekilAd = frm.Get("txtMAd");
          ViewBag.sayi = 0;
            var ad = from m in vt.MilletVekilis
                     from o in vt.Onerges
                     join k in vt.Kurums on o.kurumID equals k.ID
                     join gk in vt.GKurums on o.GeldigiKurumID equals gk.ID
                     join d in vt.Durums on o.durumID equals d.ID
                     join j in vt.OnergeKonuGruplarıs on o.KonuGrupID equals j.ID
                     where milletvekilAd == m.milletvekiliAdı && o.milletvekiliID==m.ID
                     select new
                     {
                         o.Donem,
                         o.YasamaYili,
                         o.EsasNo,
                         o.EvrakTarihi,
                         gk.GeldigiKurumAdi,
                         m.milletvekiliAdı,
                         o.MilletvekilPartisiIli,
                         k.KurumAd,
                         d.Durum1,
                         j.OnergeKonusu




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

      
      

      
    }
}
