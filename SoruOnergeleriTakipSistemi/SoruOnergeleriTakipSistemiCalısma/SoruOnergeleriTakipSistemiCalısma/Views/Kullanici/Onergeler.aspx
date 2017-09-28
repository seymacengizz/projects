<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteKullanici.Master"  Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.Models.KullaniciHelper>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Önergeler
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<article class="module width_full">
    <header><h3>Önergeler</h3></header>

    <style>linkdisabled:visited{
   cursor:text;
}

        </style>
    <%if( ViewBag.sayi>0){%>

    
    <table class="tablesorter">
        <tr>

   

            <%Response.Write(ViewBag.Uyari); %>

             <td><b>Evrak Tarihi</b></td>
              <td><b>Dönem</b></td>
            <td><b>Yasama Yılı</b></td>
              <td><b>Esas No</b></td>
            <td><b>Önergenin Geldiği Yer</b></td>
             <td><b>Milletvekili</b></td>
               <td><b>Partisi</b></td> 
             <td><b>Önerge Durumu</b></td>
             <td><b>Önerge Konusu</b></td>
            <td><b>Geldiği Kurum</b></td>
             <td><b>Önerge İndir</b></td>
             <td><b>Kalan Süre</b></td>
              <td><b>Önerge Cevapla</b></td>
        </tr>

         <%foreach(var item in  Model)
          {   %>
              
     
           
            <tr>
   
        <td><%=Html.DisplayName(item.evrakTime.ToLongDateString()) %></td>
         <td><%=Html.DisplayName(item.donem.ToString()) %></td>
          <td><%=Html.DisplayName(item.yasamaYili.ToString()) %></td>
           <td><%=Html.DisplayName(item.esasNo.ToString()) %></td>
           <td><%=Html.DisplayName(item.milletvekiliAd) %></td>
           <td><%=Html.DisplayName(item.milletvekilParti) %></td>
            <td><%=Html.DisplayName(item.milletvekilIli) %></td>
          <td><%=Html.DisplayName(item.durum) %></td>
            <td><%=Html.DisplayName(item.konu) %></td>
           <td><%=Html.DisplayName(item.gKurum) %></td>
           <td> <%: Html.ActionLink("indir", "DosyaYukle", new { id = item.onergeID })%></td>
              
             
        
                <% TimeSpan fark = item.bitisTarihi - DateTime.Today;
                      double days=fark.TotalDays;
                      if (Convert.ToInt32(days.ToString()) > 0) { %>
                      <td><h3 style="color:blue"><% Response.Write(days.ToString() + " gün kaldı");%></h3></td>

                           <td> <%: Html.ActionLink("Cevapla", "onergeCevap", new { id = item.onergeID })%></td>
                           
                    <%  }   %></h3>
                 <%if(days.ToString()=="0"){%>
              <td> <h3 style="color:darkred">  <%   Response.Write("Son Gün!!!");%></h3></td>
                <td> <%: Html.ActionLink("Cevapla", "onergeCevap", new { id = item.onergeID })%></td>
              <%  }%>
                  
                   <%if(Convert.ToInt32(days.ToString())<0){%>
            
              <td><h3 style="color:red">   <%   Response.Write("Süreniz Doldu!!");%></h3></td>
                 <td><% Response.Write("------");%></td>
              <%  }%>
                 
          
              </tr>
            
              <%} %>
       


    </table>
    <%} 
      else{ Response.Write("Herhangi bir kayıt bulunamadı.."); }  %>
    <ul><% int sayfasayisi = Convert.ToInt32(ViewBag.sayfasayisi);
                 if(sayfasayisi>1)
                 {
                     for(int i=1;i<=sayfasayisi;i++)
                     {

                         %><%:Html.ActionLink(i.ToString(),"Onergeler",new{id=i})%>
                    <% }
                 }
                 %>

          </ul>
    
    </article>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
