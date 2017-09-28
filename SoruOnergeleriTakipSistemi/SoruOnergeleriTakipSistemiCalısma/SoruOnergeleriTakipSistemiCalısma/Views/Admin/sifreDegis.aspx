<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Yöneticiler>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    sifreDegis
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <article class="module width_full">
           <header><h3>Şifre Değiştir</h3></header>
<%using(Html.BeginForm("sifreDegis","Admin",FormMethod.Post,new{@name="formlogin",@id="frmL"})){ %>
       <center> <table class="auto-style1">
       
 
            <tr>
                <td class="auto-style2">Eski Sifre</td>
                <td class="auto-style3"><%:Html.TextBox("txtEskiSifreD","",new{@id="txtSifre",@class="txtLog"}) %></td>
                <td class="auto-style4">*</td>
            </tr>

              <%Response.Write(ViewBag.uyari); %>
            <%Response.Write(ViewBag.Sifre123); %>
         <%Response.Write(ViewBag.bos); %>
            <%Response.Write(ViewBag.uyari1); %>
             <tr>
                <td class="auto-style2">Yeni Sifre</td>
                <td class="auto-style3"><%:Html.TextBox("txtYeniSifreD","",new{@id="txtSifre",@class="txtLog"}) %></td>
                 <td>*</td>
            </tr>



            <tr>
                <td class="auto-style2">Şifre Onay</td>
                <td class="auto-style3"><%:Html.TextBox("txtSifreOnayD","",new{@id="txtSifre",@class="txtLog"}) %></td>
                <td >*</td>
            </tr>



            <tr>
                <td colspan="2" class="auto-style3" ><input type="submit" value="Kaydet"  id="buttton"  /></td>

            </tr>
         
        </table></center>
   

    <%}%>
       <%Response.Write(ViewBag.Sifre)
          ; %>
         </article>
         </asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 323px;
            width: 828px;
        }
        .auto-style2 {
            height: 24px;
            width: 284px;
        }
        .auto-style3 {
            height: 24px;
            width: 312px;
        }
        #buttton {
            width: 128px;
            height: 21px;
            margin-left: 154px;
        }
        .auto-style4 {
            width: 263px;
        }
        .auto-style5 {
            height: 157px;
        }
        </style>
</asp:Content>

