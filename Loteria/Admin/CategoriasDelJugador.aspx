<%@ Page Title="Ver Categorias Del Jugador" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CategoriasDelJugador.aspx.cs" Inherits="Admin_CategoriasDelJugador" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCategoriasDelJugador" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [categoriasdejugador]">
    </asp:SqlDataSource>
     <asp:GridView ID="gvCategoriasDelJugador" runat="server" DataSourceID="SQLDSCategoriasDelJugador" AutoGenerateColumns="False" AllowSorting="True">
         <Columns>
             <asp:CommandField ShowSelectButton="True" />
             <asp:BoundField DataField="INTIDCATEGORIA" HeaderText="INTIDCATEGORIA" SortExpression="INTIDCATEGORIA" />
             <asp:BoundField DataField="INTCVEJUGADOR" HeaderText="INTCVEJUGADOR" SortExpression="INTCVEJUGADOR" />
             <asp:BoundField DataField="INTIDPESO" HeaderText="INTIDPESO" SortExpression="INTIDPESO" />
             <asp:BoundField DataField="BOOLACTIVO" HeaderText="BOOLACTIVO" SortExpression="BOOLACTIVO" />
         </Columns>
     </asp:GridView>
</asp:Content>