<%@ Page Title="Ver Categorias Del Jugador" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CategoriasDelJugador.aspx.cs" Inherits="Admin_CategoriasDelJugador" %>


<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1 id="h1Title" runat="server">h1Title</h1>

     <asp:TextBox ID="INTIDCATEGORIATextBox" runat="server" Text='<%# Bind("INTIDCATEGORIA") %>' Visible="false"/>
                     <asp:DropDownList ID="ddlCategorias" runat="server" DataSourceID="SQLDSCategorias" DataTextField="nameCategoria" DataValueField="INTIDCATEGORIA" Visible="false">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SQLDSCategorias" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
                        SelectCommand="SELECT CONCAT([INTIDCATEGORIA], '-', [VCHNOMBRE]) as nameCategoria, [INTIDCATEGORIA] FROM [categoria] 
                        WHERE [INTIDCATEGORIA] NOT IN (SELECT INTIDCATEGORIA FROM categoriasDeJugador WHERE ([INTCVEJUGADOR] =  CASE WHEN  @INTCVEJUGADOR > 0 THEN @INTCVEJUGADOR ELSE [INTCVEJUGADOR] END ))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hidIDJugador" DefaultValue="0" Name="INTCVEJUGADOR" PropertyName="Value"/>
                        </SelectParameters>
                    </asp:SqlDataSource>
                      <asp:HiddenField ID="hidIDJugador" runat="server" ViewStateMode="Enabled"/>
    

    
    
    <asp:SqlDataSource ID="SQLDSCategoriasDelJugador" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        SelectCommand="SELECT CONCAT(c.INTIDCATEGORIA,'-',c.VCHNOMBRE) as nombreCategoria, 
        c.INTIDCATEGORIA, CONCAT(j.INTCVEJUGADOR,'-',j.VCHNOMBRE) as nombreJugador, 
        j.INTCVEJUGADOR, cdj.INTIDPESO, cdj.BOOLACTIVO
        FROM [categoriasdejugador] as cdj
        JOIN [jugador] as j
        ON j.INTCVEJUGADOR = cdj.INTCVEJUGADOR
        JOIN categoria as c
        ON c.INTIDCATEGORIA = cdj.INTIDCATEGORIA 
        WHERE (cdj.[INTCVEJUGADOR] =  CASE WHEN  @INTCVEJUGADOR > 0 THEN @INTCVEJUGADOR ELSE cdj.[INTCVEJUGADOR] END )"  
        DeleteCommand="DELETE FROM [categoriasdejugador] WHERE [INTIDCATEGORIA] = @original_INTIDCATEGORIA AND [INTCVEJUGADOR] = @original_INTCVEJUGADOR"
        InsertCommand="INSERT INTO [categoriasdejugador] ([INTIDCATEGORIA], [INTCVEJUGADOR], [INTIDPESO], [BOOLACTIVO]) VALUES (@INTIDCATEGORIA, @INTCVEJUGADOR, @INTIDPESO, @BOOLACTIVO)" 
        OldValuesParameterFormatString="original_{0}" 
        UpdateCommand="UPDATE [categoriasdejugador] SET [INTIDPESO] = @INTIDPESO, [BOOLACTIVO] = @BOOLACTIVO WHERE [INTIDCATEGORIA] = @original_INTIDCATEGORIA AND [INTCVEJUGADOR] = @original_INTCVEJUGADOR">
        <DeleteParameters>
            <asp:Parameter Name="original_INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="original_INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter Name="original_INTIDPESO" Type="Int32" />
            <asp:Parameter Name="original_BOOLACTIVO" Type="Int16" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter Name="INTIDPESO" Type="Int32" />
            <asp:Parameter Name="BOOLACTIVO" Type="Int16" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="INTCVEJUGADOR" QueryStringField="idJugador" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="INTIDPESO" Type="Int32" />
            <asp:Parameter Name="BOOLACTIVO" Type="Int16" />
            <asp:Parameter Name="original_INTIDCATEGORIA" Type="Int32" />
            <asp:Parameter Name="original_INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter Name="original_INTIDPESO" Type="Int32" />
            <asp:Parameter Name="original_BOOLACTIVO" Type="Int16" />
        </UpdateParameters>
    </asp:SqlDataSource>
     <asp:ListView ID="lvCategoriasDelJugador" runat="server" DataKeyNames="INTIDCATEGORIA,INTCVEJUGADOR" DataSourceID="SQLDSCategoriasDelJugador" InsertItemPosition="LastItem">
         <EditItemTemplate>
             <tr class="itemRowAlt">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" OnClick="UpdateButton_Click" CssClass="btn btn-success"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" CssClass="btn btn-outline-danger"/>
                 </td>
                 
                 <td>
                     <asp:Label ID="INTCVEJUGADORLabel1" runat="server" Text='<%# Eval("nombreJugador") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel1" runat="server" Text='<%# Eval("nombreCategoria") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="txtSlider" runat="server" Enabled="false" Width="15pt"></asp:TextBox>
                    <asp:TextBox ID="INTIDPESOTextBox" runat="server" Text='<%# Bind("INTIDPESO") %>' />
                    <ajaxToolkit:SliderExtender ID="INTIDPESOTextBox_SliderExtender" runat="server" BehaviorID="INTIDPESOTextBox_SliderExtender" 
                        Maximum="9" Minimum="1" TargetControlID="INTIDPESOTextBox" BoundControlID="txtSlider" Steps="9" />
                 </td>
                 <td>
                     
                     <asp:CheckBox ID="ckbActivo" runat="server" Text="¿Activo?" Checked='<%# Eval("BOOLACTIVO").ToString().Equals("1")? true:false %>' />
                    <ajaxToolkit:BalloonPopupExtender ID="ckbActivo_BalloonPopupExtender" runat="server" BehaviorID="ckbActivo_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="ckbActivo" BalloonPopupControlID="lblMessagetoPopUp" DisplayOnMouseOver="true">
                    </ajaxToolkit:BalloonPopupExtender>
                    <asp:Label ID="lblMessagetoPopUp" runat="server" Text="Si esta activo aparece como opcion para la sesion para el jugador"></asp:Label>
                     <asp:TextBox ID="BOOLACTIVOTextBox" runat="server" Text='<%# Bind("BOOLACTIVO") %>' Visible="false"/>
                 </td>
             </tr>
         </EditItemTemplate>
         <EmptyDataTemplate>
             <table runat="server" class="table table-bordered table-striped table-responsive">
                 <tr>
                     <td>No datos a mostrar.</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr style="">
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" OnClick="InsertButton_Click" CssClass="btn btn-success"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" CssClass="btn btn-outline-warning" />
                 </td>
                
                 <td>
                     <asp:TextBox ID="INTCVEJUGADORTextBox" runat="server" Text='<%# Bind("INTCVEJUGADOR") %>' Visible="false"/>
                     <asp:DropDownList ID="ddlJugadores" runat="server" DataSourceID="SQLDSJugadores" DataTextField="nameJugador" DataValueField="INTCVEJUGADOR" OnDataBound="ddlJugadores_DataBound" OnSelectedIndexChanged="ddlJugadores_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SQLDSJugadores" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT CONCAT([INTCVEJUGADOR],'-', [VCHNOMBRE]) as nameJugador, [INTCVEJUGADOR] FROM [jugador]"></asp:SqlDataSource>
                 </td>
                  <td>
                      
                      <asp:TextBox ID="INTIDCATEGORIATextBox" runat="server" Text='<%# Bind("INTIDCATEGORIA") %>' Visible="false"/>
                     <asp:DropDownList ID="ddlCategorias" runat="server" DataSourceID="SQLDSCategorias" DataTextField="nameCategoria" DataValueField="INTIDCATEGORIA">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SQLDSCategorias" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
                        SelectCommand="SELECT CONCAT([INTIDCATEGORIA], '-', [VCHNOMBRE]) as nameCategoria, [INTIDCATEGORIA] FROM [categoria] 
                        WHERE [INTIDCATEGORIA] NOT IN (SELECT INTIDCATEGORIA FROM categoriasDeJugador WHERE ([INTCVEJUGADOR] =  CASE WHEN  @INTCVEJUGADOR > 0 THEN @INTCVEJUGADOR ELSE [INTCVEJUGADOR] END ))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hidIDJugador" DefaultValue="0" Name="INTCVEJUGADOR" PropertyName="Value"/>
                        </SelectParameters>
                    </asp:SqlDataSource>
                      <asp:HiddenField ID="hidIDJugador" runat="server" />
                 </td>

                 <td>
                     <asp:TextBox ID="txtSlider" runat="server" Enabled="false" Width="15pt"></asp:TextBox>
                    <asp:TextBox ID="INTIDPESOTextBox" runat="server" Text='<%# Bind("INTIDPESO") %>' />
                    <ajaxToolkit:SliderExtender ID="INTIDPESOTextBox_SliderExtender" runat="server" BehaviorID="INTIDPESOTextBox_SliderExtender" 
                        Maximum="9" Minimum="1" TargetControlID="INTIDPESOTextBox" BoundControlID="txtSlider" Steps="9" />
                 </td>
                 <td>
                     <asp:TextBox ID="BOOLACTIVOTextBox" runat="server" Text='<%# Bind("BOOLACTIVO") %>' Visible="false"/>
                     <asp:CheckBox ID="ckbActivo" runat="server" Text="¿Activo?" Checked="True" />
                    <ajaxToolkit:BalloonPopupExtender ID="ckbActivo_BalloonPopupExtender" runat="server" BehaviorID="ckbActivo_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="ckbActivo" BalloonPopupControlID="lblMessagetoPopUp" DisplayOnMouseOver="true">
                    </ajaxToolkit:BalloonPopupExtender>
                    <asp:Label ID="lblMessagetoPopUp" runat="server" Text="Si esta activo aparece como opcion para la sesion para el jugador"></asp:Label>
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr>
                 <td>
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" CssClass="btn btn-primary"/>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false" CssClass="btn btn-danger"/>
                 </td>
                 <td>
                     <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("nombreJugador") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel" runat="server" Text='<%# Eval("nombreCategoria") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTIDPESOLabel" runat="server" Text='<%# Eval("INTIDPESO") %>' />
                 </td>
                 <td>
                     <!--<asp:Label ID="BOOLACTIVOLabel" runat="server" Text='<%# Eval("BOOLACTIVO").ToString().Equals("1")? "true":"false" %>' />-->
                     <asp:CheckBox ID="ckbActivo" runat="server" Enabled="false" Text="" Checked='<%# Eval("BOOLACTIVO").ToString().Equals("1")? true:false %>' />
                 </td>
             </tr>
         </ItemTemplate>
         <LayoutTemplate>
             <table runat="server">
                 <tr runat="server">
                     <td runat="server">
                         <table id="itemPlaceholderContainer" runat="server" class="table table-bordered table-striped table-responsive">
                             <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                 <th runat="server"></th>
                                 <th runat="server">Jugador</th>
                                 <th runat="server">Categoria</th>
                                 <th runat="server">Peso/Probabilidad</th>
                                 <th runat="server">¿Activo?</th>
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
             <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("INTCVEJUGADOR") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTIDCATEGORIALabel" runat="server" Text='<%# Eval("INTIDCATEGORIA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTIDPESOLabel" runat="server" Text='<%# Eval("INTIDPESO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="BOOLACTIVOLabel" runat="server" Text='<%# Eval("BOOLACTIVO") %>' />
                 </td>
             </tr>
         </SelectedItemTemplate>
    </asp:ListView>
</asp:Content>