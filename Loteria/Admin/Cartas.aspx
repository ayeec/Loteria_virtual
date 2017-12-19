<%@ Page Title="Ver Cartas" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Cartas.aspx.cs" Inherits="Admin_Jugadores" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCartas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="sp_cartas_select_all" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:GridView ID="gvCartas" runat="server" DataSourceID="SQLDSCartas" AutoGenerateColumns="False">
         <Columns>
             <asp:BoundField DataField="INTCVECARTA" HeaderText="INTCVECARTA" SortExpression="INTCVECARTA" />
             <asp:BoundField DataField="VCHNOMBRE" HeaderText="VCHNOMBRE" SortExpression="VCHNOMBRE" />
             <asp:BoundField DataField="RUTAIMAGEN" HeaderText="RUTAIMAGEN" SortExpression="RUTAIMAGEN" />
             <asp:BoundField DataField="VCHTEXTO" HeaderText="VCHTEXTO" SortExpression="VCHTEXTO" />
         </Columns>
     </asp:GridView>
</asp:Content>