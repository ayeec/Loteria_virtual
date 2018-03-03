<%@ Page Title="Ver Cartas" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Cartas.aspx.cs" Inherits="Admin_Cartas" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCartas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        SelectCommand="SELECT * FROM [cartas]" 
        DeleteCommand="DELETE FROM [cartas] WHERE [INTCVECARTA] = @original_INTCVECARTA " 
        InsertCommand="INSERT INTO [cartas] ([VCHNOMBRE], [RUTAIMAGEN], [VCHTEXTO]) VALUES (@VCHNOMBRE, @RUTAIMAGEN, @VCHTEXTO)" OldValuesParameterFormatString="original_{0}" 
        UpdateCommand="UPDATE [cartas] SET [VCHNOMBRE] = @VCHNOMBRE, [RUTAIMAGEN] = @RUTAIMAGEN, [VCHTEXTO] = @VCHTEXTO WHERE [INTCVECARTA] = @original_INTCVECARTA AND [VCHNOMBRE] = @original_VCHNOMBRE AND (([RUTAIMAGEN] = @original_RUTAIMAGEN) OR ([RUTAIMAGEN] IS NULL AND @original_RUTAIMAGEN IS NULL)) AND (([VCHTEXTO] = @original_VCHTEXTO) OR ([VCHTEXTO] IS NULL AND @original_VCHTEXTO IS NULL))" OnDeleted="SQLDSCartas_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="original_INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_RUTAIMAGEN" Type="String" />
            <asp:Parameter Name="original_VCHTEXTO" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="RUTAIMAGEN" Type="String" />
            <asp:Parameter Name="VCHTEXTO" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="RUTAIMAGEN" Type="String" />
            <asp:Parameter Name="VCHTEXTO" Type="String" />
            <asp:Parameter Name="original_INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_RUTAIMAGEN" Type="String" />
            <asp:Parameter Name="original_VCHTEXTO" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
     <h1 id="h1Main">Cartas</h1>
    
     <asp:ListView ID="lvCartas" runat="server" DataKeyNames="INTCVECARTA" DataSourceID="SQLDSCartas" InsertItemPosition="LastItem">
         
         <EditItemTemplate>
             <tr style="background-color:#008A8C;color: #FFFFFF;">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" OnClick="UpdateButton_Click" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel1" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="RUTAIMAGENTextBox" runat="server" Text='<%# Bind("RUTAIMAGEN") %>'  Visible="false"/>
                     
                     <asp:FileUpload ID="filUpImageInsert" runat="server" />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHTEXTOTextBox" runat="server" Text='<%# Bind("VCHTEXTO") %>' />
                 </td>
             </tr>
         </EditItemTemplate>
         <EmptyDataTemplate>
             <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                 <tr>
                     <td>No hay Cartas en el sistema.</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr style="">
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" OnClick="InsertButton_Click"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" />
                 </td>
                 <td>&nbsp;</td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="RUTAIMAGENTextBox" runat="server" Text='<%# Bind("RUTAIMAGEN") %>'  Visible="false"/>
                     
                     <asp:FileUpload ID="filUpImageInsert" runat="server"/>
                 </td>
                 <td>
                     <asp:TextBox ID="VCHTEXTOTextBox" runat="server" Text='<%# Bind("VCHTEXTO") %>' />
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr style="background-color:#DCDCDC;color: #000000;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false"  CssClass="delButton"/>
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHNOMBRELabel" runat="server" Text='<%# Eval("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:Image ID="VCHNOMBREImage" runat="server" ImageUrl='<%# Eval("RUTAIMAGEN","~/images/{0}") %>' AlternateText='<%# Eval("VCHNOMBRE") %>' Width="35%"/>
                 </td>
                 <td>
                     <asp:Label ID="VCHTEXTOLabel" runat="server" Text='<%# Eval("VCHTEXTO") %>' />
                 </td>
             </tr>
         </ItemTemplate>
         <LayoutTemplate>
             <table runat="server">
                 <tr runat="server">
                     <td runat="server">
                         <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                             <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                 <th runat="server"></th>
                                 <th runat="server">ID Carta</th>
                                 <th runat="server">Nombre</th>
                                 <th runat="server">Imagen</th>
                                 <th runat="server">Texto</th>
                             </tr>
                             <tr id="itemPlaceholder" runat="server">
                             </tr>
                         </table>
                     </td>
                 </tr>
                 <tr runat="server">
                     <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                         <asp:DataPager ID="DataPager1" runat="server">
                             <Fields>
                                 <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                             </Fields>
                         </asp:DataPager>
                     </td>
                 </tr>
             </table>
         </LayoutTemplate>
         <SelectedItemTemplate>
             <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false"  />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHNOMBRELabel" runat="server" Text='<%# Eval("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="RUTAIMAGENLabel" runat="server" Text='<%# Eval("RUTAIMAGEN") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHTEXTOLabel" runat="server" Text='<%# Eval("VCHTEXTO") %>' />
                 </td>
             </tr>
         </SelectedItemTemplate>
    </asp:ListView>
     </asp:Content>