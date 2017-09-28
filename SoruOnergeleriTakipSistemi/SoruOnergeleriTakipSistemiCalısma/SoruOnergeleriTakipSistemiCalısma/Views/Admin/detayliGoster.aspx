<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.Models.DetayliHelper>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    detayliGoster
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<article class="module width_full">
    <header><h3>Detaylı Göster</h3></header>
    <%if( ViewBag.sayi>0){%>

    <!--detayHelper classı burda IEnumarable sayasınde dızı olarak donuyo.
        Yanı claasıı view sayfasına gosterdık-->
    <!-- listeleme olayını yapcaz burda-->
    <table class="tablesorter">
        <tr>

     
      <td ><b>Dönem</b></td>
      <td><b>Yasama Yili</b></td>
      <td><b>Esas No</b></td>
      <td><b>Milletvekil Adı</b></td>
             <td><b>Partisi</b></td>
             <td><b>İli</b></td>
      <td><b>Evrak Tarihi</b></td>
      <td><b>Onerge Durumu</b></td>
      <td><b>Önerge Konusu</b></td>
      <td><b>Geldigi Kurum</b></td>
           
      <td><b>Sorumlu Kurum</b></td>
            <td><b>Kalan Süre</b></td>
            <td><b>Düzenle</b></td>
             <td><b>Sil</b></td>


        </tr>
        <%foreach(var item in  Model)
          {   %>
      
            <tr>
   
       <td><%=Html.DisplayName(item.Donem.ToString()) %></td>
        <td><%=Html.DisplayName(item.YasamaYili.ToString()) %></td>
         <td><%=Html.DisplayName(item.EsasNo.ToString()) %></td>
          <td><%=Html.DisplayName(item.MilletvekilAd) %></td>
          <td><%=Html.DisplayName(item.MPartisi) %></td>
           <td><%=Html.DisplayName(item.MIli) %></td>
           <td><%=Html.DisplayName(item.EvrakTarihi.ToLongDateString()) %></td>


             <td><%=Html.DisplayName(item.OnergeDurumu) %></td>
                <td><%=Html.DisplayName(item.onergeKonusu) %></td>

             <td><%=Html.DisplayName(item.GeldigiKurum) %></td>
              <td><%=Html.DisplayName(item.sorumluPersonel) %></td>
          <% TimeSpan fark = item.bitisTarihi - DateTime.Today;
                      double days=fark.TotalDays;
                      if (Convert.ToInt32(days.ToString()) > 0) { %>
                      <td><h3 style="color:blue"><% Response.Write(days.ToString() + " gün kaldı");%></h3></td>

                           
                    <%  }   %></h3>
                 <%if(days.ToString()=="0"){%>
              <td> <h3 style="color:darkred">  <%   Response.Write("Son Gün!!!");%></h3></td>
          
              <%  }%>
                  
                   <%if(Convert.ToInt32(days.ToString())<0){%>
            
              <td><h3 style="color:red">   <%   Response.Write("Süre Doldu!!");%></h3></td>
               
              <%  }%>
                <td><%:Html.ActionLink("Düzenle","OnergeDuzenle",new{id=item.OnergeID})%></td>
                <td><%:Html.ActionLink("Sil","OnergeSil",new{id=item.OnergeID} )%></td>
                

            </tr>  
              
              <%} %>


    </table>
    <%} 
      else Response.Write("Herhangi bir kayıt bulunamadı..");   %>

    
     <ul><% int sayfasayisi = Convert.ToInt32(ViewBag.sayfasayisi);
                 if(sayfasayisi>1)
                 {
                     for(int i=1;i<=sayfasayisi;i++)
                     {
                         
                         %><%:Html.ActionLink(i.ToString(),"DetayliGoster",new{id=i})%>
                    <% }
                 }
                 %>

          </ul>
    
     </article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
