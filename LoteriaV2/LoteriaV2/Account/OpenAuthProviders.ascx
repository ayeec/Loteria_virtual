<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OpenAuthProviders.ascx.cs" Inherits="OpenAuthProviders" %>

<div id="socialLoginList">
    <h4>Inicia sesión con otro servicio.</h4>
    <hr />
    <asp:ListView runat="server" ID="providerDetails" ItemType="System.String"
        SelectMethod="GetProviderNames" ViewStateMode="Disabled">
        <ItemTemplate>
            <p>
                <button type="submit" class="btn btn-default" name="provider" value="<%#: Item %>"
                    title="Iniciar sesión con tu cuenta de <%#: Item %>.">
                    <%#: Item %>
                </button>
            </p>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div>
                <p>No hay servicios externos de autenticación configurados. Consulta <a href="https://go.microsoft.com/fwlink/?LinkId=252803">este artículo</a> para obtener información sobre cómo habilitar el inicio de sesión con servicios externos.</p>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>
</div>