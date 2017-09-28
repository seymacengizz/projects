<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    MilletvekiliEkle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <article class="module width_full">
            <header>
                <h3>Yeni Milletvekili Ekle</h3>
            </header>



            <%using (Html.BeginForm("MilletvekiliEkle", "Admin", FormMethod.Post, new { @name="frm" }))
              { %>

            <table>
                <tr>
                    <td class="auto-style2">Adı Soyadı</td>
                    <td class="auto-style1"><%:Html.TextBox("txtAdıSoyadı") %></td>
                </tr>
            
                 <tr>
                    <td class="auto-style2">Partisi</td>
                    <td class="auto-style1"><%:Html.TextBox("txtPartisi") %></td>
                </tr>


                 <tr>
                    <td class="auto-style2">İli</td>
                    <td class="auto-style1"><%:Html.TextBox("txtIli") %></td>
                </tr>

                <tr>
                    <td colspan="2">

                       

                        <input type="submit" value="Kaydet" />
                       
                    </td>
                </tr>
            </table>


            <%} %>
        </article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
