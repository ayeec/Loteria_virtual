<%@ Page Title="Empezar Juego" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Tablero_Default" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        /* Set widths on the form inputs since otherwise they're 100% wide */
        .ckb input[type="checkbox"] 
         {
 
            margin-right: 5px
        }
    </style>
    <h1>
        Bienvenido <%= JugadorName %>
    </h1>
    <p>Introduzca los parametros para empezar:</p>
    <p>
        <asp:Label ID="lblSize" runat="server" Text="Tamaño del tablero:" Font-Bold="false" Font-Italic="true"></asp:Label>
        <asp:TextBox ID="txtSlider" MaxLength="1" runat="server" Width="15pt" Enabled="false" Font-Bold="true"></asp:TextBox>
        <asp:TextBox ID="txtSize" runat="server" ></asp:TextBox>
        <ajaxToolkit:SliderExtender ID="txtSize_SliderExtender" runat="server" BehaviorID="txtSize_SliderExtender" Maximum="5" Minimum="2" TargetControlID="txtSize" BoundControlID="txtSlider" Steps="4"/>
        <br />
        <asp:CheckBox ID="chkHard" runat="server" Text="¿Desactivar ayuda?" CssClass="ckb" Font-Bold="false" Font-Italic="true"/>
        <br/>
        <asp:Button ID="btnStartGame" runat="server" CssClass="btn btn-success btn-block" Text="Iniciar Juego" OnClick="btnStartGame_Click" />

    </p>
</asp:Content>

