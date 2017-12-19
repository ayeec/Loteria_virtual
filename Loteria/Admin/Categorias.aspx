<%@ Page Title="Ver Categorias" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Categorias.aspx.cs" Inherits="Admin_Jugadores" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCategorias" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="sp_categoria_select_all" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:GridView ID="gvCategorias" runat="server" DataSourceID="SQLDSCategorias" AutoGenerateColumns="False">
         <Columns>
             <asp:BoundField DataField="INTIDCATEGORIA" HeaderText="INTIDCATEGORIA" SortExpression="INTIDCATEGORIA" />
             <asp:BoundField DataField="VCHNOMBRE" HeaderText="VCHNOMBRE" SortExpression="VCHNOMBRE" />
             <asp:BoundField DataField="VCHDESCRIPCION" HeaderText="VCHDESCRIPCION" SortExpression="VCHDESCRIPCION" />
         </Columns>
     </asp:GridView>
</asp:Content>