<%@ Page Title="Ver Detalle del Juego/Sesión" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="DetalleDelJuego.aspx.cs" Inherits="Admin_Detalle" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Detalle del Juego <%= Request.QueryString["idJuego"] %></h1>
    <br />                    
    <asp:ListView ID="lvHistorialJuego" runat="server" DataKeyNames="INTIDJUEGO" DataSourceID="SQLDSHistorialJuego">
        <EmptyDataTemplate>
            <span>Sin datos a mostrar.</span>
        </EmptyDataTemplate>
        <ItemTemplate>
            <span>ID Juego:
            <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
            <br />
            Jugador:
            <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("nombreJugador") %>' />
            <br />
            Fecha del juego:
            <asp:Label ID="DATEFECHALabel" runat="server" Text='<%# Eval("DATEFECHA") %>' />
            <br />
            Tamaño del tablero:
            <asp:Label ID="INTTOTALCARTASLabel" runat="server" Text='<%# Eval("INTTOTALCARTAS") %>' />
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
            ¿Jugó con ayuda desactivada?:
            <asp:Label ID="BOOLDIFICILLabel" runat="server" Text='<%# Eval("BOOLDIFICIL").ToString().Equals("1")? "Verdadero":"Falso" %>' />
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
        SELECT dj.*, CONCAT(c.INTCVECARTA,'-',c.VCHNOMBRE) as nombreCarta, f.VCHARFRASE, c.VCHNOMBRE
        FROM [detallejuego] as dj
        JOIN cartas as c
		ON c.INTCVECARTA = dj.INTCVECARTA
		LEFT JOIN frases as f
		ON f.INTIDFRASE = dj.INTIDFRASE
WHERE dj.INTIDJUEGO = @idJuego">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="idJuego" QueryStringField="idJuego" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:ListView ID="lvDetalleDelJuego" runat="server" DataKeyNames="INTIDDETALLE,INTCVECARTA" DataSourceID="SQLDSDetalle">
        <EmptyDataTemplate>
            <table runat="server" class="table table-bordered table-striped table-responsive">
                <tr>
                    <td><p><strong>Sin detalle a mostrar</strong></p></td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label ID="INTIDDETALLELabel" runat="server" Text='<%# Eval("INTIDDETALLE") %>' />
                </td>
                <td>
                    <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("nombreCarta") %>' />
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
                <td>
                    <asp:Label ID="VCHARFRASELabel" runat="server" Text='<%# String.IsNullOrEmpty(Eval("VCHARFRASE").ToString())?Eval("VCHNOMBRE"):Eval("VCHARFRASE") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="table table-bordered table-striped table-responsive">
                            <tr runat="server">
                                <th runat="server">ID detalle</th>
                                <th runat="server">Carta</th>
                                <th runat="server">¿Usó sonido?</th>
                                <th runat="server">¿Usó imagen?</th>
                                <th runat="server">¿Acertó?</th>
                                <th runat="server">Frase usada</th>
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
                <td>
                    <asp:Label ID="VCHARFRASELabel" runat="server" Text='<%# Eval("VCHARFRASE") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
    <br />
     </asp:Content>