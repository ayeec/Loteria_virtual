<%@ Page Title="Ver Jugadores" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Jugadores.aspx.cs" Inherits="Admin_Jugadores" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<asp:SqlDataSource ID="SQLDSJugadores" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="sp_jugador_select_all" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:GridView ID="gvJugadores" runat="server" DataSourceID="SQLDSJugadores" AllowPaging="True" AllowSorting="True">
         <Columns>
             <asp:CommandField ShowSelectButton="True" />
         </Columns>
     </asp:GridView>
</asp:Content>