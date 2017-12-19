<%@ Page Title="Ver Usuarios" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Usuarios.aspx.cs" Inherits="Admin_Usuarios" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="sp_usuario_select_all" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:GridView ID="gvJugadores" runat="server" DataSourceID="SQLDSUsuarios" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True">
         <Columns>
             <asp:CommandField ShowSelectButton="True" />
             <asp:BoundField DataField="INTCVEUSUARIO" HeaderText="INTCVEUSUARIO" SortExpression="INTCVEUSUARIO" />
             <asp:BoundField DataField="VCHUSUARIO" HeaderText="VCHUSUARIO" SortExpression="VCHUSUARIO" />
             <asp:BoundField DataField="VCHPASSWORD" HeaderText="VCHPASSWORD" SortExpression="VCHPASSWORD" />
             <asp:BoundField DataField="CHRTIPOUSUARIO" HeaderText="CHRTIPOUSUARIO" SortExpression="CHRTIPOUSUARIO" />
         </Columns>
     </asp:GridView>
</asp:Content>