using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoruOnergeleriTakipSistemiCalısma.Models
{
    public class DetayliHelper
    {

        public int OnergeID { get; set; }
        public int Donem { get; set; }
        public int YasamaYili { get; set; }
        public int EsasNo { get; set; }
        public string  MilletvekilAd { get; set; }
        public string MPartisi { get; set; }
        public string MIli { get; set; }
        public DateTime EvrakTarihi { get; set; }
        public string  OnergeDurumu { get; set; }
        public int okunma { get; set; }
        public string  GeldigiKurum { get; set; }
        public string onergeKonusu { get; set; }
        public string sorumluPersonel { get; set; }
        public string MilletvekilPartisiIli { get; set; }
        public DateTime bitisTarihi { get; set; }
      //  public string sorumluPersonelAdi { get; set; }



    }
}