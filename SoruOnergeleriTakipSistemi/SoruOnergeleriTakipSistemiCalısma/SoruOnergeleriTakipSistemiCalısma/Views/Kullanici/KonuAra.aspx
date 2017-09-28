<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteKullanici.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.Models.DetayliHelper>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Konu Ara
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2  align="center">Konu  Ara</h2>

    <%if (ViewBag.sayi > 0)
      { %>
<table class="tablesorter">
    <tr>
        

        <td><b>Önerge Konu </b></td>
      
        <td><b>Geldiği Kurum</b></td>
       <td> <b>Önerge Durumu</b></td>
        <td><b> Milletvekil Adı</b></td>
          <td><b> Partisi/İli</b></td>
        
      
        <td><b>Evrak Tarihi</b></td>
        
     

      
    </tr>
    
<% foreach (var item in Model)
   { %>
    <tr>
       
          <td>
            <%: Html.DisplayFor(modelItem => item.onergeKonusu)%>
        </td> 
        
        <td>
            <%: Html.DisplayFor(modelItem => item.GeldigiKurum)%>
        </td>
         
         <td>
            <%: Html.DisplayFor(modelItem => item.OnergeDurumu)%>
        </td>
          <td>
             <%: Html.DisplayFor(modelItem => item.MilletvekilAd)%>
        </td>
        <td>

             <%: Html.DisplayFor(modelItem => item.MilletvekilPartisiIli)%>
        </td>
         <td>
          <%=Html.DisplayName(item.EvrakTarihi.ToLongDateString()) %>
        </td>
        
    </tr>
<% } %>

</table>
    <%}
      else { %>
      <p align="center" style="font-size:160%"><b> <% Response.Write("Bu Konu Grubu İçin  Herhangi Önerge Kaydı Bulunamadı!"); %></b></p>  
    
      <%} %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
