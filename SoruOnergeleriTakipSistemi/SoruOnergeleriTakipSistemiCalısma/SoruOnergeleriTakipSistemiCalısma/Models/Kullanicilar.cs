using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoruOnergeleriTakipSistemiCalısma.Models
{
    public class Kullanicilar
    {
        public string  adi { get; set; }
        OnergeDBDataContext vt = new OnergeDBDataContext();
        public void getAdi(int id)
        {
            var result = from y in vt.Kullanicilars where y.ID == id select new { y.Adi };
            foreach (var item in result)
            {
                adi = item.Adi;

            }
        }



    }
}