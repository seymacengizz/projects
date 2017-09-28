<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Kullanicilar>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    kullanici Duzenle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%--<h2>OnergeDuzenle</h2>--%>
    <article class="module width_full">
    <header><h3> Kullanıcı Duzenle</h3></header>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <%--<fieldset>--%>
        <%--<legend>Onerge</legend>--%>

        <%: Html.HiddenFor(model => model.ID) %>


 <table>
 <tr>
     <p></p>
        <td><div class="editor-label">
            <%: Html.LabelFor(model => model.KullaniciAdi) %>
            <br />
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.KullaniciAdi) %>
            <%: Html.ValidationMessageFor(model => model.KullaniciAdi) %>
            <br /><p></p>
        </div></td>
  </tr>

  <tr>
        <td><div class="editor-label">
            <%: Html.LabelFor(model => model.Sifre) %>
            <br />
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.Sifre) %>
            <%: Html.ValidationMessageFor(model => model.Sifre) %>
            <br /><p></p>
        </div></td>
</tr>
        
<tr>
       <td> <p>
            <input type="submit" value="Kaydet" />
        </p></td>
</tr>
        </table>
    <%--</fieldset>--%>
<% } if (!Page.IsPostBack)
   {
           Response.Write(ViewBag.duzenle);
       
   }  %>

<div>
    <%: Html.ActionLink("Back to List", "KullaniciListele") %>
</div>
</article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
