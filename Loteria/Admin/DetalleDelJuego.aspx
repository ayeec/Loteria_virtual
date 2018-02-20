<%@ Page Title="Ver Detalle del Juego/Sesión" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="DetalleDelJuego.aspx.cs" Inherits="Admin_Detalle" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Detalle del Juego <%= Request.QueryString["idJuego"] %></h1>
    <br />                    
    <asp:ListView ID="lvHistorialJuego" runat="server" DataKeyNames="INTIDJUEGO" DataSourceID="SQLDSHistorialJuego">
        <EmptyDataTemplate>
            <span>Sin datos a mostrar.</span>
        </EmptyDataTemplate>
        <ItemTemplate>
            <span style="">ID Juego:
            <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
            <br />
            Jugador:
            <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("nombreJugador") %>' />
            <br />
            Fecha del juego:
            <asp:Label ID="DATEFECHALabel" runat="server" Text='<%# Eval("DATEFECHA") %>' />
            <br />
            Total aciertos:
            <asp:Label ID="INTACIERTOSLabel" runat="server" Text='<%# Eval("INTACIERTOS") %>' />
            <br />
            Total errores:
            <asp:Label ID="INTERRORESLabel" runat="server" Text='<%# Eval("INTERRORES") %>' />
            <br />
            Calificación (aciertos/total_cartas*10):
            <asp:Label ID="INTCALIFICACIONLabel" runat="server" Text='<%# Eval("INTCALIFICACION") %>' />
            <br />
            Total de cartas / Tamaño del tablero:
            <asp:Label ID="INTTOTALCARTASLabel" runat="server" Text='<%# Eval("INTTOTALCARTAS") %>' />
            <br />
            ¿Jugó en modo dificil?:
            <asp:Label ID="BOOLDIFICILLabel" runat="server" Text='<%# Eval("BOOLDIFICIL") %>' />
            <br />
            ¿Cuantas veces hizo uso del sonido?:
            <asp:Label ID="INTSONIDOLabel" runat="server" Text='<%# Eval("INTSONIDO") %>' />
            <br />
<br /></span>
        </ItemTemplate>
        <LayoutTemplate>
            <div id="itemPlaceholderContainer" runat="server" style="">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="">
            </div>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <span style="">INTIDJUEGO:
            <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
            <br />
            INTCVEJUGADOR:
            <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("INTCVEJUGADOR") %>' />
            <br />
            DATEFECHA:
            <asp:Label ID="DATEFECHALabel" runat="server" Text='<%# Eval("DATEFECHA") %>' />
            <br />
            INTACIERTOS:
            <asp:Label ID="INTACIERTOSLabel" runat="server" Text='<%# Eval("INTACIERTOS") %>' />
            <br />
            INTERRORES:
            <asp:Label ID="INTERRORESLabel" runat="server" Text='<%# Eval("INTERRORES") %>' />
            <br />
            INTCALIFICACION:
            <asp:Label ID="INTCALIFICACIONLabel" runat="server" Text='<%# Eval("INTCALIFICACION") %>' />
            <br />
            INTTOTALCARTAS:
            <asp:Label ID="INTTOTALCARTASLabel" runat="server" Text='<%# Eval("INTTOTALCARTAS") %>' />
            <br />
            BOOLDIFICIL:
            <asp:Label ID="BOOLDIFICILLabel" runat="server" Text='<%# Eval("BOOLDIFICIL") %>' />
            <br />
            INTSONIDO:
            <asp:Label ID="INTSONIDOLabel" runat="server" Text='<%# Eval("INTSONIDO") %>' />
            <br />
<br /></span>
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="SQLDSHistorialJuego" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        SelectCommand="SELECT hr.*, CONCAT(j.INTCVEJUGADOR,'-',j.VCHNOMBRE) as nombreJugador
        FROM [historialresultados] as hr
        JOIN jugador as j
        ON j.INTCVEJUGADOR = hr.INTCVEJUGADOR
WHERE hr.INTIDJUEGO = @idJuego">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="idJuego" QueryStringField="idJuego" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLDSDetalle" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        SelectCommand="
        SELECT dj.*, CONCAT(c.INTCVECARTA,'-',c.VCHNOMBRE) as nombreCarta
        FROM [detallejuego] as dj
        JOIN cartas as c
        ON c.INTCVECARTA = dj.INTCVECARTA
WHERE dj.INTIDJUEGO = @idJuego">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="idJuego" QueryStringField="idJuego" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:ListView ID="lvDetalleDelJuego" runat="server" DataKeyNames="INTIDDETALLE,INTCVECARTA" DataSourceID="SQLDSDetalle">
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>Sin detalle a mostrar</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr style="background-color:#DCDCDC;color: #000000;">
                <td>
                    <asp:Label ID="INTIDDETALLELabel" runat="server" Text='<%# Eval("INTIDDETALLE") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("nombreCarta") %>' />
                </td>
                <td>
                    <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="ckbActivo" runat="server" Enabled="false" Text="" Checked='<%# Eval("USASONIDO").ToString().Equals("1")? true:false %>' />
                </td>
                <td>
                    <asp:CheckBox ID="CheckBox1" runat="server" Enabled="false" Text="" Checked='<%# Eval("USAIMAGEN").ToString().Equals("1")? true:false %>' />
                </td>
                <td>
                    <asp:CheckBox ID="CheckBox2" runat="server" Enabled="false" Text="" Checked='<%# Eval("CORRECTO").ToString().Equals("1")? true:false %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                <th runat="server">ID detalle</th>
                                <th runat="server">Carta</th>
                                <th runat="server">ID Juego</th>
                                <th runat="server">¿Usó sonido?</th>
                                <th runat="server">¿Usó imagen?</th>
                                <th runat="server">¿Acertó?</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;"></td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                <td>
                    <asp:Label ID="INTIDDETALLELabel" runat="server" Text='<%# Eval("INTIDDETALLE") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                </td>
                <td>
                    <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
                </td>
                <td>
                    <asp:Label ID="USASONIDOLabel" runat="server" Text='<%# Eval("USASONIDO") %>' />
                </td>
                <td>
                    <asp:Label ID="USAIMAGENLabel" runat="server" Text='<%# Eval("USAIMAGEN") %>' />
                </td>
                <td>
                    <asp:Label ID="CORRECTOLabel" runat="server" Text='<%# Eval("CORRECTO") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
    <br />
     </asp:Content>