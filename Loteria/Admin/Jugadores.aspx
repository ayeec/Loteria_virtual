<%@ Page Title="Ver Jugadores" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Jugadores.aspx.cs" Inherits="Admin_Jugadores" %>


<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSJugadores" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
        SelectCommand="SELECT CONCAT(u.INTCVEUSUARIO,'-', u.VCHUSUARIO) as nombreUsuario , CONCAT(j.INTCVEJUGADOR, '-', j.VCHNOMBRE) as nombreJugador, j.INTCVEJUGADOR, j.INTCVEUSUARIO, j.VCHNOMBRE, j.GENERO, j.GRADO, j.FECHANACIMIENTO, j.FECHAINSCRIPCION
        FROM [jugador] as j
        JOIN USUARIO as u
        ON u.INTCVEUSUARIO = j.INTCVEUSUARIO" 
        DeleteCommand="DELETE FROM [jugador] WHERE [INTCVEJUGADOR] = @original_INTCVEJUGADOR AND [INTCVEUSUARIO] = @original_INTCVEUSUARIO" 
        InsertCommand="INSERT INTO [jugador] ([INTCVEUSUARIO], [VCHNOMBRE], [GENERO], [GRADO], [FECHANACIMIENTO], [FECHAINSCRIPCION]) VALUES (@INTCVEUSUARIO, @VCHNOMBRE, @GENERO, @GRADO, @FECHANACIMIENTO, @FECHAINSCRIPCION)"     
        UpdateCommand="UPDATE [jugador] SET [INTCVEUSUARIO] = @INTCVEUSUARIO, [VCHNOMBRE] = @VCHNOMBRE, [GENERO] = @GENERO, [GRADO] = @GRADO, [FECHANACIMIENTO] = @FECHANACIMIENTO, [FECHAINSCRIPCION] = @FECHAINSCRIPCION WHERE [INTCVEJUGADOR] = @original_INTCVEJUGADOR AND [INTCVEUSUARIO] = @original_INTCVEUSUARIO " OnDeleted="SQLDSJugadores_Deleted">
        <DeleteParameters>
            <asp:Parameter Name="original_INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter Name="original_INTCVEUSUARIO" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_GENERO" Type="String" />
            <asp:Parameter Name="original_GRADO" Type="Int32" />
            <asp:Parameter DbType="DateTime2" Name="original_FECHANACIMIENTO" />
            <asp:Parameter DbType="DateTime2" Name="original_FECHAINSCRIPCION" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="INTCVEUSUARIO" Type="Int32" />
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="GENERO" Type="String" />
            <asp:Parameter Name="GRADO" Type="Int32" />
            <asp:Parameter DbType="DateTime2" Name="FECHANACIMIENTO" />
            <asp:Parameter DbType="DateTime2" Name="FECHAINSCRIPCION" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="INTCVEUSUARIO" Type="Int32" />
            <asp:Parameter Name="VCHNOMBRE" Type="String" />
            <asp:Parameter Name="GENERO" Type="String" />
            <asp:Parameter Name="GRADO" Type="Int32" />
            <asp:Parameter DbType="DateTime2" Name="FECHANACIMIENTO" />
            <asp:Parameter DbType="DateTime2" Name="FECHAINSCRIPCION" />
            <asp:Parameter Name="original_INTCVEJUGADOR" Type="Int32" />
            <asp:Parameter Name="original_INTCVEUSUARIO" Type="Int32" />
            <asp:Parameter Name="original_VCHNOMBRE" Type="String" />
            <asp:Parameter Name="original_GENERO" Type="String" />
            <asp:Parameter Name="original_GRADO" Type="Int32" />
            <asp:Parameter DbType="DateTime2" Name="original_FECHANACIMIENTO" />
            <asp:Parameter DbType="DateTime2" Name="original_FECHAINSCRIPCION" />
        </UpdateParameters>
    </asp:SqlDataSource>
     
    
    
   
    
    
     
    
    
   
    
    <h1 id="h1Main">Jugadores</h1>
     
    
    
   
    
    
     
    
    
   
    
    <br />
     <asp:ListView ID="lvJugadores" runat="server" DataKeyNames="INTCVEJUGADOR" DataSourceID="SQLDSJugadores" InsertItemPosition="LastItem">
         <EditItemTemplate>
             <tr class="itemRowAlt">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Actualizar" Text="Update" OnClick="UpdateButton_Click" CssClass="btn btn-success"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" CssClass="btn btn-outline-danger"/>
                 </td>
                 <td>
                     <asp:Label ID="INTCVEJUGADORLabel1" runat="server" Text='<%# Eval("nombreJugador") %>' />
                 </td>
                 <td>
                      <asp:TextBox ID="INTCVEUSUARIOTextBox" runat="server" Text='<%# Bind("INTCVEUSUARIO") %>' Visible="false"/>
                      <asp:DropDownList ID="ddlUsuariosDisponibles" runat="server" DataSourceID="sqlUsuariosDisponibles" DataTextField="usuario_detail" DataValueField="INTCVEUSUARIO">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlUsuariosDisponibles" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
                        SelectCommand="SELECT CONCAT(INTCVEUSUARIO,'-',VCHUSUARIO) usuario_detail,  INTCVEUSUARIO FROM usuario
                    WHERE (INTCVEUSUARIO not in (SELECT INTCVEUSUARIO from jugador ) OR INTCVEUSUARIO = @idUsuario) AND UPPER(CHRTIPOUSUARIO) = 'J'">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="INTCVEUSUARIOTextBox" Name="idUsuario" PropertyName="Text" />
                        </SelectParameters>

                    </asp:SqlDataSource>
     
                 </td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>'  MaxLength="45"/>
                 </td>
                 <td>
                     <asp:TextBox ID="GENEROTextBox" runat="server" Text='<%# Bind("GENERO") %>' Visible="false" />
                     <asp:RadioButtonList ID="rblGenero" runat="server" >
                         <asp:ListItem Value="M" Selected="True">Masculino</asp:ListItem>
                         <asp:ListItem Value="F">Femenino</asp:ListItem>
                    </asp:RadioButtonList>
                 </td>
                 <td>
                     <!--<asp:TextBox ID="GRADOTextBox" runat="server" Text= /> 
                     (entre 1 y 5)<input id="inpGrado" max="5" min="1" name="quantity"  value='<%# Bind("GRADO") %>' runat="server"/>-->
    
                    <asp:TextBox ID="txtSlider" runat="server" Width="15pt" Enabled="false"></asp:TextBox>    
                    <asp:TextBox ID="txtGrade" runat="server" Text='<%# Bind("GRADO") %>' ></asp:TextBox>
                    <ajaxToolkit:SliderExtender ID="txtGrade_SliderExtender" runat="server" TargetControlID="txtGrade" BoundControlID="txtSlider"  Steps="5" Minimum="1" Maximum="5" />
                 </td>
                 <td>
                     <!--<asp:TextBox ID="FECHANACIMIENTOTextBox" runat="server" Text='<%# Bind("FECHANACIMIENTO") %>' />-->
                     <asp:TextBox ID="txtBirthdayPicker" runat="server" Text='<%# Eval("FECHANACIMIENTO", "{0:yyyy-MM-dd}") %>' ></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="txtBirthdayPicker_CalendarExtender" runat="server" TargetControlID="txtBirthdayPicker" Format="yyyy-MM-dd" DefaultView="Years" />
   
                 </td>
                 <td>
                     <asp:TextBox ID="txtSuscriptionDate" runat="server" Enabled="false" OnPreRender="txtSuscriptionDate_PreRender" Text='<%# Bind("FECHAINSCRIPCION") %>' ></asp:TextBox>
                     <ajaxToolkit:CalendarExtender ID="txtSuscriptionDate_CalendarExtender" runat="server" TargetControlID="txtSuscriptionDate" Format="yyyy-MM-dd" DefaultView="Years"/>
                 </td>
             </tr>
         </EditItemTemplate>
         <EmptyDataTemplate>
             <table runat="server" class="table table-bordered table-striped table-responsive">
                 <tr>
                     <td>Sin datos a mostrar.</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr>
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" OnClick="InsertButton_Click" CssClass="btn btn-success"/>
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Limpiar" CssClass="btn btn-outline-warning"/>
                 </td>
                 <td>&nbsp;</td>
                 <td>
                     <asp:TextBox ID="INTCVEUSUARIOTextBox" runat="server" Text='<%# Bind("INTCVEUSUARIO") %>' Visible="false"/>
                      <asp:DropDownList ID="ddlUsuariosDisponibles" runat="server" DataSourceID="sqlUsuariosDisponibles" DataTextField="usuario_detail" DataValueField="INTCVEUSUARIO">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sqlUsuariosDisponibles" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" 
                        SelectCommand="SELECT CONCAT(INTCVEUSUARIO,'-',VCHUSUARIO) usuario_detail,  INTCVEUSUARIO FROM usuario
                    WHERE INTCVEUSUARIO not in (SELECT INTCVEUSUARIO from jugador) AND UPPER(CHRTIPOUSUARIO) = 'J'"></asp:SqlDataSource>
     
                 </td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>'  MaxLength="45"/>
                 </td>
                 <td>
                     <asp:TextBox ID="GENEROTextBox" runat="server" Text='<%# Bind("GENERO") %>' Visible="false" />
                     <asp:RadioButtonList ID="rblGenero" runat="server" >
                         <asp:ListItem Value="M" Selected="True">Masculino</asp:ListItem>
                         <asp:ListItem Value="F">Femenino</asp:ListItem>
                    </asp:RadioButtonList>
                 </td>
                 <td>
                     <!--<asp:TextBox ID="GRADOTextBox" runat="server" Text= /> 
                     (entre 1 y 5)<input id="inpGrado" max="5" min="1" name="quantity"  value='<%# Bind("GRADO") %>' runat="server"/>-->
    
                    <asp:TextBox ID="txtSlider" runat="server" Width="15pt" Enabled="false"></asp:TextBox>    
                    <asp:TextBox ID="txtGrade" runat="server" Text='<%# Bind("GRADO") %>' ></asp:TextBox>
                    <ajaxToolkit:SliderExtender ID="txtGrade_SliderExtender" runat="server" TargetControlID="txtGrade" BoundControlID="txtSlider"  Steps="5" Minimum="1" Maximum="5" />
                 </td>
                 <td>
                     <!--<asp:TextBox ID="FECHANACIMIENTOTextBox" runat="server" Text='<%# Bind("FECHANACIMIENTO") %>' />-->
                     <asp:TextBox ID="txtBirthdayPicker" runat="server" Text='<%# Bind("FECHANACIMIENTO") %>' Width="60pt"></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="txtBirthdayPicker_CalendarExtender" runat="server" TargetControlID="txtBirthdayPicker" Format="yyyy-MM-dd" DefaultView="Years"/>
   
                 </td>
                 <td>
                     <asp:TextBox ID="txtSuscriptionDate" runat="server" Enabled="false" OnPreRender="txtSuscriptionDate_PreRender" Text='<%# Bind("FECHAINSCRIPCION") %>'></asp:TextBox>
                     
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr>
                 <td>
                     <asp:HyperLink ID="lnkJugadorID" runat="server" Text="Ver categorias asignadas" Target="_blank" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "INTCVEJUGADOR","CategoriasDelJugador.aspx?idJugador={0}") %>' CssClass="btn btn-link"></asp:HyperLink>
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" CssClass="btn btn-primary"/>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" OnClientClick="if(!confirm('Desea borrarlo?')) return false" CssClass="btn btn-danger"/>
                 </td>
                 <td>
                     <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("nombreJugador") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel" runat="server" Text='<%# Eval("nombreUsuario") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHNOMBRELabel" runat="server" Text='<%# Eval("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="GENEROLabel" runat="server" Text='<%# Eval("GENERO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="GRADOLabel" runat="server" Text='<%# Eval("GRADO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="FECHANACIMIENTOLabel" runat="server" Text='<%# Eval("FECHANACIMIENTO", "{0:yyyy-MM-dd}") %>' />
                 </td>
                 <td>
                     <asp:Label ID="FECHAINSCRIPCIONLabel" runat="server" Text='<%# Eval("FECHAINSCRIPCION", "{0:yyyy-MM-dd}") %>' />
                 </td>
             </tr>
         </ItemTemplate>
         <LayoutTemplate>
             <table runat="server">
                 <tr runat="server">
                     <td runat="server">
                         <table id="itemPlaceholderContainer" runat="server" class="table table-bordered table-striped table-responsive" >
                             <tr runat="server" >
                                 <th runat="server"></th>
                                 <th runat="server">ID Jugador</th>
                                 <th runat="server">ID Usuario</th>
                                 <th runat="server">Nombre</th>
                                 <th runat="server">Genero</th>
                                 <th runat="server">Grado</th>
                                 <th runat="server">Fecha Nacimiento</th>
                                 <th runat="server">Fecha Inscripción</th>
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
             <tr>
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Borrar" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Editar" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEJUGADORLabel" runat="server" Text='<%# Eval("INTCVEJUGADOR") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEUSUARIOLabel" runat="server" Text='<%# Eval("INTCVEUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="VCHNOMBRELabel" runat="server" Text='<%# Eval("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="GENEROLabel" runat="server" Text='<%# Eval("GENERO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="GRADOLabel" runat="server" Text='<%# Eval("GRADO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="FECHANACIMIENTOLabel" runat="server" Text='<%# Eval("FECHANACIMIENTO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="FECHAINSCRIPCIONLabel" runat="server" Text='<%# Eval("FECHAINSCRIPCION") %>' />
                 </td>
             </tr>
         </SelectedItemTemplate>
    </asp:ListView>
</asp:Content>