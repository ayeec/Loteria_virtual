<%@ Page Title="Ver Historial de Juegos" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="HistorialJuegos.aspx.cs" Inherits="Admin_HistorialJuegos" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSHistorial" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [historialresultados]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [historialresultados] WHERE [INTIDJUEGO] = @original_INTIDJUEGO AND [INTCVEJUGADOR] = @original_INTCVEJUGADOR AND [DATEFECHA] = @original_DATEFECHA AND [INTACIERTOS] = @original_INTACIERTOS AND [INTERRORES] = @original_INTERRORES AND [INTCALIFICACION] = @original_INTCALIFICACION AND [INTTOTALCARTAS] = @original_INTTOTALCARTAS AND [BOOLDIFICIL] = @original_BOOLDIFICIL AND (([INTSONIDO] = @original_INTSONIDO) OR ([INTSONIDO] IS NULL AND @original_INTSONIDO IS NULL))" InsertCommand="INSERT INTO [historialresultados] ([INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (@INTCVEJUGADOR, @DATEFECHA, @INTACIERTOS, @INTERRORES, @INTCALIFICACION, @INTTOTALCARTAS, @BOOLDIFICIL, @INTSONIDO)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [historialresultados] SET [INTCVEJUGADOR] = @INTCVEJUGADOR, [DATEFECHA] = @DATEFECHA, [INTACIERTOS] = @INTACIERTOS, [INTERRORES] = @INTERRORES, [INTCALIFICACION] = @INTCALIFICACION, [INTTOTALCARTAS] = @INTTOTALCARTAS, [BOOLDIFICIL] = @BOOLDIFICIL, [INTSONIDO] = @INTSONIDO WHERE [INTIDJUEGO] = @original_INTIDJUEGO AND [INTCVEJUGADOR] = @original_INTCVEJUGADOR AND [DATEFECHA] = @original_DATEFECHA AND [INTACIERTOS] = @original_INTACIERTOS AND [INTERRORES] = @original_INTERRORES AND [INTCALIFICACION] = @original_INTCALIFICACION AND [INTTOTALCARTAS] = @original_INTTOTALCARTAS AND [BOOLDIFICIL] = @original_BOOLDIFICIL AND (([INTSONIDO] = @original_INTSONIDO) OR ([INTSONIDO] IS NULL AND @original_INTSONIDO IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_INTIDJUEGO" Type="Int32" />
            <asp:Parameter Name="original_INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter DbType="DateTime2" Name="original_DATEFECHA" />
            <asp:Parameter Name="original_INTACIERTOS" Type="Int32" />
            <asp:Parameter Name="original_INTERRORES" Type="Int32" />
            <asp:Parameter Name="original_INTCALIFICACION" Type="Int32" />
            <asp:Parameter Name="original_INTTOTALCARTAS" Type="Int32" />
            <asp:Parameter Name="original_BOOLDIFICIL" Type="Int16" />
            <asp:Parameter Name="original_INTSONIDO" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter DbType="DateTime2" Name="DATEFECHA" />
            <asp:Parameter Name="INTACIERTOS" Type="Int32" />
            <asp:Parameter Name="INTERRORES" Type="Int32" />
            <asp:Parameter Name="INTCALIFICACION" Type="Int32" />
            <asp:Parameter Name="INTTOTALCARTAS" Type="Int32" />
            <asp:Parameter Name="BOOLDIFICIL" Type="Int16" />
            <asp:Parameter Name="INTSONIDO" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter DbType="DateTime2" Name="DATEFECHA" />
            <asp:Parameter Name="INTACIERTOS" Type="Int32" />
            <asp:Parameter Name="INTERRORES" Type="Int32" />
            <asp:Parameter Name="INTCALIFICACION" Type="Int32" />
            <asp:Parameter Name="INTTOTALCARTAS" Type="Int32" />
            <asp:Parameter Name="BOOLDIFICIL" Type="Int16" />
            <asp:Parameter Name="INTSONIDO" Type="Int32" />
            <asp:Parameter Name="original_INTIDJUEGO" Type="Int32" />
            <asp:Parameter Name="original_INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter DbType="DateTime2" Name="original_DATEFECHA" />
            <asp:Parameter Name="original_INTACIERTOS" Type="Int32" />
            <asp:Parameter Name="original_INTERRORES" Type="Int32" />
            <asp:Parameter Name="original_INTCALIFICACION" Type="Int32" />
            <asp:Parameter Name="original_INTTOTALCARTAS" Type="Int32" />
            <asp:Parameter Name="original_BOOLDIFICIL" Type="Int16" />
            <asp:Parameter Name="original_INTSONIDO" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
     <asp:GridView ID="gvHistorial" runat="server" DataSourceID="SQLDSHistorial" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True">
         <Columns>
             <asp:CommandField ShowSelectButton="True" SelectText="Ver Detalle" />
             <asp:BoundField DataField="INTIDJUEGO" HeaderText="INTIDJUEGO" SortExpression="INTIDJUEGO" />
             <asp:BoundField DataField="INTCVEJUGADOR" HeaderText="INTCVEJUGADOR" SortExpression="INTCVEJUGADOR" />
             <asp:BoundField DataField="DATEFECHA" HeaderText="DATEFECHA" SortExpression="DATEFECHA" />
             <asp:BoundField DataField="INTACIERTOS" HeaderText="INTACIERTOS" SortExpression="INTACIERTOS" />
             <asp:BoundField DataField="INTERRORES" HeaderText="INTERRORES" SortExpression="INTERRORES" />
             <asp:BoundField DataField="INTCALIFICACION" HeaderText="INTCALIFICACION" SortExpression="INTCALIFICACION" />
             <asp:BoundField DataField="INTTOTALCARTAS" HeaderText="INTTOTALCARTAS" SortExpression="INTTOTALCARTAS" />
             <asp:BoundField DataField="BOOLDIFICIL" HeaderText="BOOLDIFICIL" SortExpression="BOOLDIFICIL" />
             <asp:BoundField DataField="INTSONIDO" HeaderText="INTSONIDO" SortExpression="INTSONIDO" />
         </Columns>
          <emptydatatemplate>
              <p>No datos de juegos</p>
        </emptydatatemplate>
     </asp:GridView>
</asp:Content>