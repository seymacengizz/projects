<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>
<asp:Panel ID="Panel1" runat="server"  >
        <img class="auto-style4" src="Resim/image_bstb.png" />
   </asp:Panel>
<html>
  <asp:Panel ID="Panel2" runat="server"  > 
<head>
<meta charset="utf-8">
<title>Login</title>
<style type="text/css">
body {
background-color: #f4f4f4;
color: #5a5656;
font-family: 'Open Sans', Arial, Helvetica, sans-serif;
font-size: 16px;
line-height: 1.5em;
}
a { text-decoration: none; }
h1 { font-size: 1em; }
h1, p {
margin-bottom: 10px;
}
strong {
font-weight: bold;
}
.uppercase { text-transform: uppercase; }
.cleaner { clear: both }

/* ---------- LOGIN ---------- */
  
#login {
margin: 50px auto;
width: 300px;

}
form fieldset input[type="text"], input[type="password"] {
background-color: #e5e5e5;
border: none;
border-radius: 3px;
-moz-border-radius: 3px;
-webkit-border-radius: 3px;
color: #5a5656;
font-family: 'Open Sans', Arial, Helvetica, sans-serif;
font-size: 14px;
height: 50px;
outline: none;
padding: 0px 10px;
width: 280px;
-webkit-appearance:none;
}
form fieldset input[type="submit"] {
background-color: #008dde;
border: none;
border-radius: 3px;
-moz-border-radius: 3px;
-webkit-border-radius: 3px;
color: #f4f4f4;
cursor: pointer;
font-family: 'Open Sans', Arial, Helvetica, sans-serif;
height: 50px;
text-transform: uppercase;
width: 300px;
-webkit-appearance:none;
}
form fieldset a {
color: #5a5656;
font-size: 10px;
}
form fieldset a:hover { text-decoration: underline; }
.btn-round {
background-color: #5a5656;
border-radius: 50%;
-moz-border-radius: 50%;
-webkit-border-radius: 50%;
color: #f4f4f4;
display: block;
font-size: 12px;
height: 50px;
line-height: 50px;
margin: 30px 125px;
text-align: center;
text-transform: uppercase;
width: 50px;
}
.facebook {
background-color: #0079ce;
border: none;
border-radius: 0px 3px 3px 0px;
-moz-border-radius: 0px 3px 3px 0px;
-webkit-border-radius: 0px 3px 3px 0px;
color: #f4f4f4;
cursor: pointer;
height: 50px;
text-transform: uppercase;
width: 250px;
}
    .margin-bottom {
        height: 31px;
        width: 811px;
    }
</style>
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    <script type="text/javascript">
        function Kontrol() {
            var uyari = "";
            var kadi = $("#txtKadi").val();
            kadi = $.trim(kadi);
            var sifre = $("#txtSifre").val();
            sifre = $.trim(sifre);
            if (kadi == "") {
                uyari = "1";
                $("#hata").html("Kullanıcı Adı Bos Olamaz");
            }
            else if (sifre == "") {
                uyari = "1";
                $("#hata").html("Sifre Bos Olamaz");

            }

            if (uyari == "") {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
</head>
 </asp:Panel>
<body>
<div id="login">
<center><h1><strong>Hoşgeldiniz.</strong> Lütfen Giriş Yapınız.</h1></center>

     <%using (Html.BeginForm("Login", "Login", FormMethod.Post, new { @name = "formlogin", @id = "frmL" }))
       { %>
       <fieldset>
          <p><%:Html.TextBox("txtKullaniciAdi", "Kullanıcı Adı", new { @id = "txtKadi", @class = "txtLog" })%> </p>
          <p><%:Html.Password("txtSifre","Şifre",new{@id="txtSifre",@class="txtLog"}) %></p>
          <%--<p><a href="#">Forgot Password?</a></p>--%>
          <p><input class="facebook" type="submit" value="Giriş";onclick="if (!Kontrol()) return false; " id="button" /></p>
       </fieldset>
       <div><asp:Panel ID="Panel3" runat="server"  >
            <center><i><h1 style="color:red">Yeni kullanıcılar için;</h1></i></center>
           <center><i><h1 style="color:red">'Kullanıcı Adı' TC,</h1></i></center>
           <center><i><h1 style="color:red">'Şifre' TC'nin ilk 5 hanesidir!</h1></i></center>
          
        </asp:Panel></div>
    <div id="hata"></div>
    <%}
      if (ViewBag.Bos == true)
    {
        Response.Write("lütfen Tüm Alanları Doldurunuz...");
    }

    if (ViewBag.onay == false)
    {
        Response.Write("Kullanıcı adı veya şifreniz yanlıştır..");
        
    }
   %>
</body>
</html>
