<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.OnergeKonuGrupları>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    KonuEkle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <article class="module width_full">
            <header>
                <h3>Konu Ekle</h3>
            </header>

            <%using (Html.BeginForm("KonuEkle", "Admin", FormMethod.Post, new { @name="frm" }))
              { %>

            <table>
                <tr>
                    <td class="auto-style2">Konu Adı</td>
                    <td class="auto-style1"><%:Html.TextBox("txtKonuAdı") %></td>
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
