<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Kullanicilar>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    KullanıcıEkle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

 <article class="module width_full" ">
            <header>
                <h3>Kullanıcı Ekle</h3>
            </header>

      <%using (Html.BeginForm("KullanıcıEkle", "Admin", FormMethod.Post, new {@name="frmKAt"}))
              { %>

            <table  >
               <p>
                <tr >
                    <td   class="auto-style2" >Ad </td>
                    <td  class="auto-style1"><%:Html.TextBox("txtAd") %></td>
                </tr>
                  <tr>
                    <td  class="auto-style2">SoyAd </td>
                    <td   class="auto-style1"><%:Html.TextBox("txtSoyAd") %></td>
                </tr>

                  <tr>
                    <td class="auto-style2">Email </td>
                    <td class="auto-style1"><%:Html.TextBox("txtEMail") %></td>
                </tr>
                  <tr>
                    <td class="auto-style2">TC No </td>
                    <td class="auto-style1"><%:Html.TextBox("txtKullaniciAdi") %></td>
                </tr>


                 <tr>
                    <td class="auto-style2">Bilgi İstenen Kurumlar</td>
                    <td><%:Html.DropDownList("kurumlar") %></td>
                    </tr>
                 <tr>
                    <td colspan="2">

                        <br />

                        <input type="submit" value="Kaydet" /><br />
                        <br />
                    </td>
                </tr>

                </table>




       <%} %>
      </article>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
