<%@ Page Title="Ver Usuarios" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Usuarios.aspx.cs" Inherits="Admin_Usuarios" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [usuario]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [usuario] WHERE [INTCVEUSUARIO] = @original_INTCVEUSUARIO AND [VCHUSUARIO] = @original_VCHUSUARIO AND [VCHPASSWORD] = @original_VCHPASSWORD AND [CHRTIPOUSUARIO] = @original_CHRTIPOUSUARIO" InsertCommand="INSERT INTO [usuario] ([VCHUSUARIO], [VCHPASSWORD], [CHRTIPOUSUARIO]) VALUES (@VCHUSUARIO, @VCHPASSWORD, @CHRTIPOUSUARIO)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [usuario] SET [VCHUSUARIO] = @VCHUSUARIO, [VCHPASSWORD] = @VCHPASSWORD, [CHRTIPOUSUARIO] = @CHRTIPOUSUARIO WHERE [INTCVEUSUARIO] = @original_INTCVEUSUARIO AND [VCHUSUARIO] = @original_VCHUSUARIO AND [VCHPASSWORD] = @original_VCHPASSWORD AND [CHRTIPOUSUARIO] = @original_CHRTIPOUSUARIO" OnDeleted="SQLDSUsuarios_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="original_INTCVEUSUARIO" Type="Int32" />
            <asp:Parameter Name="original_VCHUSUARIO" Type="String" />
            <asp:Parameter Name="original_VCHPASSWORD" Type="String" />
            <asp:Parameter Name="original_CHRTIPOUSUARIO" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="VCHUSUARIO" Type="String" />
            <asp:Parameter Name="VCHPASSWORD" Type="String" />
            <asp:Parameter Name="CHRTIPOUSUARIO" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="VCHUSUARIO" Type="String" />
            <asp:Parameter Name="VCHPASSWORD" Type="String" />
            <asp:Parameter Name="CHRTIPOUSUARIO" Type="String" />
            <asp:Parameter Name="original_INTCVEUSUARIO" Type="Int32" />
            <asp:Parameter Name="original_VCHUSUARIO" Type="String" />
            <asp:Parameter Name="original_VCHPASSWORD" Type="String" />
            <asp:Parameter Name="original_CHRTIPOUSUARIO" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
     
     <h1>Usuarios</h1>
     
     <asp:ListView ID="lvUsuarios" runat="server" DataSourceID="SQLDSUsuarios" InsertItemPosition="LastItem" DataKeyNames="INTCVEUSUARIO" >
         <EditItemTemplate>
             <tr class="itemRowAlt">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" OnClick="UpdateButton_Click" CssClass="btn btn-success"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" CssClass="btn btn-outline-danger"/>
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel1" runat="server" Text='<%# Eval("INTCVEUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHUSUARIOTextBox" runat="server" Text='<%# Bind("VCHUSUARIO") %>'  MaxLength="45"/>
                 </td>
                 <td>
                     <asp:TextBox ID="VCHPASSWORDTextBox" runat="server" Text='<%# Bind("VCHPASSWORD") %>'  MaxLength="45"/>
                 </td>
                 <td>
                        <asp:DropDownList ID="ddlUserType" runat="server">
                         <asp:ListItem Value="J">Jugador</asp:ListItem>
                         <asp:ListItem Value="A">Administrador</asp:ListItem>
                    </asp:DropDownList>
                     <asp:TextBox ID="CHRTIPOUSUARIOTextBox" runat="server" Text='<%# Bind("CHRTIPOUSUARIO") %>' Visible="false"/>
                 </td>
             </tr>
         </EditItemTemplate>
         <EmptyDataTemplate>
             <table runat="server">
                 <tr>
                     <td>No datos fueron regresado.</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr class="itemRowAlt">
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" OnClick="InsertButton_Click" CssClass="btn btn-success"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" CssClass="btn btn-outline-warning"/>
                 </td>
                 <td>
                     &nbsp;</td>
                 <td>
                     <asp:TextBox ID="VCHUSUARIOTextBox" runat="server" Text='<%# Bind("VCHUSUARIO") %>'  MaxLength="45"/>
                 </td>
                 <td>
                     <asp:TextBox ID="VCHPASSWORDTextBox" runat="server" Text='<%# Bind("VCHPASSWORD") %>' MaxLength="45"/>

                 </td>
                 <td>
                     <asp:DropDownList ID="ddlUserType" runat="server" >
                         <asp:ListItem Value="J">Jugador</asp:ListItem>
                         <asp:ListItem Value="A">Administrador</asp:ListItem>
                    </asp:DropDownList>
                     <asp:TextBox ID="CHRTIPOUSUARIOTextBox" runat="server" Text='<%# Bind("CHRTIPOUSUARIO") %>' Visible="false"/>
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr>
                 <td>
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" CssClass="btn btn-primary"/>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClick="DeleteButton_Click" OnClientClick="if(!confirm('Desea borrarlo?')) return false" CssClass="btn btn-danger"/>
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel" runat="server" Text='<%# Eval("INTCVEUSUARIO") %>' />
                 </td>
                 <td>                         
                     <asp:Label ID="VCHUSUARIOLabel" runat="server" Text='<%# Eval("VCHUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHPASSWORDLabel" runat="server" Text="*****" />
                     
                 </td>
                 <td>
                     <asp:Label ID="CHRTIPOUSUARIOLabel" runat="server" Text='<%# (Eval("CHRTIPOUSUARIO").Equals("A"))? "Administrador" : "Jugador" %>' />
                 </td>
             </tr>
         </ItemTemplate>
         <LayoutTemplate>
             <table runat="server">
                 <tr runat="server">
                     <td runat="server">
                         <table id="itemPlaceholderContainer" class="table table-bordered table-striped table-responsive" >
                             <tr runat="server">
                                 <th runat="server"></th>
                                 <th runat="server">ID Usuario</th>
                                 <th runat="server">Nombre de usuario</th>
                                 <th runat="server">Clave</th>
                                 <th runat="server">Tipo de usuario</th>
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
             <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete"/>
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel" runat="server" Text='<%# Eval("INTCVEUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHUSUARIOLabel" runat="server" Text='<%# Eval("VCHUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHPASSWORDLabel" runat="server" Text='<%# Eval("VCHPASSWORD") %>' />
                 </td>
                 <td>
                     <asp:Label ID="CHRTIPOUSUARIOLabel" runat="server" Text='<%# Eval("CHRTIPOUSUARIO") %>' />
                 </td>
             </tr>
         </SelectedItemTemplate>
    </asp:ListView>
     </asp:Content>