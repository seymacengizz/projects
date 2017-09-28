<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Onerge>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%--OnergeDuzenle--%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%--<h2>OnergeDuzenle</h2>--%>
    <article class="module width_full">
    <header><h3>Önerge Düzenle</h3></header>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <%--<fieldset>--%>
        <%--<legend>Onerge</legend>--%>

        <%: Html.HiddenFor(model => model.ID) %>



        <table>

       <tr>

       <td><div class="editor-label">
            <%: Html.LabelFor(model => model.Donem) %>
           
            <br />
           
        </div></td>
        <td style="width:80px"><div class="editor-field">
            <%: Html.EditorFor(model => model.Donem) %>
            <%: Html.ValidationMessageFor(model => model.Donem) %>
            <br /><p></p>
        </div></td>
</tr> 
   <tr>
       <td> <div class="editor-label">
            <%: Html.LabelFor(model => model.YasamaYili) %>
            <br />
        </div></td>
       <td> <div class="editor-field">
            <%: Html.EditorFor(model => model.YasamaYili) %>
            <%: Html.ValidationMessageFor(model => model.YasamaYili) %>
            <br /><p></p>
        </div></td>
</tr>

 <tr>
        <td><div class="editor-label">
            <%: Html.LabelFor(model => model.EsasNo) %>
            <br />
        </div></td>
        <td><div class="editor-field">
            <%: Html.EditorFor(model => model.EsasNo) %>
            <%: Html.ValidationMessageFor(model => model.EsasNo) %>
            <br /><p></p>
        </div>
</tr>

 <tr>
         <td><div class="editor-label">
            <%: Html.LabelFor(model => model.MilletvekilAdi) %>
            <br />
        </div></td>

         <td><div class="editor-field">
            <%: Html.DropDownList("milletvekil") %>
            <%: Html.ValidationMessageFor(model => model.MilletvekilAdi) %>
            <br /><p></p>
        </div></td>
</tr>

<tr>
       <td><div class="editor-label">
            <%: Html.LabelFor(model =>model.EvrakTarihi)  %>
            <br />
        </div></td> 
       <td><div >
            <%: Html.EditorFor(model =>model.EvrakTarihi) %>
            <%: Html.ValidationMessageFor(model => model.EvrakTarihi)  %>
            <br /><p></p>
        </div></td> 
</tr>

<tr>
      <td><div class="editor-label">
            <%: Html.LabelFor(model => model.Durum) %>
            <br />
        </div></td> 

        <td> <div class="editor-field">
            <%: Html.DropDownList("durumlar") %>
            <%: Html.ValidationMessageFor(model => model.Durum) %>
            <br /><p></p>
        </div></td>
</tr>

<tr>
      <td><div class="editor-label">
            <%: Html.LabelFor(model => model.OnergeKonusu) %>
            <br />
        </div></td>

         <td><div class="editor-field">
            <%: Html.DropDownList("konuGrupları") %>
            <%: Html.ValidationMessageFor(model => model.OnergeKonusu) %>
            <br /><p></p>
        </div></td>
</tr>

<tr>
       <td><div class="editor-label">
            Dosya Seç
            <br />
        </div></td> 
        <td><div class="editor-field">
            <%: Html.TextBoxFor(model => model.Extension,new { @type = "file" }) %>
            <%: Html.ValidationMessageFor(model => model.Extension) %>
            <br /><p></p>
        </div></td>
</tr>

<tr>
       <td><div class="editor-label">
            <%: Html.LabelFor(model => model.Kurum) %>
            <br />
        </div></td> 
        <td><div class="editor-field">
            <%: Html.DropDownList("kurumlar") %>
            <%: Html.ValidationMessageFor(model => model.Kurum) %>
            <br /><p></p>
        </div></td>
</tr>

<tr>
       <td> <div class="editor-label">
             Geldiği Kurum
            <br />
        </div></td>
        <td><div class="editor-field">
            <%: Html.DropDownList("Gkurumlar") %>
            <%: Html.ValidationMessageFor(model => model.GKurum) %>
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

<div>
    <%: Html.ActionLink("Back to List", "detayliGoster") %>
</div>
</article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
