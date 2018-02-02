﻿<%@ Page Title="Ver Cartas la Categoria" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CartasdeCategoria.aspx.cs" Inherits="CartasDeCategoria_Jugadores" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCartasDeCategoria" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [cartascategoria] WHERE [INTIDCATEGORIA] = CASE WHEN  @INTIDCATEGORIA > 0 THEN @INTIDCATEGORIA  ELSE [INTIDCATEGORIA] END " ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [cartascategoria] WHERE [INTIDCATEGORIA] = @original_INTIDCATEGORIA AND [INTCVECARTA] = @original_INTCVECARTA" InsertCommand="INSERT INTO [cartascategoria] ([INTIDCATEGORIA], [INTCVECARTA]) VALUES (@INTIDCATEGORIA, @INTCVECARTA)" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="original_INTCVECARTA" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="INTCVECARTA" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="INTIDCATEGORIA" QueryStringField="IDCategoria" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
     <h1 id="h1Main" runat="server">Titulo</h1>
     <br />
     <asp:ListView ID="lvCartasDeCategoria" runat="server" DataKeyNames="INTIDCATEGORIA,INTCVECARTA" DataSourceID="SQLDSCartasDeCategoria" InsertItemPosition="LastItem">

         <EditItemTemplate>
             <tr style="background-color: #FFCC66;color: #000080;">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel1" runat="server" Text='<%# Eval("INTIDCATEGORIA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel1" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
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
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" OnClick="InsertButton_Click" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" />
                 </td>
                 <td>
                      <asp:DropDownList ID="ddlIDcategorias" runat="server"  DataSourceID="dsIDCategoria" DataTextField="detail" DataValueField="INTIDCATEGORIA" OnDataBound="ddlIDcategorias_DataBound" >
                          <asp:ListItem Value="0">Seleccione una Categoria</asp:ListItem>
    </asp:DropDownList>
                     <asp:TextBox ID="INTIDCATEGORIATextBox" runat="server" Text='<%# Bind("INTIDCATEGORIA") %>' Visible="false" />
                 </td>
                 <td>
                    <asp:DropDownList ID="ddlCartasByIDcategoria" runat="server" DataSourceID="dsCartas" DataTextField="VCHNOMBRE" DataValueField="INTCVECARTA" OnDataBound="ddlCartasByIDcategoria_DataBound">
                        <asp:ListItem Value="0">Seleccione una Categoria</asp:ListItem>
    </asp:DropDownList>
                     
                     <asp:TextBox ID="INTCVECARTATextBox" runat="server" Text='<%# Bind("INTCVECARTA") %>' Visible="false"/>
                     <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="RangeValidator" ControlToValidate="INTCVECARTATextBox" MinimumValue="1" Type="Integer" MaximumValue="100000"></asp:RangeValidator>
                 </td>
                 
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr style="background-color: #FFFBD6;color: #333333;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false" CssClass="delButton"/>
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel" runat="server" Text='<%# Eval("INTIDCATEGORIA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
             </tr>
         </ItemTemplate>
         <LayoutTemplate>
             <table runat="server">
                 <tr runat="server">
                     <td runat="server">
                         <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                             <tr runat="server" style="background-color: #FFFBD6;color: #333333;">
                                 <th runat="server"></th>
                                 <th runat="server">INTIDCATEGORIA</th>
                                 <th runat="server">INTCVECARTA</th>
                             </tr>
                             <tr id="itemPlaceholder" runat="server">
                             </tr>
                         </table>
                     </td>
                 </tr>
                 <tr runat="server">
                     <td runat="server" style="text-align: center;background-color: #FFCC66;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
                         <asp:DataPager ID="DataPager1" runat="server">
                             <Fields>
                                 <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                 <asp:NumericPagerField />
                                 <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                             </Fields>
                         </asp:DataPager>
                     </td>
                 </tr>
             </table>
         </LayoutTemplate>
         <SelectedItemTemplate>
             <tr style="background-color: #FFCC66;font-weight: bold;color: #000080;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" />
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel" runat="server" Text='<%# Eval("INTIDCATEGORIA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
             </tr>
         </SelectedItemTemplate>
    </asp:ListView>
    
    <br />
   
    <asp:SqlDataSource ID="dsIDCategoria" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT CONCAT ([INTIDCATEGORIA],' - ', VCHNOMBRE) AS detail, INTIDCATEGORIA FROM [categoria]">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="dsCartas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM cartas where intcvecarta NOT IN (select intcvecarta FROM cartascategoria WHERE [INTIDCATEGORIA] = CASE WHEN  @INTIDCATEGORIA > 0 THEN @INTIDCATEGORIA  ELSE [INTIDCATEGORIA] END )">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="INTIDCATEGORIA" QueryStringField="IDcategoria" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
              
    
</asp:Content>