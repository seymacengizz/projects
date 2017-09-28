<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Onerge>" %>



<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    OnergeKayit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

  

        <article class="module width_full">
            <header>
                <h3>Önerge Kayıt</h3>
            </header>


            <%using (Html.BeginForm("OnergeKayit", "Admin", FormMethod.Post, new {enctype="multipart/form-data"}))
              { %>

            <table>

                  <tr>
                    <td class="auto-style2">Önerge Türü</td>
                         <td><%:Html.DropDownList("Tür") %></td>
                </tr>


                <tr>
                    <td class="auto-style2">Dönem</td>
                    <td class="auto-style1"><%:Html.TextBox("txtDonem") %></td>
                </tr>
                <tr>
                    <td class="auto-style2">Yasama Yılı</td>
                    <td class="auto-style1"><%:Html.TextBox("txtYasamaYili") %></td>
                </tr>
                <tr>
                    <td class="auto-style2">Esas No</td>
                    <td class="auto-style1"><%:Html.TextBox("txtEsasNo") %></td>
                </tr>
              
                <tr>
                    <td class="auto-style2">Milletvekil Adı</td>
                    <td><%:Html.DropDownList("milletvekil") %></td>
                 
                    </tr>
           
                <tr>
                    <td class="auto-style2">Evrak Tarihi</td>
                    <td><div class="demo"> 
                      <input type="text" id="datepicker" name="txtEvrakTarihi">
                      <p  style="color:red"><b> <%Response.Write(ViewBag.evrakUyari); %></b></p>
                      </div>
                     </td>
                </tr>
                
                    <tr>
                    <td class="auto-style2">Önerge Konu Grubu</td>
                    <td><%:Html.DropDownList("konuGrupları") %></td>
                </tr>

                  <tr>
                    <td class="auto-style2">Önergenin Konusu</td>
                    <td class="auto-style1"><%:Html.TextArea("txtOnergeKonusu") %></td>
                </tr>

               <tr>
                    <td class="auto-style2">Önerge Durumu</td>
                    <td><%:Html.DropDownList("durumlar") %></td>
                    </tr>
                      <tr>
                    <td class="auto-style2">Geldiği Kurum</td>
                    <td><%:Html.DropDownList("Gkurumlar") %></td>
                    </tr>
                
                <tr>
                    <td >Dosya Yükleme İçerik</td>
                    <td><%:Html.TextBox("file", "", new { @type = "file" })%></td>
                </tr>

              <tr>
                    <td class="auto-style2">Son Cevaplama Tarihi</td>
                    <td><div class="demo"> 
                      <input type="text" id="datepicker1" name="txtBitisTarihi">
                          <p  style="color:red"><b> <%Response.Write(ViewBag.bitisUyari); %></b></p>
                        
                      </div>
                     </td>
                </tr>

                 <tr>
                    <td class="auto-style2">Bilgi İstenen Kurumlar</td>
                        
                   <td><div id="list1" class="dropdown-check-list" tabindex="100"   >
                    <span class="anchor">Kurum Seç</span>
                     <ul class="items">
                <li>
                            <input type="checkbox"  class="chkclass" name="tübitak" />Tübitak
                         
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="kosgeb"/>KOSGEB
                         
                         </li>

                          <li>
                            <input type="checkbox"  class="chkclass" name="patent"/>Türk Patent Enstitüsü
                          
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="seker"/>Şeker Kurumu
                          
                         </li>

                         <li>
                            <input type="checkbox"  class="chkclass" name="rehber"/>Rehnerlik ve Teftiş Başkanlığı
                          
                         </li>
                         <li>
                            <input type="checkbox"  class="chkclass" name="ic"/>İç Denetim Birimi Başkanlığı
                          
                         </li>
                         <li>
                            <input type="checkbox"  class="chkclass" name="sanayi"/>Sanayi Genel Müdürlüğü
                          
                         </li>
                         <li>
                            <input type="checkbox"  class="chkclass" name="bolge"/>Sanayi Bölgeleri Genel Müdürlüğü
                          
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="guven"/>Sanayi Ürünleri Güvenliği ve Denetimi Genel Müdürlüğü
                          
                         </li>
                           <li>
                            <input type="checkbox"  class="chkclass" name="bilim"/>Bilim ve Teknoloji Genel Müdürlüğü
                          
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="verim"/>Verimlilik Genel Müdürlüğü
                          
                         </li>
                           <li>
                            <input type="checkbox"  class="chkclass" name="meteoroloji"/>Meteoroloji ve Standardizasyon Genel Müdürlüğü
                          
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="AB"/>Avrupa Birliği ve Dış İlişkiler Genel Müdürlüğü
                          
                         </li>
                         <li>
                            <input type="checkbox"  class="chkclass" name="Strateji"/>Strateji Geliştirme Başkanlığı
                          
                         </li>
                         <li>
                            <input type="checkbox"  class="chkclass" name="Hukuk"/>Hukuk Müşavirliği
                          
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="Personel"/>Personel Dairesi Başkanlığı
                          
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="Bilgi"/>Bilgi İşlem Dairesi Başkanlığı
                          
                         </li>
                         <li>
                            <input type="checkbox"  class="chkclass" name="Destek"/>Destek Hizmetleri Dairesi Başkanlığı
                          
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="TSE"/>TSE
                          
                         </li>
                          <li>
                            <input type="checkbox"  class="chkclass" name="TÜBA"/>TÜBA
                          
                         </li>
                 </ul>
                    
                     </div>

                      </td>         
                </tr>
  <tr>
                    <td colspan="2">

                        <br />

                        <input type="submit" value="Kaydet" onclick="return validate();" /><br />
                           <p  style="color:blue"><b> <%Response.Write(ViewBag.kaydedildi); %></b></p>
                           <p  style="color:red"><b> <%Response.Write(ViewBag.vekilUyari); %> </b></p>
                          <p  style="color:red"><b> <%Response.Write(ViewBag.durumUyari); %> </b></p>
                          <p  style="color:red"><b> <%Response.Write(ViewBag.konuUyari); %> </b></p>
                           
                        <br />
                    </td>
                </tr>
            </table>
 <%} %>
        </article>


      <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">


   


  <script>
  $(document).ready(function () {
          $("form").submit(function () {
              if ($('input:checkbox').filter(':checked').length < 1) {
                  alert("En az Bir tane Kurum seçmelisiniz!");
                  return false;
              }
          });
  });

  
