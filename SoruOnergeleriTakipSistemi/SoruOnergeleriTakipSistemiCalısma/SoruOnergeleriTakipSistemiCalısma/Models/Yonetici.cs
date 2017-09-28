using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoruOnergeleriTakipSistemiCalısma.Models
{
    public class Yonetici
    {
        public string  adi { get; set; }
        public string id{ get; set; }
        OnergeDBDataContext vt = new OnergeDBDataContext();
        public void getAdi(int id)
        {
            var result = from y in vt.Yöneticilers where y.ID == id select new { y.adi };
            foreach (var item in result)
            {
                adi = item.adi;

            }


        }
        public void getID(int id)
        {
            var result = from y in vt.MesajAdmins where y.IDM == id select new { y.IDM };
            foreach (var item in result)
            {
               id = item.IDM;

            }
        }
    }
}