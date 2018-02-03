<%@ Page Title="Ver Historial de Juegos" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="HistorialJuegos.aspx.cs" Inherits="Admin_HistorialJuegos" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSHistorial" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        SelectCommand="SELECT hr.*, CONCAT(j.INTCVEJUGADOR,'-',j.VCHNOMBRE) as nombreJugador
        FROM [historialresultados] as hr
        JOIN jugador as j
        ON j.INTCVEJUGADOR = hr.INTCVEJUGADOR" 
        ConflictDetection="CompareAllValues" 
        DeleteCommand="sp_historialresultados_delete" 
        InsertCommand="INSERT INTO [historialresultados] ([INTCVEJUGADOR], [DATEFECHA], [INTACIERTOS], [INTERRORES], [INTCALIFICACION], [INTTOTALCARTAS], [BOOLDIFICIL], [INTSONIDO]) VALUES (@INTCVEJUGADOR, @DATEFECHA, @INTACIERTOS, @INTERRORES, @INTCALIFICACION, @INTTOTALCARTAS, @BOOLDIFICIL, @INTSONIDO)" 
        OldValuesParameterFormatString="original_{0}" 
        UpdateCommand="UPDATE [historialresultados] SET [INTCVEJUGADOR] = @INTCVEJUGADOR, [DATEFECHA] = @DATEFECHA, [INTACIERTOS] = @INTACIERTOS, [INTERRORES] = @INTERRORES, [INTCALIFICACION] = @INTCALIFICACION, [INTTOTALCARTAS] = @INTTOTALCARTAS, [BOOLDIFICIL] = @BOOLDIFICIL, [INTSONIDO] = @INTSONIDO WHERE [INTIDJUEGO] = @original_INTIDJUEGO AND [INTCVEJUGADOR] = @original_INTCVEJUGADOR AND [DATEFECHA] = @original_DATEFECHA AND [INTACIERTOS] = @original_INTACIERTOS AND [INTERRORES] = @original_INTERRORES AND [INTCALIFICACION] = @original_INTCALIFICACION AND [INTTOTALCARTAS] = @original_INTTOTALCARTAS AND [BOOLDIFICIL] = @original_BOOLDIFICIL AND (([INTSONIDO] = @original_INTSONIDO) OR ([INTSONIDO] IS NULL AND @original_INTSONIDO IS NULL))" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="IDJuego" Type="Int32" />
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
     <br />
    <asp:ListView ID="lvHIstorialJuegos" runat="server" DataKeyNames="INTIDJUEGO" DataSourceID="SQLDSHistorial">
        <EditItemTemplate>
            <tr style="background-color:#008A8C;color: #FFFFFF;">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                </td>
                <td>
                    <asp:Label ID="INTIDJUEGOLabel1" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTCVEJUGADORTextBox" runat="server" Text='<%# Bind("INTCVEJUGADOR") %>' />
                </td>
                <td>
                    <asp:TextBox ID="DATEFECHATextBox" runat="server" Text='<%# Bind("DATEFECHA") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTACIERTOSTextBox" runat="server" Text='<%# Bind("INTACIERTOS") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTERRORESTextBox" runat="server" Text='<%# Bind("INTERRORES") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTCALIFICACIONTextBox" runat="server" Text='<%# Bind("INTCALIFICACION") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTTOTALCARTASTextBox" runat="server" Text='<%# Bind("INTTOTALCARTAS") %>' />
                </td>
                <td>
                    <asp:TextBox ID="BOOLDIFICILTextBox" runat="server" Text='<%# Bind("BOOLDIFICIL") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTSONIDOTextBox" runat="server" Text='<%# Bind("INTSONIDO") %>' />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>Sin datos a mostrar.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" />
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:TextBox ID="INTCVEJUGADORTextBox" runat="server" Text='<%# Bind("INTCVEJUGADOR") %>' />
                </td>
                <td>
                    <asp:TextBox ID="DATEFECHATextBox" runat="server" Text='<%# Bind("DATEFECHA") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTACIERTOSTextBox" runat="server" Text='<%# Bind("INTACIERTOS") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTERRORESTextBox" runat="server" Text='<%# Bind("INTERRORES") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTCALIFICACIONTextBox" runat="server" Text='<%# Bind("INTCALIFICACION") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTTOTALCARTASTextBox" runat="server" Text='<%# Bind("INTTOTALCARTAS") %>' />
                </td>
                <td>
                    <asp:TextBox ID="BOOLDIFICILTextBox" runat="server" Text='<%# Bind("BOOLDIFICIL") %>' />
                </td>
                <td>
                    <asp:TextBox ID="INTSONIDOTextBox" runat="server" Text='<%# Bind("INTSONIDO") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color:#DCDCDC;color: #000000;">
                <td>
                    <asp:HyperLink ID="lnkJuegoID" runat="server" Text="Ver detalle" Target="_blank" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "INTIDJUEGO","DetalleDelJuego.aspx?idJuego={0}") %>'></asp:HyperLink>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" CssClass="delButton" OnClientClick="if(!confirm('Desea borrarlo?')) return false" />
                </td>
                <td>
                    <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("nombreJugador") %>' />
                </td>
                <td>
                    <asp:Label ID="DATEFECHALabel" runat="server" Text='<%# Eval("DATEFECHA") %>' />
                </td>
                <td>
                    <asp:Label ID="INTACIERTOSLabel" runat="server" Text='<%# Eval("INTACIERTOS") %>' />
                </td>
                <td>
                    <asp:Label ID="INTERRORESLabel" runat="server" Text='<%# Eval("INTERRORES") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCALIFICACIONLabel" runat="server" Text='<%# Eval("INTCALIFICACION") %>' />
                </td>
                <td>
                    <asp:Label ID="INTTOTALCARTASLabel" runat="server" Text='<%# Eval("INTTOTALCARTAS") %>' />
                </td>
                <td>
                    <asp:Label ID="BOOLDIFICILLabel" runat="server" Text='<%# Eval("BOOLDIFICIL") %>' />
                </td>
                <td>
                    <asp:Label ID="INTSONIDOLabel" runat="server" Text='<%# Eval("INTSONIDO") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                <th runat="server"></th>
                                <th runat="server">ID juego</th>
                                <th runat="server">Jugador</th>
                                <th runat="server">Fecha del juego</th>
                                <th runat="server">Total Aciertos</th>
                                <th runat="server">Total Errores</th>
                                <th runat="server">Calificación</th>
                                <th runat="server">Tamaño del tablero</th>
                                <th runat="server">¿Modo dificil?</th>
                                <th runat="server">Sonido usado X veces</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar"  />
                </td>
                <td>
                    <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("INTCVEJUGADOR") %>' />
                </td>
                <td>
                    <asp:Label ID="DATEFECHALabel" runat="server" Text='<%# Eval("DATEFECHA") %>' />
                </td>
                <td>
                    <asp:Label ID="INTACIERTOSLabel" runat="server" Text='<%# Eval("INTACIERTOS") %>' />
                </td>
                <td>
                    <asp:Label ID="INTERRORESLabel" runat="server" Text='<%# Eval("INTERRORES") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCALIFICACIONLabel" runat="server" Text='<%# Eval("INTCALIFICACION") %>' />
                </td>
                <td>
                    <asp:Label ID="INTTOTALCARTASLabel" runat="server" Text='<%# Eval("INTTOTALCARTAS") %>' />
                </td>
                <td>
                    <asp:Label ID="BOOLDIFICILLabel" runat="server" Text='<%# Eval("BOOLDIFICIL") %>' />
                </td>
                <td>
                    <asp:Label ID="INTSONIDOLabel" runat="server" Text='<%# Eval("INTSONIDO") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
</asp:Content>