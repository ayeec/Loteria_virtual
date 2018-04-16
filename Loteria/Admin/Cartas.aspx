<%@ Page Title="Ver Cartas" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Cartas.aspx.cs" Inherits="Admin_Cartas" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCartas" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        SelectCommand="SELECT * FROM [cartas]" 
        DeleteCommand="DELETE FROM [cartas] WHERE [INTCVECARTA] = @original_INTCVECARTA " 
        InsertCommand="INSERT INTO [cartas] ([VCHNOMBRE], [RUTAIMAGEN]) VALUES (@VCHNOMBRE, @RUTAIMAGEN)" OldValuesParameterFormatString="original_{0}" 
        UpdateCommand="UPDATE [cartas] SET [VCHNOMBRE] = @VCHNOMBRE, [RUTAIMAGEN] = @RUTAIMAGEN  WHERE [INTCVECARTA] = @original_INTCVECARTA AND [VCHNOMBRE] = @original_VCHNOMBRE AND (([RUTAIMAGEN] = @original_RUTAIMAGEN) OR ([RUTAIMAGEN] IS NULL AND @original_RUTAIMAGEN IS NULL))" 
        OnDeleted="SQLDSCartas_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="original_INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_RUTAIMAGEN" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="RUTAIMAGEN" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="RUTAIMAGEN" Type="String" />
            <asp:Parameter Name="VCHTEXTO" Type="String" />
            <asp:Parameter Name="original_INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_RUTAIMAGEN" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
     <h1 id="h1Main">Cartas</h1>
    
     <asp:ListView ID="lvCartas" runat="server" DataKeyNames="INTCVECARTA" DataSourceID="SQLDSCartas" InsertItemPosition="LastItem" OnItemInserted="lvCartas_ItemInserted">
         
         <EditItemTemplate>
             <tr class="itemRowAlt">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" OnClick="UpdateButton_Click" CssClass="btn btn-success"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" CssClass="btn btn-outline-danger"/>
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
             </tr>
         </EditItemTemplate>
         <EmptyDataTemplate>
             <table class="table table-bordered table-striped table-responsive">
                 <tr>
                     <td>No hay Cartas en el sistema.</td>
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
                     </td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>' MaxLength="45" Width="100%" />
                 </td>
                 <td>
                     <asp:TextBox ID="RUTAIMAGENTextBox" runat="server" Text='<%# Bind("RUTAIMAGEN") %>'  Visible="false"/>
                     
                     <asp:FileUpload ID="filUpImageInsert" runat="server"/>
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr>
                 <td>
                     <asp:HyperLink ID="lnkCartaID" runat="server" Text="Asignar Frases" Target="_blank" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "INTCVECARTA","Frases.aspx?IDCarta={0}") %>' CssClass="btn btn-link"></asp:HyperLink>
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" CssClass="btn btn-primary" />
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false" CssClass="btn btn-danger"/>
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHNOMBRELabel" runat="server" Text='<%# Eval("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:Image ID="VCHNOMBREImage" runat="server" ImageUrl='<%# Eval("RUTAIMAGEN","~/images/{0}") %>' AlternateText='<%# Eval("VCHNOMBRE") %>' Width="50%"/>
                 </td>
             </tr>
         </ItemTemplate>
         <LayoutTemplate>
             <table runat="server">
                 <tr runat="server">
                     <td runat="server">
                         <table id="itemPlaceholderContainer" runat="server" class="table table-bordered table-striped table-responsive" >
                             <thead>
                             <tr runat="server">
                                 <th></th>
                                 <th runat="server">ID Carta</th>
                                 <th runat="server">Nombre</th>
                                 <th runat="server">Imagen</th>
                                 <th></th>
                             </tr>
                                 </thead>
                             <tbody>

                             <tr id="itemPlaceholder" runat="server">
                             </tr>
                                </tbody> 
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
    </asp:ListView>
     </asp:Content>