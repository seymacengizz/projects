<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteAdmin.Master" Inherits="System.Web.Mvc.ViewPage<SoruOnergeleriTakipSistemiCalısma.Onerge>" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Rapor
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <form id="form1" runat="server">
        <article class="module width_full">
         <header><h3>Rapor</h3></header>

        <p><h3>Milletvekilleri Önerge Sayıları</h3>
            <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1">
                <series>
                    <asp:Series Name="Series1" XValueMember="milletvekiliAdı" YValueMembers="sayac">
                    </asp:Series>
                </series>
                <chartareas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </chartareas>
            </asp:Chart>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SorguOnergeleriConnectionString %>" SelectCommand="SELECT * FROM [MilletVekili]"></asp:SqlDataSource>
        </p>
        <p>
            <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" DataSourceID="SqlDataSource1" RepeatDirection="Horizontal">
                <ItemTemplate>
                  

                    <asp:Label ID="milletvekiliAdıLabel" runat="server" Text='<%# Eval("milletvekiliAdı") %>' /> &nbsp;&nbsp;
                    <br />
                   
                    <asp:Label ID="sayacLabel" runat="server" Text='<%# Eval("sayac") %>' />
                    <br />
<br />
                </ItemTemplate>
            </asp:DataList>
        </p>
        <p>&nbsp;</p>
        <p>
            <h3>Önerge Konu Grup Sayıları</h3>
            <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource2">
                <series>
                    <asp:Series Name="Series1" XValueMember="OnergeKonusu" YValueMembers="KonuSayısı">
                    </asp:Series>
                </series>
                <chartareas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </chartareas>
            </asp:Chart>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SorguOnergeleriConnectionString %>" SelectCommand="SELECT * FROM [OnergeKonuGrupları]"></asp:SqlDataSource>
        </p>
        <p>
            <asp:DataList ID="DataList2" runat="server" DataKeyField="ID" DataSourceID="SqlDataSource2" RepeatDirection="Horizontal">
                <ItemTemplate>
                    

                    <asp:Label ID="OnergeKonusuLabel" runat="server" Text='<%# Eval("OnergeKonusu") %>' />&nbsp;&nbsp;
                    <br />
                  
                    <asp:Label ID="KonuSayısıLabel" runat="server" Text='<%# Eval("KonuSayısı") %>' />
                    <br />
<br />
                </ItemTemplate>
            </asp:DataList>
        </p>
     </article>
    </form>
     
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
