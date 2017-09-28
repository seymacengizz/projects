<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.OnergeKonuGrupları>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Konu Duzenle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<article class="module width_full">
    <header><h3>  Konu Düzenle</h3></header>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

 
        <%: Html.HiddenFor(model => model.ID) %>


<table>
<tr>
    <p></p>
       <td><div class="editor-label">
            <%: Html.LabelFor(model => model. OnergeKonusu) %>
            <br /> 
        </div></td> 
       <td> <div class="editor-field">
            <%: Html.EditorFor(model => model.OnergeKonusu) %>
            <%: Html.ValidationMessageFor(model => model.OnergeKonusu) %>
            <br /><p></p>
        </div></td>
</tr>
        
<tr>
       <td> <p>
            <input type="submit" value="Kaydet" />
        </p></td>
</tr>
  </table> 
<% } if (!Page.IsPostBack)
   {
           Response.Write(ViewBag.duzenle);
       
   }  %>

<div>
    <%: Html.ActionLink("Back to List", "KonuListele") %>
</div>
</article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>