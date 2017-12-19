<%@ Page Title="Ver Historial de Juegos" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="HistorialJuegos.aspx.cs" Inherits="Admin_HistorialJuegos" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSHistorial" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="sp_historialresultados_select_all" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
     <asp:GridView ID="gvHistorial" runat="server" DataSourceID="SQLDSHistorial" AutoGenerateColumns="False">
         <Columns>
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
     </asp:GridView>
</asp:Content>