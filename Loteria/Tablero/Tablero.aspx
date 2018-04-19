<%@ Page Title="Es hora de jugar" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Tablero.aspx.cs" Inherits="Tablero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        /* Set widths on the form inputs since otherwise they're 100% wide */
        input,
        select,
        textarea {
 
            width: 100%;            
        }

        tc{
            vertical-align:center;

        }
        .cardAtHand{
            text-align:center; 
            background-color:limegreen;
        }
        
 
    </style>
    <h2>
         <script type="text/javascript" src="<%= ResolveUrl ("~/Scripts/Audio.js") %>"></script>
        <asp:ImageButton ID="imgBtnRefresh" runat="server" ImageUrl="~/images/fijo/refresh.png" OnClick="imgBtnRefresh_Click" Width="100px"/>
        
        <asp:Label ID="lblSortQuestion" runat="server" Text="¿Cambiar el tablero?"></asp:Label>
    </h2>
    <h1>
        <asp:Label ID="lblGameFinished" runat="server" ForeColor="Red" Text="Fin del juego, gracias por jugar" Visible="False"></asp:Label>
    </h1>
    <h2 >   
        <asp:Label ID="lblScoreboard" runat="server" Text="Aciertos: "></asp:Label><asp:Label ID="lblScore" runat="server" Text="0"></asp:Label> 
    </h2>
    <asp:HiddenField ID="hdnUsedSound" runat="server" Value="0" />
    <table class="table table-bordered table-striped table-responsive" >
        <tr>
            <td>
                <asp:Image CssClass="menuImage" ID="imgCardAtHand" runat="server" Visible="False" />
                <asp:ImageButton CssClass="menuImage" ID="imgBtnShowImage" runat="server" ImageUrl="~/images/fijo/question.jpg" OnClick="imgBtnShowImage_Click" />

                

            </td>
            <td>
                <asp:ImageButton ID="btnSkip" CssClass="menuImage" runat="server" Text="Button" ImageUrl="~/images/fijo/skip.jpg" OnClick="btnSkip_Click"/>
            </td>
            <td>
                <asp:ImageButton ID="imgBtnMakeNoise" runat="server" ImageUrl="~/images/fijo/speaker.jpg" Width="100%" OnClientClick="javascript:makeNoise(); return false;" CausesValidation="False" />
                <br />
                <asp:Button ID="btnFinish" runat="server" Text="¿Terminar?" OnClientClick="if(!confirm('Desea terminar el juego? El juego se calificará acordemente \nAl menos dos cartas se debieron haber jugado')) return false" OnClick="btnFinish_Click" CssClass="btn btn-danger"/>
            </td>
                
        </tr>    
    </table>
    
    
    <h1 class="cardAtHand"><strong><asp:Label ID="lblCardAtHand" runat="server" Text="CartaEnMano" ></asp:Label></strong></h1>
     
            
    <asp:Table ID="tbTablero" runat="server" CssClass="table table-bordered table-striped table-responsive">
    </asp:Table>    

</asp:Content>

