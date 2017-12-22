<%@ Page Title="Ver Categorias Del Jugador" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="CategoriasDelJugador.aspx.cs" Inherits="Admin_CategoriasDelJugador" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SQLDSCategoriasDelJugador" runat="server" ConnectionString="<%$ ConnectionStrings:SQLServer_loteria %>" SelectCommand="SELECT * FROM [detallejuego]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [detallejuego] WHERE [INTIDDETALLE] = @original_INTIDDETALLE AND [INTCVECARTA] = @original_INTCVECARTA AND [INTIDJUEGO] = @original_INTIDJUEGO AND [USASONIDO] = @original_USASONIDO AND [USAIMAGEN] = @original_USAIMAGEN AND [CORRECTO] = @original_CORRECTO" InsertCommand="INSERT INTO [detallejuego] ([INTIDDETALLE], [INTCVECARTA], [INTIDJUEGO], [USASONIDO], [USAIMAGEN], [CORRECTO]) VALUES (@INTIDDETALLE, @INTCVECARTA, @INTIDJUEGO, @USASONIDO, @USAIMAGEN, @CORRECTO)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [detallejuego] SET [INTIDJUEGO] = @INTIDJUEGO, [USASONIDO] = @USASONIDO, [USAIMAGEN] = @USAIMAGEN, [CORRECTO] = @CORRECTO WHERE [INTIDDETALLE] = @original_INTIDDETALLE AND [INTCVECARTA] = @original_INTCVECARTA AND [INTIDJUEGO] = @original_INTIDJUEGO AND [USASONIDO] = @original_USASONIDO AND [USAIMAGEN] = @original_USAIMAGEN AND [CORRECTO] = @original_CORRECTO">
        <DeleteParameters>
            <asp:Parameter Name="original_INTIDDETALLE" Type="Int32" />
            <asp:Parameter Name="original_INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="original_INTIDJUEGO" Type="Int32" />
            <asp:Parameter Name="original_USASONIDO" Type="Int16" />
            <asp:Parameter Name="original_USAIMAGEN" Type="Int16" />
            <asp:Parameter Name="original_CORRECTO" Type="Int16" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="INTIDDETALLE" Type="Int32" />
            <asp:Parameter Name="INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="INTIDJUEGO" Type="Int32" />
            <asp:Parameter Name="USASONIDO" Type="Int16" />
            <asp:Parameter Name="USAIMAGEN" Type="Int16" />
            <asp:Parameter Name="CORRECTO" Type="Int16" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="INTIDJUEGO" Type="Int32" />
            <asp:Parameter Name="USASONIDO" Type="Int16" />
            <asp:Parameter Name="USAIMAGEN" Type="Int16" />
            <asp:Parameter Name="CORRECTO" Type="Int16" />
            <asp:Parameter Name="original_INTIDDETALLE" Type="Int32" />
            <asp:Parameter Name="original_INTCVECARTA" Type="Int32" />
            <asp:Parameter Name="original_INTIDJUEGO" Type="Int32" />
            <asp:Parameter Name="original_USASONIDO" Type="Int16" />
            <asp:Parameter Name="original_USAIMAGEN" Type="Int16" />
            <asp:Parameter Name="original_CORRECTO" Type="Int16" />
        </UpdateParameters>
    </asp:SqlDataSource>
     <asp:ListView ID="ListView1" runat="server" DataKeyNames="INTIDDETALLE,INTCVECARTA" DataSourceID="SQLDSCategoriasDelJugador" InsertItemPosition="LastItem">
         <AlternatingItemTemplate>
             <tr style="background-color:#FFF8DC;">
                 <td>
                     <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                     <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                 </td>
                 <td>
                     <asp:Label ID="INTIDDETALLELabel" runat="server" Text='<%# Eval("INTIDDETALLE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="USASONIDOLabel" runat="server" Text='<%# Eval("USASONIDO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="USAIMAGENLabel" runat="server" Text='<%# Eval("USAIMAGEN") %>' />
                 </td>
                 <td>
                     <asp:Label ID="CORRECTOLabel" runat="server" Text='<%# Eval("CORRECTO") %>' />
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
                     <asp:Label ID="INTIDDETALLELabel1" runat="server" Text='<%# Eval("INTIDDETALLE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel1" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="INTIDJUEGOTextBox" runat="server" Text='<%# Bind("INTIDJUEGO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="USASONIDOTextBox" runat="server" Text='<%# Bind("USASONIDO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="USAIMAGENTextBox" runat="server" Text='<%# Bind("USAIMAGEN") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="CORRECTOTextBox" runat="server" Text='<%# Bind("CORRECTO") %>' />
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
                 <td>
                     <asp:TextBox ID="INTIDDETALLETextBox" runat="server" Text='<%# Bind("INTIDDETALLE") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="INTCVECARTATextBox" runat="server" Text='<%# Bind("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="INTIDJUEGOTextBox" runat="server" Text='<%# Bind("INTIDJUEGO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="USASONIDOTextBox" runat="server" Text='<%# Bind("USASONIDO") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="USAIMAGENTextBox" runat="server" Text='<%# Bind("USAIMAGEN") %>' />
                 </td>
                 <td>
                     <asp:TextBox ID="CORRECTOTextBox" runat="server" Text='<%# Bind("CORRECTO") %>' />
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
                     <asp:Label ID="INTIDDETALLELabel" runat="server" Text='<%# Eval("INTIDDETALLE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="USASONIDOLabel" runat="server" Text='<%# Eval("USASONIDO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="USAIMAGENLabel" runat="server" Text='<%# Eval("USAIMAGEN") %>' />
                 </td>
                 <td>
                     <asp:Label ID="CORRECTOLabel" runat="server" Text='<%# Eval("CORRECTO") %>' />
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
                                 <th runat="server">INTIDDETALLE</th>
                                 <th runat="server">INTCVECARTA</th>
                                 <th runat="server">INTIDJUEGO</th>
                                 <th runat="server">USASONIDO</th>
                                 <th runat="server">USAIMAGEN</th>
                                 <th runat="server">CORRECTO</th>
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
                     <asp:Label ID="INTIDDETALLELabel" runat="server" Text='<%# Eval("INTIDDETALLE") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTCVECARTALabel" runat="server" Text='<%# Eval("INTCVECARTA") %>' />
                 </td>
                 <td>
                     <asp:Label ID="INTIDJUEGOLabel" runat="server" Text='<%# Eval("INTIDJUEGO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="USASONIDOLabel" runat="server" Text='<%# Eval("USASONIDO") %>' />
                 </td>
                 <td>
                     <asp:Label ID="USAIMAGENLabel" runat="server" Text='<%# Eval("USAIMAGEN") %>' />
                 </td>
                 <td>
                     <asp:Label ID="CORRECTOLabel" runat="server" Text='<%# Eval("CORRECTO") %>' />
                 </td>
             </tr>
         </SelectedItemTemplate>
    </asp:ListView>
</asp:Content>