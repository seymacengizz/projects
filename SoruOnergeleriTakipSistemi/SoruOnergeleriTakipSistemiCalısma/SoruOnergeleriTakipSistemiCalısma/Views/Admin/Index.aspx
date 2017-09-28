<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.Models.KullaniciHelper>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <style type="text/css">
      

        a.test:link {
            text-decoration: none;
            color: red;
        }

        a.test:active {
            text-decoration: none;
            color: red;
        }

        a.test:visited {
            text-decoration: none;
            color: green;
        }

        a.test:hover {
            text-decoration: none;
            color: yellow;
        }

        .auto-style1 {
            width: 333px;
        }

        .auto-style2 {
            width: 344px;
        }
      
    </style>


   
        <header>
            <h3 align="center">Mesajlar</h3>
        </header>
        <%if (ViewBag.sayi > 0)
          { %>
      <table border="3" width="70%" bordercolor="#404040"  align="center">
             
            <tr>
              
               <td width="5500" align="center" ><font size=2  face="Arial" ><b>Kullanıcıdan Gelen Cevap</b></font></td>
                <td width="5500" align="center"><font size=2  face="Arial" ><b>Kullanıcı Adı</b></font></td>
                 <td width="5500" align="center"><font size=2  face="Arial" ><b>Okunma Durumu</b></font></td>
                <td width="5500" align="center"><font size=2  face="Arial" ><b>Cevabı Sil</b></font></td>
               
            </tr>
          
            <tr>
                <%foreach (var item in Model)
                  {

                      Response.Write("<td> ");
                      Response.Write("<a class='test' href=' " + Url.Action("sonOnergeAdmin", new { id = item.onergeID }) + "'>" + item.Amesaj + "</a>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                      
                      Response.Write("</td>");
                      Response.Write("<td>");
                      Response.Write(item.Ad+" "+item.Soyad);
              
               Response.Write("</td><td>");
                      
                       if(item.okunma==1){
                   Response.Write("<a href='" + Url.Action("okunmaDurumu", new { id = item.AmesajID, sayfa = "onaykaldir" }) + "'>Okundu</a>");
               
               
               }
               else{
                   Response.Write("<a href='" + Url.Action("okunmaDurumu", new { id = item.AmesajID, sayfa = "onayla" }) + "'>Okunmadı</a>");
               }
               Response.Write("</td>");
                      
                      
                      
               %>


                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp <%:Html.ActionLink("Sil", "SilA", new { id = item.AmesajID })%> </td>
            </tr>
             
            <% } %>
        </table>
        <%}
        
          else Response.Write("Herhangi Bir Mesaj Bulunamadı!!"); %>
    

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
