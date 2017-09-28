using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SoruOnergeleriTakipSistemiCalısma.Models
{
    public class CevapMesaj : Controller
    {

        public string id { get; set; }
        OnergeDBDataContext vt = new OnergeDBDataContext();
        public void getID(int id)
        {
            //var result = from y in vt.MesajAdmins 
            //             where vt.MesajAdmins.Select(u1 => u1.IDM);
                      
            //foreach (var item in result)
            //{
            //    id = item.IDM;
               

            //}


        }
    }
}
