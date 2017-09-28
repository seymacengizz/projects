<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteKullanici.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Cevap>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    onergeCevap
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <article class="module width_full">
            <header>
                <h3>Cevap Ekle</h3>
            </header>

            <%using (Html.BeginForm("onergeCevap", "Kullanici", FormMethod.Post, new {enctype="multipart/form-data"}))
              { %>

            <table>
               
                
               
               
              
                 <tr>
                    <td class="auto-style2">Kurum</td>
                    <td  class="auto-style1"><%:Html.DropDownList("kurumlar" )%></td>
                    </tr>
              
               <tr>
                    <td class="auto-style2">Önerge Durumu</td>
                    <td id="drop" class="auto-style1"><%:Html.DropDownList("durumlar" )%></td>
                    </tr>
                
                
                <tr>


                    <td >Dosya Yükleme İçerik</td>
                    <td class="auto-style1"><%:Html.TextBox("file", "", new { @type = "file" })%></td>
                </tr>

                <tr>
                    <td colspan="2">

                        <br />

                        <input type="submit" value="Kaydet" onclick="return validate();" /><br />
                         <p  style="color:blue"><b> <%Response.Write(ViewBag.cevaplandi);%> </b></p>
                         <p  style="color:red"><b> <%Response.Write(ViewBag.durumUyari); %> </b></p>
                         <p  style="color:red"><b> <%Response.Write(ViewBag.kurumUyari); %> </b></p>
                        <br />
                    </td>
                </tr>
            </table>

            <%} %>
        </article>

    <script type="text/javascript">
        function validate() {
            var dosya = document.getElementById("file");

            if (dosya.value == "") {

                alert("Dosya Seçiniz!");
                return false;
            }
        }
        </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 529px;
        }
    </style>
</asp:Content>
