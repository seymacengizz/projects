<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteKullanici.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Kullanicilar>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    profilGuncelle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <article class="module width_full">
    <header><h3> Profil Güncelle</h3></header>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

<%--    <fieldset>
        <legend>Kullanicilar</legend>--%>

        <%: Html.HiddenFor(model => model.ID) %>
        
 <table>
<tr>
    <p></p>
       <td><div class="editor-label">
            <b> Kullanıcı Adı</b>
        </div></td>
       <td> <div class="editor-field">
            <%: Html.EditorFor(model => model.KullaniciAdi) %>
            <%: Html.ValidationMessageFor(model => model.KullaniciAdi) %>
       <br /><p></p>
        </div></td>
</tr>
<%--  <tr>

        <td><div class="editor-label">
            <%: Html.LabelFor(model => model.Sifre) %>
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.Sifre) %>
            <%: Html.ValidationMessageFor(model => model.Sifre) %>
            <br /><p></p>
        </div></td>
</tr>--%>

<tr>
        <td><div class="editor-label">
          <b>Email</b>
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.Email) %>
            <%: Html.ValidationMessageFor(model => model.Email) %>
            <br /><p></p>
        </div></td>

</tr>
<tr>
        <td><div class="editor-label">
            <b>Adı</b>
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.Adi) %>
            <%: Html.ValidationMessageFor(model => model.Adi) %>
            <br /><p></p>
        </div></td>
</tr>
<tr>
       <td><div class="editor-label">
           <b>Soyadı</b>
        </div></td> 
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.Soyadi) %>
            <%: Html.ValidationMessageFor(model => model.Soyadi) %>
            <br /><p></p>
        </div></td>
</tr>
<tr>
       <td><p>
            <input type="submit" value="Kaydet" />
        </p></td> 
</tr>
     </table>
   <%--</fieldset>--%>
<% } if (!Page.IsPostBack)
   {
           Response.Write(ViewBag.duzenle);
       
   }  %>


        </article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
