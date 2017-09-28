<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteKullanici.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.Models.KullaniciHelper>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   

   <style type="text/css">
<!--

a.test:link {text-decoration:none;color:red}
a.test:active {text-decoration:none;color:red}
a.test:visited {text-decoration:none;color:green}
a.test:hover {text-decoration:none; color:yellow}
       .auto-style1 {
           width: 333px;
       }
       .auto-style2 {
           width: 344px;
       }
-->
</style>
   

   
    <header> <h3 align="center">Mesajlar</h3></header>
         <%if (ViewBag.sayi > 0)
      { %>
         <table border="3" width="70%" bordercolor="#404040"  align="center">
             
            <tr>
              
               <td width="5500" align="center" ><font size=2  face="Arial" ><b>Yeni Önerge</b></font></td>
                <td width="5500" align="center"><font size=2  face="Arial" ><b>Okunma Durumu</b></font></td>
                <td width="5500" align="center"><font size=2  face="Arial" ><b> Sil</b></font></td>
                </tr>
            <%Response.Write(ViewBag.mesaj); %>
            <tr>
                
         <%foreach (var item in Model)
           {

               Response.Write("<td> ");
               Response.Write("<a class='test' href=' " + Url.Action("sonOnerge", new { id = item.onergeID }) + "'>" + item.mesaj + "</a>"
                   );
               Response.Write("</td><td>");
               if(item.okunma==1){
                   Response.Write("<a href='" + Url.Action("okunmaDurumu", new { id = item.mesajID, sayfa = "onaykaldir" }) + "'>Okundu</a>");
               
               
               }
               else{
                   Response.Write("<a href='" + Url.Action("okunmaDurumu", new { id = item.mesajID, sayfa = "onayla" }) + "'>Okunmadı</a>");
               }
               Response.Write("</td>");
               %>


                <td> <%:Html.ActionLink("Sil","Sil",new{id=item.mesajID})%> </td>
                </tr>
          <% } %>
         

        
        </table>
         <%}   else { %>
      <p align="center" style="font-size:160%"><b> <% Response.Write("Bu Kullanıcı Adına Herhangi Önerge Kaydı Bulunamadı!"); %></b></p>  
      
      
      <%} %>
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
