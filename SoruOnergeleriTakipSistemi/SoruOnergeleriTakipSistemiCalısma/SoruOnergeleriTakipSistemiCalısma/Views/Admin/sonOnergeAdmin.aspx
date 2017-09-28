 <%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master"Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.Models.KullaniciHelper>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    sonOnergeAdmin
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<article class="module width_full">
    <header><h3>Kullanıcı Cevap</h3></header>
    <%if( ViewBag.sayi>0){%>

    <!--detayHelper classı burda IEnumarable sayasınde dızı olarak donuyo.
        Yanı claasıı view sayfasına gosterdık-->
    <!-- listeleme olayını yapcaz burda-->
    <table class="tablesorter">
        <tr>

             <td><b>Mesaj</b></td> 
            <td><b>Kurum</b></td>
            
             <td><b>Dosya</b></td>
        
        </tr>
        <!-- item Modelden alacak verileri-->
         <%foreach(var item in  Model)
          {   %>
          
            <tr>
   

                 <td><%=Html.DisplayName(item.Amesaj) %></td>
                 <td><%=Html.DisplayName(item.kurumAd) %></td>
              

                <td> <%: Html.ActionLink("cevap indir", "dosyaPdfA", new { id = item.cevapID})%></td>
                <%break; %>
             
            </tr>  
              
             
              <%} %>

    </table>
    <%} 
      else Response.Write("Herhangi bir kayıt bulunamadı..");   %>

    </article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
