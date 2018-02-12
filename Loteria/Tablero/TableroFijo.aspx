<%@ Page Title="Es hora de jugar" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TableroFijo.aspx.cs" Inherits="Tablero_TableroFijo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>
        <script src="../Scripts/Audio.js"></script>
        <asp:ImageButton ID="imgBtnRefresh" runat="server" ImageUrl="~/images/fijo/refresh.png" OnClick="imgBtnRefresh_Click" Width="100px"/>
        
        <asp:Label ID="lblSortQuestion" runat="server" Text="¿Cambiar el tablero?"></asp:Label>
    </h2>
    <h1>
        <asp:Label ID="lblGameFinished" runat="server" ForeColor="Red" Text="Fin del juego, gracias por jugar" Visible="False"></asp:Label>
    </h1>
    <h2>
        <asp:Label ID="Label1" runat="server" Text="Puntuación: "></asp:Label><asp:Label ID="lblScore" runat="server" Text="0"></asp:Label> 
        
    </h2>
    
    <table>
        <tr>
            <td>
                <asp:Table ID="tbTablero" runat="server" Width="50%">
                </asp:Table>    
            </td>
            <td style="width: 185px">
                <asp:Image ID="imgCardAtHand" runat="server" Visible="False" Width="50%" />
                <h2><asp:Label ID="lblCardAtHand" runat="server" Text="CartaEnMano" ></asp:Label>
                    <asp:ImageButton ID="imgBtnShowImage" runat="server" ImageUrl="~/images/fijo/flip.png" Width="100%" OnClick="imgBtnShowImage_Click" />
                </h2>
                <br />
                <asp:ImageButton ID="imgBtnMakeNoise" runat="server" ImageUrl="~/images/fijo/speaker.jpg" Width="100%" OnClientClick="javascript:makeNoise(); return false;" CausesValidation="False" />
                <asp:HiddenField ID="hdnUsedSound" runat="server" Value="0" />
            </td>
        </tr>
    </table>
</asp:Content>

