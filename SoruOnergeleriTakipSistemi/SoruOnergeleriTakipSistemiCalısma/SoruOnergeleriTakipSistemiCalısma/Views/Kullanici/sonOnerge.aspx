<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteKullanici.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.Models.KullaniciHelper>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    SonOnerge</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<article class="module width_full">
<header> <h3>Son Önerge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </h3></header>
    <%if( ViewBag.sayi>0){%>

    <table class="tablesorter">
        <tr>
            <%Response.Write(ViewBag.Uyari); %>

             <td><b>Evrak Tarihi</b></td>
              <td><b>Dönem</b></td>
            <td><b>Yasama Yılı</b></td>
              <td><b>Esas No</b></td>
             <td><b>Milletvekili</b></td>
               <td><b>Partisi</b></td>
             <td><b>Önerge Durumu</b></td>
             <td><b>Önerge Konusu</b></td>
            <td><b>Geldiği Kurum</b></td>
             <td><b>Dosya</b></td>
               <td><b>Kalan Süre</b></td> 
             <td><b>Cevapla</b></td>
          
        </tr>
     
         <%foreach(var item in  Model)
          {   %>
          
            <tr>
   
                <td class="auto-style1"><%=Html.DisplayName(item.evrakTime.ToLongDateString()) %></td>
                 <td class="auto-style1"><%=Html.DisplayName(item.donem.ToString()) %></td>
                 <td class="auto-style1"><%=Html.DisplayName(item.yasamaYili.ToString()) %></td>
                 <td class="auto-style1"><%=Html.DisplayName(item.esasNo.ToString()) %></td>
                  <td class="auto-style1"><%=Html.DisplayName(item.milletvekiliAd) %></td>
                  <td class="auto-style1"><%=Html.DisplayName(item.milletvekilParti) %></td>
                  <td class="auto-style1"><%=Html.DisplayName(item.durum) %></td>
                   <td class="auto-style1"><%=Html.DisplayName(item.konu) %></td>
                  <td class="auto-style1"><%=Html.DisplayName(item.gKurum) %></td>
                 <td class="auto-style1"> <%: Html.ActionLink("indir", "DosyaYukle", new { id = item.onergeID })%></td>
         
                    <% TimeSpan fark = item.bitisTarihi - DateTime.Today;
                      double days=fark.TotalDays;%>

                      <%if (Convert.ToInt32(days.ToString()) > 0)
                        {%>
                          <td><h3 style="color:blue"><% Response.Write(days.ToString() + " gün kaldı");%></h3></td>
                   
                          <td> <%: Html.ActionLink("Cevapla", "onergeCevap", new { id = item.onergeID })%></td>
                          
                     <% }%>
                        
                       
                 <%if(days.ToString()=="0"){%>
                   <td> <h3 style="color:darkred">  <%   Response.Write("Son Gün!!!");%></h3></td>
                <td> <%: Html.ActionLink("Cevapla", "onergeCevap", new { id = item.onergeID })%></td>
              <%  }%>
                  
                   <%if(Convert.ToInt32(days.ToString())<0){%>
                <td><% Response.Write("------");%></td>
              <td><h3 style="color:red">   <%   Response.Write("Süreniz Doldu!!");%></h3></td>
              <%  }%>

                <%break; %>
  
            </tr>  
              
              <%} %>

    </table>
    <%} 
      else Response.Write("Herhangi bir kayıt bulunamadı..");   %>

    </article>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 126px;
        }
    </style>
</asp:Content>
