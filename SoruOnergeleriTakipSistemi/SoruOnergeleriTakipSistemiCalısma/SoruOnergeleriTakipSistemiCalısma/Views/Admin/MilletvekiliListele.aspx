<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.MilletVekili>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    MilletvekiliListele
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <article class="module width_full">
            <header>
                <h3>Milletvekil Listesi</h3>
            </header>

<table class="tablesorter">
    <tr>
        <td>
            <h4>Milletvekili Adı Soyadı</h4>
        </td>
        <td>
            <h4>Partisi</h4>
        </td>
       <td>
            <h4>İli</h4>
        </td>
        <td>
           <h4>Toplam Önerge Sayısı</h4>
        </td>
        <th></th>
    </tr>

<% foreach (SoruOnergeleriTakipSistemiCalısma.MilletVekili item in ViewBag.Milletvekilleri)
   { %>
    <tr>
        <td>
            <%: Html.DisplayFor(modelItem => item.milletvekiliAdı) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.partisi) %>
        </td>
         <td>
            <%: Html.DisplayFor(modelItem => item.ili) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.sayac) %>
        </td>
        <td>
            <%: Html.ActionLink("Düzenle", "MilletvekilDüzenle", new { id=item.ID }) %> |
         
            <%: Html.ActionLink("Sil", "MilletvekilSil", new { id=item.ID }) %>
        </td>
    </tr>
<% } %>

</table>
 </article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
