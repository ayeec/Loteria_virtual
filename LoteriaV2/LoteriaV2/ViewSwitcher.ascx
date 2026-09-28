<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewSwitcher.ascx.cs" Inherits="ViewSwitcher" %>
<div id="viewSwitcher">
    Vista <%: CurrentView == "Mobile" ? "móvil" : "escritorio" %> |
    <a href="<%: SwitchUrl %>" data-ajax="false">Cambiar a la vista de <%: AlternateView == "Mobile" ? "móvil" : "escritorio" %></a>
</div>
