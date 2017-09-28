<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.MilletVekili>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Milletvekil Düzenle
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <article class="module width_full">
    <header><h3>  Milletvekil Düzenle</h3></header>
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

        <%: Html.HiddenFor(model => model.ID) %>

<table>
 <tr>  
     <p></p> 
    <td><div class="editor-label">
            <%: Html.LabelFor(model => model. milletvekiliAdı) %>
            <br />
        </div></td>
       <td> <div class="editor-field">
            <%: Html.EditorFor(model => model.milletvekiliAdı) %>
            <%: Html.ValidationMessageFor(model => model.milletvekiliAdı) %>
            <br /><p></p>
        </div></td>
</tr>  

<tr>
     <td><div class="editor-label">
            <%: Html.LabelFor(model => model.partisi) %>
            <br />
         </div></td>
     <td><div class="editor-field">
            <%: Html.EditorFor(model => model.partisi) %>
            <%: Html.ValidationMessageFor(model => model.partisi) %>
            <br /><p></p>
      </div></td> 
</tr>          

<tr>
      <td><div class="editor-label">
            <%: Html.LabelFor(model => model.ili) %>
            <br />
        </div></td>
       <td><div class="editor-field">
            <%: Html.EditorFor(model => model.ili) %>
            <%: Html.ValidationMessageFor(model => model.ili) %>
            <br /><p></p>
        </div></td>
</tr>

<tr>
        <td><p>
            <input type="submit" value="Kaydet" />
        </p></td>
</tr>
</table>   
<% } if (!Page.IsPostBack)
   {
           Response.Write(ViewBag.duzenle);
       
   }  %>

<div>
    <%: Html.ActionLink("Back to List", "MilletvekiliListele") %>
</div>
</article>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>