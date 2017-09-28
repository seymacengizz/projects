using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoruOnergeleriTakipSistemiCalısma.Models
{
    public class KullaniciHelper
    {
        public int KullaniciID { get; set; }
        public string sifre { get; set; }
        public string milletvekiliAd { get; set; }
        public string milletvekilParti { get; set; }
        public string milletvekilIli { get; set; }
          
           
        
            public string kullaniciAdi { get; set; }
          
            public string Email { get; set; }
            public string Ad { get; set; }
            public string kAd { get; set; }
            public string Soyad { get; set; }
            public string kurumAd { get; set; }
            public DateTime evrakTime { get; set; }
            public int donem { get; set; }
            public int yasamaYili { get; set; }
            public int  esasNo { get; set; }
      
            public string  gKurum { get; set; }
            public string  dosya { get; set; }
            public int onergeID { get; set; }
            public int cevapID { get; set; }
            public string  mesaj { get; set; }
            public int okunma { get; set; }
            public int Aokunma { get; set; }
            public int mesajID { get; set; }
            public int AmesajID { get; set; }
            public string  Amesaj { get; set; }
            public string durum { get; set; }
            public string konu { get; set; }
            public string uyari { get; set; }
            public string uzanti { get; set; }
            public int kurumID { get; set; }
            public DateTime bitisTarihi { get; set; }
          
        
    }
}