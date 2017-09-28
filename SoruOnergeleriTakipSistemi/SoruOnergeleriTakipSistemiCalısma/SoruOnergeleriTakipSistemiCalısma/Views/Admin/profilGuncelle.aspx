<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Yöneticiler>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    profilGuncelle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <article class="module width_full">
    <header><h3> Profil Güncelle</h3></header>

<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <%--<fieldset>
        <legend>Yöneticiler</legend>--%>

        <%: Html.HiddenFor(model => model.ID) %>

 <table>
<tr>
     <p></p>
      <td> <div class="editor-label">
     
         <b> Kullanıcı Adı</b>
        </div></td> 
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.kullaniciAdi) %>
            <%: Html.ValidationMessageFor(model => model.kullaniciAdi) %>
         <br /><p></p>
        </div></td>
</tr>
<%--<tr>
       <td><div class="editor-label">
            <b> Şifre</b>
        </div></td> 
       <td> <div class="editor-field">
            <%: Html.EditorFor(model => model.Sifre) %>
            <%: Html.ValidationMessageFor(model => model.Sifre) %>
         <br /><p></p>
        </div></td>
</tr>--%>
<tr>
        <td><div class="editor-label">
          <b> Email</b>
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.Email) %>
            <%: Html.ValidationMessageFor(model => model.Email) %>
             <br /><p></p>
        </div></td>
</tr>
<tr>
        <td><div class="editor-label">
            <b> Adı</b>
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.adi) %>
            <%: Html.ValidationMessageFor(model => model.adi) %>
             <br /><p></p>
        </div></td>
</tr>
<tr>
        <td><div class="editor-label">
            <b> Soyadı</b>
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.soyadi) %>
            <%: Html.ValidationMessageFor(model => model.soyadi) %>
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
