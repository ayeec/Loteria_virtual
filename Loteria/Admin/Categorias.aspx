<%@ Page Title="Ver Categorias" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Categorias.aspx.cs" Inherits="Admin_Categorias" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCategorias" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [categoria]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [categoria] WHERE [INTIDCATEGORIA] = @original_INTIDCATEGORIA AND [VCHNOMBRE] = @original_VCHNOMBRE AND (([VCHDESCRIPCION] = @original_VCHDESCRIPCION) OR ([VCHDESCRIPCION] IS NULL AND @original_VCHDESCRIPCION IS NULL))" InsertCommand="INSERT INTO [categoria] ([VCHNOMBRE], [VCHDESCRIPCION]) VALUES (@VCHNOMBRE, @VCHDESCRIPCION)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [categoria] SET [VCHNOMBRE] = @VCHNOMBRE, [VCHDESCRIPCION] = @VCHDESCRIPCION WHERE [INTIDCATEGORIA] = @original_INTIDCATEGORIA AND [VCHNOMBRE] = @original_VCHNOMBRE AND (([VCHDESCRIPCION] = @original_VCHDESCRIPCION) OR ([VCHDESCRIPCION] IS NULL AND @original_VCHDESCRIPCION IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_VCHDESCRIPCION" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="VCHDESCRIPCION" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="VCHDESCRIPCION" Type="String" />
            <asp:Parameter Name="original_INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_VCHDESCRIPCION" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
     <asp:ListView ID="lvCategorias" runat="server" DataKeyNames="INTIDCATEGORIA" DataSourceID="SQLDSCategorias" InsertItemPosition="LastItem">
         
         <EditItemTemplate>
             <tr style="background-color: #FFCC66;color: #000080;">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel1" runat="server" Text='<%# Eval("INTIDCATEGORIA") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>' MaxLength="45"/>
                 </td>
                 <td>
                     <asp:TextBox ID="VCHDESCRIPCIONTextBox" runat="server" Text='<%# Bind("VCHDESCRIPCION") %>' MaxLength="45"/>
                 </td>
             </tr>
         </EditItemTemplate>
         <EmptyDataTemplate>
             <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                 <tr>
                     <td>Sin categorias registradas</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr style="">
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" />
                 </td>
                 <td>&nbsp;</td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>' MaxLength="45" />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHDESCRIPCIONTextBox" runat="server" Text='<%# Bind("VCHDESCRIPCION") %>' />
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr style="background-color: #FFFBD6;color: #333333;">
                 <td>
                     <asp:HyperLink ID="lnkCategoriaID" runat="server" Text="Asignar cartas" Target="_blank" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "INTIDCATEGORIA","CartasdeCategoria.aspx?IDcategoria={0}") %>'></asp:HyperLink>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" />
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel" runat="server" Text='<%# Eval("INTIDCATEGORIA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHNOMBRELabel" runat="server" Text='<%# Eval("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHDESCRIPCIONLabel" runat="server" Text='<%# Eval("VCHDESCRIPCION") %>' />
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
                                 <th runat="server">ID Categoria</th>
                                 <th runat="server">Nombre</th>
                                 <th runat="server">Descripción</th>
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
                     <asp:Button ID="btnAssignCartastoCategoria" runat="server" CommandName="Select" Text="Asignar Categorias" />
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" />
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel" runat="server" Text='<%# Eval("INTIDCATEGORIA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHNOMBRELabel" runat="server" Text='<%# Eval("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHDESCRIPCIONLabel" runat="server" Text='<%# Eval("VCHDESCRIPCION") %>' />
                 </td>
             </tr>
         </SelectedItemTemplate>
    </asp:ListView>
</asp:Content>