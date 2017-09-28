<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.OnergeKonuGrupları>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    KonuListele
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <article class="module width_full">
            <header>
                <h3>Konu Listesi</h3>
            </header>
<table class="tablesorter">
       <tr>
        <td>
            <h4>Önerge Konusu</h4>
        </td>
       
        <td>
           <h4>Toplam Önerge Sayısı</h4>
        </td>
        <th></th>
    </tr>

<% foreach (SoruOnergeleriTakipSistemiCalısma.OnergeKonuGrupları item in ViewBag.Konular)
   { %>
    <tr>
        <td>
            <%: Html.DisplayFor(modelItem => item.OnergeKonusu) %>
        </td>
        <td>
            <%: Html.DisplayFor(modelItem => item.KonuSayısı) %>
        </td>
        <td>
            <%: Html.ActionLink("Düzenle", "KonuDuzenle2", new { id=item.ID }) %> |
           
            <%: Html.ActionLink("Sil", "KonuSil", new { id=item.ID }) %>
        </td>
    </tr>
<% } %>

</table>
</article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
