<%@ Page Title="Lotería Virtual" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Bienvenido</h1>
        <p class="lead">La Loteria Virtual te ayudará a que niños mejores sus habilidades lingüinsticas al escuchar, ver y leer.</p>
        <% if ( Session["role"] != null && Session["role"].ToString().Equals("J")) { %>
            <p><a href="Tablero/Default.aspx" class="btn btn-primary btn-lg">Inicar Juego Nuevo</a></p>
        <% } %>
    </div>
   
    
 
</asp:Content>
