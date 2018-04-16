<%@ Page Title="Ver Categorias" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Categorias.aspx.cs" Inherits="Admin_Categorias" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCategorias" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        SelectCommand="SELECT * FROM [categoria]" 
        DeleteCommand="DELETE FROM [categoria] WHERE [INTIDCATEGORIA] = @INTIDCATEGORIA" 
        InsertCommand="INSERT INTO [categoria] ([VCHNOMBRE], [VCHDESCRIPCION]) VALUES (@VCHNOMBRE, @VCHDESCRIPCION)"
        UpdateCommand="UPDATE [categoria] SET [VCHNOMBRE] = @VCHNOMBRE, [VCHDESCRIPCION] = @VCHDESCRIPCION WHERE [INTIDCATEGORIA] = @INTIDCATEGORIA " 
        OnDeleted="SQLDSCategorias_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="INTIDCATEGORIA" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="VCHDESCRIPCION" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="VCHDESCRIPCION" Type="String" />
            <asp:Parameter Name="INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_VCHDESCRIPCION" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
     <h1>Categorias</h1>
     <asp:ListView ID="lvCategorias" runat="server" DataKeyNames="INTIDCATEGORIA" DataSourceID="SQLDSCategorias" InsertItemPosition="LastItem">
         
         <EditItemTemplate>
             <tr class="itemRowAlt">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" CssClass="btn btn-success" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" CssClass="btn btn-outline-danger" />
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
             <table runat="server" class="table table-bordered table-striped table-responsive" >
                 <tr>
                     <td>Sin categorias registradas</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr class="itemRowAlt">
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" CssClass="btn btn-success"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" CssClass="btn btn-outline-warning"/>
                 </td>
                 <td>&nbsp;</td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>' MaxLength="45" />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHDESCRIPCIONTextBox" runat="server" Text='<%# Bind("VCHDESCRIPCION") %>'  MaxLength="45" />
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr>
                 <td>
                     <asp:HyperLink ID="lnkCategoriaID" runat="server" Text="Asignar cartas" Target="_blank" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "INTIDCATEGORIA","CartasdeCategoria.aspx?IDcategoria={0}") %>' CssClass="btn btn-link"></asp:HyperLink>
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" CssClass="btn btn-primary"/>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false" CssClass="btn btn-danger"/>
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
                         <table id="itemPlaceholderContainer" runat="server" class="table table-bordered table-striped table-responsive" >
                             <tr>
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
                     <td runat="server" class="bottomPager">
                         <asp:DataPager ID="DataPager1" runat="server">
                             <Fields>
                                 <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info" />
                                 <asp:NumericPagerField  RenderNonBreakingSpacesBetweenControls="true" />
                                 <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info"/>
                             </Fields>
                         </asp:DataPager>
                     </td>
                 </tr>
             </table>
         </LayoutTemplate>
         <SelectedItemTemplate>
             <tr>
                 <td>
                     <asp:Button ID="btnAssignCartastoCategoria" runat="server" CommandName="Select" Text="Asignar Categorias" />
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false" CssClass="btn btn-danger"/>
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