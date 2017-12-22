<%@ Page Title="Ver Jugadores" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Jugadores.aspx.cs" Inherits="Admin_Jugadores" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSJugadores" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [jugador]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [jugador] WHERE [INTCVEJUGADOR] = @original_INTCVEJUGADOR AND [INTCVEUSUARIO] = @original_INTCVEUSUARIO AND [VCHNOMBRE] = @original_VCHNOMBRE AND (([GENERO] = @original_GENERO) OR ([GENERO] IS NULL AND @original_GENERO IS NULL)) AND (([GRADO] = @original_GRADO) OR ([GRADO] IS NULL AND @original_GRADO IS NULL)) AND [FECHANACIMIENTO] = @original_FECHANACIMIENTO AND [FECHAINSCRIPCION] = @original_FECHAINSCRIPCION" InsertCommand="INSERT INTO [jugador] ([INTCVEUSUARIO], [VCHNOMBRE], [GENERO], [GRADO], [FECHANACIMIENTO], [FECHAINSCRIPCION]) VALUES (@INTCVEUSUARIO, @VCHNOMBRE, @GENERO, @GRADO, @FECHANACIMIENTO, @FECHAINSCRIPCION)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [jugador] SET [INTCVEUSUARIO] = @INTCVEUSUARIO, [VCHNOMBRE] = @VCHNOMBRE, [GENERO] = @GENERO, [GRADO] = @GRADO, [FECHANACIMIENTO] = @FECHANACIMIENTO, [FECHAINSCRIPCION] = @FECHAINSCRIPCION WHERE [INTCVEJUGADOR] = @original_INTCVEJUGADOR AND [INTCVEUSUARIO] = @original_INTCVEUSUARIO AND [VCHNOMBRE] = @original_VCHNOMBRE AND (([GENERO] = @original_GENERO) OR ([GENERO] IS NULL AND @original_GENERO IS NULL)) AND (([GRADO] = @original_GRADO) OR ([GRADO] IS NULL AND @original_GRADO IS NULL)) AND [FECHANACIMIENTO] = @original_FECHANACIMIENTO AND [FECHAINSCRIPCION] = @original_FECHAINSCRIPCION">
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
     <asp:ListView ID="lvJugadores" runat="server" DataKeyNames="INTCVEJUGADOR" DataSourceID="SQLDSJugadores" InsertItemPosition="LastItem">
         <AlternatingItemTemplate>
             <tr style="background-color:#FFF8DC;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
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
         </AlternatingItemTemplate>
         <EditItemTemplate>
             <tr style="background-color:#008A8C;color: #FFFFFF;">
                 <td>
                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                 </td>
                 <td>
                     <asp:Label ID="INTCVEJUGADORLabel1" runat="server" Text='<%# Eval("INTCVEJUGADOR") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="INTCVEUSUARIOTextBox" runat="server" Text='<%# Bind("INTCVEUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="GENEROTextBox" runat="server" Text='<%# Bind("GENERO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="GRADOTextBox" runat="server" Text='<%# Bind("GRADO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="FECHANACIMIENTOTextBox" runat="server" Text='<%# Bind("FECHANACIMIENTO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="FECHAINSCRIPCIONTextBox" runat="server" Text='<%# Bind("FECHAINSCRIPCION") %>' />
                 </td>
             </tr>
         </EditItemTemplate>
         <EmptyDataTemplate>
             <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                 <tr>
                     <td>No data was returned.</td>
                 </tr>
             </table>
         </EmptyDataTemplate>
         <InsertItemTemplate>
             <tr style="">
                 <td>
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                 </td>
                 <td>&nbsp;</td>
                 <td>
                     <asp:TextBox ID="INTCVEUSUARIOTextBox" runat="server" Text='<%# Bind("INTCVEUSUARIO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="VCHNOMBRETextBox" runat="server" Text='<%# Bind("VCHNOMBRE") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="GENEROTextBox" runat="server" Text='<%# Bind("GENERO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="GRADOTextBox" runat="server" Text='<%# Bind("GRADO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="FECHANACIMIENTOTextBox" runat="server" Text='<%# Bind("FECHANACIMIENTO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="FECHAINSCRIPCIONTextBox" runat="server" Text='<%# Bind("FECHAINSCRIPCION") %>' />
                 </td>
             </tr>
         </InsertItemTemplate>
         <ItemTemplate>
             <tr style="background-color:#DCDCDC;color: #000000;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
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
         </ItemTemplate>
         <LayoutTemplate>
             <table runat="server">
                 <tr runat="server">
                     <td runat="server">
                         <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                             <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                 <th runat="server"></th>
                                 <th runat="server">INTCVEJUGADOR</th>
                                 <th runat="server">INTCVEUSUARIO</th>
                                 <th runat="server">VCHNOMBRE</th>
                                 <th runat="server">GENERO</th>
                                 <th runat="server">GRADO</th>
                                 <th runat="server">FECHANACIMIENTO</th>
                                 <th runat="server">FECHAINSCRIPCION</th>
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
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
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