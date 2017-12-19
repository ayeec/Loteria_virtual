<%@ Page Title="Ver Cartas la Categoria" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CartasdeCategoria.aspx.cs" Inherits="Admin_Jugadores" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<asp:SqlDataSource ID="SQLDSCartasDeCategoria" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="sp_cartascategoria_select_cartas" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="IDCategory" QueryStringField="idCategory" Type="Int32" />
    </SelectParameters>
    </asp:SqlDataSource>
     <asp:GridView ID="gvCartasDeCategoria" runat="server" DataSourceID="SQLDSCartasDeCategoria" AutoGenerateColumns="False">
         <Columns>
             <asp:BoundField DataField="INTCVECARTA" HeaderText="INTCVECARTA" SortExpression="INTCVECARTA" />
             <asp:BoundField DataField="RUTAIMAGEN" HeaderText="RUTAIMAGEN" SortExpression="RUTAIMAGEN" />
             <asp:BoundField DataField="VCHNOMBRE" HeaderText="VCHNOMBRE" SortExpression="VCHNOMBRE" />
             <asp:BoundField DataField="VCHTEXTO" HeaderText="VCHTEXTO" SortExpression="VCHTEXTO" />
         </Columns>
     </asp:GridView>
</asp:Content>