<%@ Page Title="Empezar Juego" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Tablero_Default" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>
        Bienvenido <%= JugadorName %>
    </h1>
    <p>Introduzca los parametros para empezar:</p>
    <p>
        <asp:Label ID="lblSize" runat="server" Text="Tamaño del tablero:"></asp:Label>
        <asp:TextBox ID="txtSlider" MaxLength="1" runat="server" Width="15pt" Enabled="false"></asp:TextBox>
        <asp:TextBox ID="txtSize" runat="server" ></asp:TextBox>
        <ajaxToolkit:SliderExtender ID="txtSize_SliderExtender" runat="server" BehaviorID="txtSize_SliderExtender" Maximum="5" Minimum="2" TargetControlID="txtSize" BoundControlID="txtSlider" Steps="4"/>
        <asp:CheckBox ID="chkHard" runat="server" Text="¿Jugar modo dificil?" />
        <br/>
        <asp:Button ID="btnStartGame" runat="server" CssClass="btn btn-primary btn-lg" Text="Iniciar Juego" OnClick="btnStartGame_Click" />

    </p>
</asp:Content>

