<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteKullanici.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    onergeCevaplandi
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Önerge Cevaplandı</h2>
<%Response.Write("Bu önerge Cevaplandı"); %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
