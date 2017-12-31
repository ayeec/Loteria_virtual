<%@ Page Title="Ver Detalle del Juego/Sesión" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="DetalleDelJuego.aspx.cs" Inherits="Admin_Detalle" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSDetalle" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="sp_detallejuego_select" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="IDJuego" QueryStringField="IDdetalle" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDsCategoriasDeSesion" AllowPaging="True" AllowSorting="True">
         <Columns>
             <asp:CommandField ShowSelectButton="True" />
             <asp:BoundField DataField="INTIDRESULTADOSESION" HeaderText="INTIDRESULTADOSESION" SortExpression="INTIDRESULTADOSESION" />
             <asp:BoundField DataField="INTIDCATEGORIA" HeaderText="INTIDCATEGORIA" SortExpression="INTIDCATEGORIA" />
             <asp:BoundField DataField="INTCVEJUGADOR" HeaderText="INTCVEJUGADOR" SortExpression="INTCVEJUGADOR" />
         </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDsCategoriasDeSesion" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [sesioncategorias]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [sesioncategorias] WHERE [INTIDRESULTADOSESION] = @original_INTIDRESULTADOSESION AND [INTIDCATEGORIA] = @original_INTIDCATEGORIA AND [INTCVEJUGADOR] = @original_INTCVEJUGADOR" InsertCommand="INSERT INTO [sesioncategorias] ([INTIDRESULTADOSESION], [INTIDCATEGORIA], [INTCVEJUGADOR]) VALUES (@INTIDRESULTADOSESION, @INTIDCATEGORIA, @INTCVEJUGADOR)" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_INTIDRESULTADOSESION" Type="Int32" />
            <asp:Parameter Name="original_INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="original_INTCVEJUGADOR" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="INTIDRESULTADOSESION" Type="Int32" />
            <asp:Parameter Name="INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="INTCVEJUGADOR" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
     <asp:GridView ID="gvDetalle" runat="server" DataSourceID="SQLDSDetalle" AutoGenerateColumns="False">
         <Columns>
             <asp:BoundField DataField="INTIDDETALLE" HeaderText="INTIDDETALLE" SortExpression="INTIDDETALLE" />
             <asp:BoundField DataField="INTCVECARTA" HeaderText="INTCVECARTA" SortExpression="INTCVECARTA" />
             <asp:BoundField DataField="intIDjuego" HeaderText="intIDjuego" SortExpression="intIDjuego" />
             <asp:BoundField DataField="USASONIDO" HeaderText="USASONIDO" SortExpression="USASONIDO" />
             <asp:BoundField DataField="USAIMAGEN" HeaderText="USAIMAGEN" SortExpression="USAIMAGEN" />
             <asp:BoundField DataField="CORRECTO" HeaderText="CORRECTO" SortExpression="CORRECTO" />
         </Columns>
     </asp:GridView>
</asp:Content>