$(function () {
          $("#datepicker").datepicker({
              changeMonth: true,
              changeYear: true,
              dateFormat: 'dd/mm/yy'
          });
        
      });
      $(function () {
          $("#datepicker1").datepicker({
              changeMonth: true,
              changeYear: true,
              dateFormat: 'dd/mm/yy'

          });
      });


  </script>


     <script type="text/javascript">


         var checkList = document.getElementById('list1');
         checkList.getElementsByClassName('anchor')[0].onclick = function (evt) {
             if (checkList.classList.contains('visible'))
                 checkList.classList.remove('visible');
             else
                 checkList.classList.add('visible');
         }

        
         $(function () {
             $("select").multiselect();
         });

      

     

         function validate() {
          var konu=document.getElementById("txtOnergeKonusu");
          var donem = document.getElementById("txtDonem");
          var yasamaYili = document.getElementById("txtYasamaYili");
          var esasNo = document.getElementById("txtEsasNo");
          var dosya = document.getElementById("file");
          var eTarih = document.getElementById("txtEvrakTarihi");

          
          if (dosya.value == "") {

              alert("Dosya Seçiniz!");
              return false;
          }
             if(konu.value==""){

                 alert("Önergenin Konusu Boş Girilemez!");
                 return false;
             }
             if (donem.value == 0) {

                 alert("Dönem Boş Girilemez!");
                 return false;
             }
             if (yasamaYili.value == 0) {

                 alert("Yasama Yılı Boş Girilemez!");
                 return false;
             }
             if (esasNo.value == 0) {

                 alert("Esas No Boş Girilemez!");
                 return false;
             }
             if (eTarih.value == null) {

                 alert("Evrak Tarihi Seçiniz!");
                 return false;
             }
         }
         
    </script>


<style type="text/css">
        .auto-style1 {
            width: 618px;
        }
        .auto-style2 {
            width: 218px;
        }

    .dropdown-check-list {
  display: inline-block;
  
}
.dropdown-check-list .anchor {
  position: relative;
  cursor: pointer;
  display: inline-block;
  padding: 5px 50px 5px 10px;
  border: 1px solid #ccc;
}
.dropdown-check-list .anchor:after {
  position: absolute;
  content: "";
  border-left: 2px solid black;
  border-top: 2px solid black;
  padding: 5px;
  right: 10px;
  top: 20%;
  -moz-transform: rotate(-135deg);
  -ms-transform: rotate(-135deg);
  -o-transform: rotate(-135deg);
  -webkit-transform: rotate(-135deg);
  transform: rotate(-135deg);

}
.dropdown-check-list .anchor:active:after {
  right: 8px;
  top: 21%;
}
.dropdown-check-list ul.items {
  padding: 2px;
  display: none;
  margin: 0;
  border: 1px solid #ccc;
  border-top: none;
}
.dropdown-check-list ul.items li {
  list-style: none;
}
.dropdown-check-list.visible .anchor {
  color: #0094ff;
}
.dropdown-check-list.visible .items {
  display: block;
}
  </style>  
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
   
</asp:Content>



