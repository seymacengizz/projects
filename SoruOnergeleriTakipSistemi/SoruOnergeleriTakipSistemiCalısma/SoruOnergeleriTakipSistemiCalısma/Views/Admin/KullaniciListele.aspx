<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<SoruOnergeleriTakipSistemiCalısma.Models.KullaniciHelper>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    KullaniciListele
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<article class="module width_full">
    <header><h3>Kullanıcı Listele</h3></header>
    <%if (ViewBag.sayi > 0)
      { %>
   <table  class="tablesorter">
        <tr>

    
      <td><strong>Kullanıcı Adı</strong></td>
      <td><strong>Şifre</strong></td>
      <td><strong>Ad</strong></td>
      <td><strong>Soyad</strong></td>
      <td><strong>Kurum Adı</strong></td>
    
          
        </tr>
        <!-- item Modelden alacak verileri-->
        <%foreach (var item in Model)
          {   %>
              
           <!-- verilerimizi listeliyoruz -->
           
            <tr>
     
       <td ><%=Html.DisplayName(item.kullaniciAdi)%></td>
        <td><%=Html.DisplayName(item.sifre)%></td>
          <td ><%=Html.DisplayName(item.Ad)%></td>
           <td ><%=Html.DisplayName(item.Soyad)%></td>
             <td ><%=Html.DisplayName(item.kurumAd)%></td>
            
             <!--Düzenle alanı için:   -->
                 <td>
            <%: Html.ActionLink("Düzenle", "kullaniciDuzenle", new { id=item.KullaniciID }) %> |
         
            <%: Html.ActionLink("Sil", "KullaniciSil", new { id=item.KullaniciID }) %>
        </td>

            </tr>  
              
                 <%} %>
       
    </table>
   <%}
      else Response.Write("Herhangi bir kayıt yok!!"); %>

    </article>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>